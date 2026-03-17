# Reproducibility Protocol

## Fixed knobs per experiment

- model id
- judge model id
- suite
- runs per task
- timeout multiplier

## Outputs to persist

- raw benchmark JSON
- command line used
- environment metadata (runtime version, commit hash)

## Recommended comparison metrics

- Overall mean task score
- Total tokens
- Input/output token split
- Total cost (USD)
- Score per 1k tokens
- Score per dollar
