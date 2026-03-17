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
