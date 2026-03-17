param(
  [string]$Model = "openrouter/anthropic/claude-sonnet-4",
  [string]$Judge = "openrouter/anthropic/claude-opus-4.5",
  [string]$Suite = "automated-only",
  [int]$Runs = 3,
  [double]$TimeoutMultiplier = 1.0
)

# Ensure EcoClaw optimization modules are enabled in your OpenClaw runtime before this run.
$OutputDir = "D:/EcoClaw-Bench/results/raw/pinchbench/ecoclaw"
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Set-Location D:/skill
uv run scripts/benchmark.py `
  --model $Model `
  --judge $Judge `
  --suite $Suite `
  --runs $Runs `
  --timeout-multiplier $TimeoutMultiplier `
  --output-dir $OutputDir `
  --no-upload
