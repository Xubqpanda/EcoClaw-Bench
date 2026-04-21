#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=common.sh
source "${SCRIPT_DIR}/common.sh"

MODEL="${MODEL:-ecoclaw/gpt-5.4}"
JUDGE="${JUDGE:-ecoclaw/gpt-5.4}"
RUNS="${RUNS:-1}"
PARALLEL="${PARALLEL:-1}"
TIMEOUT_MULTIPLIER="${TIMEOUT_MULTIPLIER:-1.0}"
_default_plugin="${REPO_ROOT}/EcoClaw/packages/openclaw-plugin"
if [[ -z "${ECOCLAW_PLUGIN_PATH:-}" ]]; then
  if [[ -d "${_default_plugin}" ]]; then
    ECOCLAW_PLUGIN_PATH="${_default_plugin}"
  fi
fi

import_dotenv
apply_ecoclaw_env

SKILL_DIR="$(resolve_skill_dir)"
SUITE="$(cd "${SKILL_DIR}" && ls -1 tasks/task_*.md | sed 's#.*/##' | sed 's#.md$##' | grep -v '^TASK_TEMPLATE$' | sort | paste -sd, -)"

echo "[ecoclaw-full] suite=${SUITE}"
echo "[ecoclaw-full] installing+enabling ecoclaw plugin..."
openclaw plugins install -l "${ECOCLAW_PLUGIN_PATH}" >/dev/null 2>&1 || true
openclaw plugins enable ecoclaw >/dev/null 2>&1 || true

"${SCRIPT_DIR}/run_pinchbench_ecoclaw.sh" \
  --model "${MODEL}" \
  --judge "${JUDGE}" \
  --suite "${SUITE}" \
  --runs "${RUNS}" \
  --parallel "${PARALLEL}" \
  --timeout-multiplier "${TIMEOUT_MULTIPLIER}"

echo "[ecoclaw-full] done."
