#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=common.sh
source "${SCRIPT_DIR}/common.sh"

# Ensure nvm is loaded for openclaw CLI
REAL_USER_HOME="$(getent passwd "$(id -un)" 2>/dev/null | cut -d: -f6)"
if [[ -z "${REAL_USER_HOME}" ]]; then
  REAL_USER_HOME="${HOME}"
fi
export NVM_DIR="${NVM_DIR:-${REAL_USER_HOME}/.nvm}"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use 22 >/dev/null 2>&1 || true
if command -v nvm >/dev/null 2>&1; then
  NVM_NODE_PATH="$(nvm which 22 2>/dev/null || true)"
  if [[ -n "${NVM_NODE_PATH}" && "${NVM_NODE_PATH}" != "N/A" ]]; then
    NVM_NODE_BIN="$(dirname "${NVM_NODE_PATH}")"
    export PATH="${NVM_NODE_BIN}:${PATH}"
    hash -r
  fi
fi

MODEL=""
JUDGE=""
SUITE=""
RUNS=""
TIMEOUT_MULTIPLIER=""
PARALLEL=""
ENABLE_MULTI_AGENT=0
MULTI_AGENT_ROLES=""
AGENT_CONFIG=""
TASKS_SUBDIR=""
TASKS_DIR=""
CLEAN_RUNTIME=0
CLEAN_HOME_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --model) MODEL="${2:-}"; shift 2 ;;
    --judge) JUDGE="${2:-}"; shift 2 ;;
    --suite) SUITE="${2:-}"; shift 2 ;;
    --runs) RUNS="${2:-}"; shift 2 ;;
    --timeout-multiplier) TIMEOUT_MULTIPLIER="${2:-}"; shift 2 ;;
    --parallel) PARALLEL="${2:-}"; shift 2 ;;
    --enable-multi-agent) ENABLE_MULTI_AGENT=1; shift ;;
    --multi-agent-roles) MULTI_AGENT_ROLES="${2:-}"; shift 2 ;;
    --agent-config) AGENT_CONFIG="${2:-}"; shift 2 ;;
    --tasks-subdir) TASKS_SUBDIR="${2:-}"; shift 2 ;;
    --tasks-dir) TASKS_DIR="${2:-}"; shift 2 ;;
    --clean-runtime) CLEAN_RUNTIME=1; shift ;;
    --clean-home-dir) CLEAN_HOME_DIR="${2:-}"; shift 2 ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

import_dotenv

if [[ "${CLEAN_RUNTIME}" == "1" ]]; then
  if [[ -z "${CLEAN_HOME_DIR}" ]]; then
    CLEAN_HOME_DIR="/tmp/openclaw_clean_claw_eval_baseline"
  fi
  export ECOCLAW_OPENCLAW_HOME="${CLEAN_HOME_DIR}"
  # Re-normalize HOME/XDG dirs after overriding runtime home.
  normalize_openclaw_runtime_env
  CLEAN_OPENCLAW_DIR="${HOME}/.openclaw"
  CLEAN_OPENCLAW_CONFIG="${CLEAN_OPENCLAW_DIR}/openclaw.json"
  REAL_OPENCLAW_CONFIG="${REAL_USER_HOME}/.openclaw/openclaw.json"
  if [[ ! -f "${CLEAN_OPENCLAW_CONFIG}" && -f "${REAL_OPENCLAW_CONFIG}" ]]; then
    mkdir -p "${CLEAN_OPENCLAW_DIR}"
    cp "${REAL_OPENCLAW_CONFIG}" "${CLEAN_OPENCLAW_CONFIG}"
    echo "Bootstrapped clean runtime config from: ${REAL_OPENCLAW_CONFIG}"
  fi
  echo "Using clean OpenClaw runtime home: ${ECOCLAW_OPENCLAW_HOME}"
fi

apply_ecoclaw_env
ensure_openclaw_gateway_running
recover_stale_openclaw_config_backup

ECOCLAW_WAS_ENABLED=0
if openclaw plugins list 2>/dev/null | grep -qE '│ EcoClaw[[:space:]]+│ ecoclaw[[:space:]]+│ loaded[[:space:]]+│'; then
  ECOCLAW_WAS_ENABLED=1
fi

restore_ecoclaw_plugin() {
  if [[ "${ECOCLAW_WAS_ENABLED}" == "1" ]]; then
    openclaw plugins enable ecoclaw >/dev/null 2>&1 || true
  fi
}

trap restore_ecoclaw_plugin EXIT

