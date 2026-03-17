param(
  [string]$BaselineDir = "D:/EcoClaw-Bench/results/raw/pinchbench/baseline",
  [string]$EcoClawDir = "D:/EcoClaw-Bench/results/raw/pinchbench/ecoclaw",
  [string]$ReportPath = "D:/EcoClaw-Bench/results/reports/pinchbench_comparison.json"
)

function Get-LatestJson([string]$dir) {
  $files = Get-ChildItem -Path $dir -Filter *.json -File | Sort-Object LastWriteTime -Descending
  if ($files.Count -eq 0) { throw "No JSON files found in $dir" }
  return $files[0].FullName
}

$baseFile = Get-LatestJson $BaselineDir
$ecoFile = Get-LatestJson $EcoClawDir

$base = Get-Content $baseFile -Raw | ConvertFrom-Json
$eco = Get-Content $ecoFile -Raw | ConvertFrom-Json

$baseMean = (($base.tasks | ForEach-Object { [double]$_.grading.mean }) | Measure-Object -Average).Average
$ecoMean = (($eco.tasks | ForEach-Object { [double]$_.grading.mean }) | Measure-Object -Average).Average

$cmp = [ordered]@{
  baseline_file = $baseFile
  ecoclaw_file = $ecoFile
  baseline = [ordered]@{
    mean_score = [double]::Parse(($baseMean.ToString("F6")))
    total_tokens = $base.efficiency.total_tokens
    total_cost_usd = $base.efficiency.total_cost_usd
    score_per_1k_tokens = $base.efficiency.score_per_1k_tokens
    score_per_dollar = $base.efficiency.score_per_dollar
  }
  ecoclaw = [ordered]@{
    mean_score = [double]::Parse(($ecoMean.ToString("F6")))
    total_tokens = $eco.efficiency.total_tokens
    total_cost_usd = $eco.efficiency.total_cost_usd
    score_per_1k_tokens = $eco.efficiency.score_per_1k_tokens
    score_per_dollar = $eco.efficiency.score_per_dollar
  }
  deltas = [ordered]@{
    mean_score = $ecoMean - $baseMean
    total_tokens = $eco.efficiency.total_tokens - $base.efficiency.total_tokens
    total_cost_usd = $eco.efficiency.total_cost_usd - $base.efficiency.total_cost_usd
  }
}

New-Item -ItemType Directory -Force -Path (Split-Path $ReportPath -Parent) | Out-Null
$cmp | ConvertTo-Json -Depth 8 | Set-Content $ReportPath
Write-Output "Comparison report written to: $ReportPath"
