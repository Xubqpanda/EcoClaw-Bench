# Usage Guide

This repo supports two evaluation modes:

1. **Baseline**: OpenClaw behavior without EcoClaw optimization modules.
2. **EcoClaw**: OpenClaw behavior with EcoClaw optimization modules enabled.

Both runs should use:

- same model id
- same task suite
- same judge model
- same number of runs

Then compare `results/raw/*` with the provided comparison script.

## Run Commands (Linux)

```bash
./experiments/scripts/run_pinchbench_baseline.sh --suite task_00_sanity --runs 1
./experiments/scripts/run_pinchbench_ecoclaw.sh --suite task_00_sanity --runs 1
./experiments/scripts/compare_pinchbench_results.sh
```