openclaw plugins disable ecoclaw >/dev/null 2>&1 || true
# For strict baseline, disable helper plugins that can inject memory/bootstrap behavior.
openclaw config set plugins.entries.baseline-hooks.enabled false >/dev/null 2>&1 || true
openclaw config set plugins.entries.lycheemem-tools.enabled false >/dev/null 2>&1 || true
openclaw config set plugins.entries.openspace-tools.enabled false >/dev/null 2>&1 || true
openclaw config set plugins.entries.lossless-claw.enabled false >/dev/null 2>&1 || true
# Disable internal token hooks that can create SOUL/USER/MEMORY bootstrap flows.
openclaw config set hooks.internal.entries.token-context.enabled false >/dev/null 2>&1 || true
openclaw config set hooks.internal.entries.token-heartbeat.enabled false >/dev/null 2>&1 || true
openclaw gateway restart >/dev/null 2>&1 || true
sleep 2

if [[ -z "${ECOCLAW_SKILL_DIR:-}" && -d "${REPO_ROOT}/claw-eval-skill" ]]; then
  export ECOCLAW_SKILL_DIR="${REPO_ROOT}/claw-eval-skill"
fi
if [[ -z "${ECOCLAW_SKILL_DIR:-}" && -d "${REPO_ROOT}/experiments/dataset/claw_eval" ]]; then
  export ECOCLAW_SKILL_DIR="${REPO_ROOT}/experiments/dataset/claw_eval"
fi

MODEL_LIKE="${MODEL:-${ECOCLAW_MODEL:-tuzi/gpt-5.4}}"
JUDGE_LIKE="${JUDGE:-${ECOCLAW_JUDGE:-tuzi/gpt-5.4}}"
RESOLVED_MODEL="$(resolve_model_alias "${MODEL_LIKE}")"
RESOLVED_JUDGE="$(resolve_model_alias "${JUDGE_LIKE}")"
RESOLVED_SUITE="${SUITE:-${ECOCLAW_SUITE:-all}}"
RESOLVED_RUNS="${RUNS:-${ECOCLAW_RUNS:-1}}"
RESOLVED_TIMEOUT="${TIMEOUT_MULTIPLIER:-${ECOCLAW_TIMEOUT_MULTIPLIER:-1.0}}"
RESOLVED_PARALLEL="${PARALLEL:-${ECOCLAW_PARALLEL:-4}}"

# Multi-agent: resolve from CLI flag or env var
if [[ "${ENABLE_MULTI_AGENT}" == "0" ]] && [[ "${ECOCLAW_ENABLE_MULTI_AGENT:-false}" =~ ^(true|1|yes)$ ]]; then
  ENABLE_MULTI_AGENT=1
fi
RESOLVED_MULTI_AGENT_ROLES="${MULTI_AGENT_ROLES:-${ECOCLAW_MULTI_AGENT_ROLES:-coder,researcher,reviewer}}"
RESOLVED_AGENT_CONFIG="${AGENT_CONFIG:-${ECOCLAW_AGENT_CONFIG:-}}"

# Resolve to absolute path early (before any cd)
if [[ -n "${RESOLVED_AGENT_CONFIG}" ]]; then
  RESOLVED_AGENT_CONFIG="$(cd "$(dirname "${RESOLVED_AGENT_CONFIG}")" && pwd)/$(basename "${RESOLVED_AGENT_CONFIG}")"
fi

# If an agent config is provided, force multi-agent on
if [[ -n "${RESOLVED_AGENT_CONFIG}" ]]; then
  ENABLE_MULTI_AGENT=1
fi

if [[ "${ENABLE_MULTI_AGENT}" == "1" ]]; then
  OUTPUT_DIR="${REPO_ROOT}/results/raw/claw_eval/multi_agent"
else
  OUTPUT_DIR="${REPO_ROOT}/results/raw/claw_eval/baseline"
fi
LOG_DIR="${REPO_ROOT}/log"
RUN_TAG="$(date +%Y%m%d_%H%M%S)"
RUN_LOG_FILE="${LOG_DIR}/claw_eval_baseline_${RUN_TAG}.log"
BENCHMARK_LOG_FILE="${LOG_DIR}/claw_eval_baseline_${RUN_TAG}_benchmark.log"
mkdir -p "${OUTPUT_DIR}" "${LOG_DIR}"

# Multi-agent config injection
if [[ "${ENABLE_MULTI_AGENT}" == "1" ]]; then
  backup_openclaw_config
  if [[ -n "${RESOLVED_AGENT_CONFIG}" ]]; then
    AGENT_CONFIG_DIR="$(cd "$(dirname "${RESOLVED_AGENT_CONFIG}")" && pwd)"
    SKILLS_DIR="${AGENT_CONFIG_DIR}/../skills"
    if [[ -d "${SKILLS_DIR}" ]]; then
      SKILLS_DIR="$(cd "${SKILLS_DIR}" && pwd)"
    else
      SKILLS_DIR=""
    fi
    inject_agent_config_from_file "${RESOLVED_AGENT_CONFIG}" "${SKILLS_DIR}"
  else
    RESOLVED_SUBAGENT_THINKING="${ECOCLAW_SUBAGENT_THINKING:-medium}"
    RESOLVED_SUBAGENT_MAX_CONCURRENT="${ECOCLAW_SUBAGENT_MAX_CONCURRENT:-4}"
    inject_multi_agent_config "${RESOLVED_MODEL}" "${RESOLVED_SUBAGENT_THINKING}" "${RESOLVED_SUBAGENT_MAX_CONCURRENT}"
  fi
fi

# Ensure config is restored on exit (multi-agent) while also restoring ecoclaw plugin
restore_ecoclaw_plugin() {
  if [[ "${ENABLE_MULTI_AGENT}" == "1" ]]; then
    restore_openclaw_config || true
  fi
  if [[ "${ECOCLAW_WAS_ENABLED}" == "1" ]]; then
    openclaw plugins enable ecoclaw >/dev/null 2>&1 || true
  fi
}
trap restore_ecoclaw_plugin EXIT

# Resolve and validate tasks directory
if [[ -n "${TASKS_DIR}" && -n "${TASKS_SUBDIR}" ]]; then
  echo "Please set only one of --tasks-dir or --tasks-subdir" >&2
  exit 1
fi

SKILL_DIR="$(resolve_skill_dir)"
if [[ -n "${TASKS_DIR}" ]]; then
  RESOLVED_TASKS_DIR="${TASKS_DIR}"
elif [[ -n "${TASKS_SUBDIR}" ]]; then
  RESOLVED_TASKS_DIR="${SKILL_DIR}/tasks/${TASKS_SUBDIR}"
else
  RESOLVED_TASKS_DIR="${SKILL_DIR}/tasks"
fi

if [[ ! -d "${RESOLVED_TASKS_DIR}" ]]; then
  echo "Tasks directory not found: ${RESOLVED_TASKS_DIR}" >&2
  exit 1
fi

echo "Resolved benchmark config:"
echo "  tasks_dir=${RESOLVED_TASKS_DIR}"
echo "  suite=${RESOLVED_SUITE}"
echo "  parallel=${RESOLVED_PARALLEL}"
echo "  runs=${RESOLVED_RUNS}"
echo "  model=${RESOLVED_MODEL}"
if [[ -n "${ECOCLAW_SUITE:-}" && -z "${SUITE}" ]]; then
  echo "  note: suite comes from ECOCLAW_SUITE=${ECOCLAW_SUITE}"
fi

# Build benchmark.py arguments
BENCH_ARGS=(
  --tasks-dir "${RESOLVED_TASKS_DIR}"
  --model "${RESOLVED_MODEL}"
  --judge "${RESOLVED_JUDGE}"
  --suite "${RESOLVED_SUITE}"
  --runs "${RESOLVED_RUNS}"
  --parallel "${RESOLVED_PARALLEL}"
  --timeout-multiplier "${RESOLVED_TIMEOUT}"
  --output-dir "${OUTPUT_DIR}"
  --no-upload
)
if [[ "${ENABLE_MULTI_AGENT}" == "1" ]]; then
  BENCH_ARGS+=(--enable-multi-agent)
  if [[ -n "${RESOLVED_AGENT_CONFIG}" ]]; then
    BENCH_ARGS+=(--agent-config "${RESOLVED_AGENT_CONFIG}")
  else
    BENCH_ARGS+=(--multi-agent-roles "${RESOLVED_MULTI_AGENT_ROLES}")
  fi
fi

cd "${SKILL_DIR}"
uv run scripts/benchmark.py "${BENCH_ARGS[@]}" \
  2>&1 | tee "${RUN_LOG_FILE}"

if [[ -f "${SKILL_DIR}/benchmark.log" ]]; then
  cp "${SKILL_DIR}/benchmark.log" "${BENCHMARK_LOG_FILE}"
fi

echo "Run log saved to: ${RUN_LOG_FILE}"
if [[ -f "${BENCHMARK_LOG_FILE}" ]]; then
  echo "Benchmark log saved to: ${BENCHMARK_LOG_FILE}"
fi

RESULT_JSON="$(latest_json_in_dir "${OUTPUT_DIR}" || true)"
if [[ -n "${RESULT_JSON}" ]]; then
  COST_REPORT_DIR="${REPO_ROOT}/results/reports"
  COST_REPORT_FILE="${COST_REPORT_DIR}/claw_eval_baseline_${RUN_TAG}_cost.json"
  mkdir -p "${COST_REPORT_DIR}"
  generate_cost_report_and_print_summary "${RESULT_JSON}" "${COST_REPORT_FILE}"
else
  echo "Cost report skipped: no result JSON found in ${OUTPUT_DIR}" >&2
fi
