# Build script for compiling single .ps1 and .exe
# PS2EXE requires compiling into one .ps1 before compiling to .exe

# Parameters SkipExe(no exe generated), NoOutput(no extra UI), etc.
param(
	[switch]$SkipExe,
	[switch]$NoOutput,
	[switch]$InstallPs2ExeIfMissing,
	[string]$OutputDir = "$PSScriptRoot/../dist",
	[string]$OutputName = "SwiftEdge-Compiled"
)

$ErrorActionPreference = "Stop"

$projectRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$modulesDir = Join-Path $projectRoot "src/modules"

# Module order for compiling
$moduleOrder = @(
	"performance2.ps1",
	"cleanup2.ps1",
	"security2.ps1",
	"vulnScan2.ps1"
)

# mainFinal path
$mainPath = Join-Path $modulesDir "mainFinal.ps1"
if (-not (Test-Path $mainPath)) {
	throw "Missing main script: $mainPath"
}

# Check all modules exist before starting
foreach ($m in $moduleOrder) {
	$modulePath = Join-Path $modulesDir $m
	if (-not (Test-Path $modulePath)) {
		throw "Missing module: $modulePath"
	}
}

# Create output directory if it doesn't exist
if (-not (Test-Path $OutputDir)) {
	New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

# Compiled Script and EXE paths
$compiledPs1 = Join-Path $OutputDir "$OutputName.ps1"
$compiledExe = Join-Path $OutputDir "$OutputName.exe"

$importPattern = '^\s*\.\s*"\$PSScriptRoot\\(performance2|cleanup2|security2|vulnScan2)\.ps1"\s*$'

$mainContent = Get-Content -Path $mainPath -Raw
$mainContent = [regex]::Replace($mainContent, $importPattern, "", [System.Text.RegularExpressions.RegexOptions]::Multiline)

# Builder combines the script
$builder = New-Object System.Text.StringBuilder
$null = $builder.AppendLine("# Auto-generated combined script. Do not edit directly.")
$null = $builder.AppendLine("# Generated: $(Get-Date -Format s)")
$null = $builder.AppendLine()

# Builder combines each module in order. (Instead of doing this manually)
foreach ($m in $moduleOrder) {
	$modulePath = Join-Path $modulesDir $m
	$null = $builder.AppendLine("#BEGIN MODULE: $m")
	$null = $builder.AppendLine((Get-Content -Path $modulePath -Raw))
	$null = $builder.AppendLine("#END MODULE: $m")
	$null = $builder.AppendLine()
}

# Combines the main last as it should in OOP / Function calls
$null = $builder.AppendLine("#BEGIN MAIN: mainFinal.ps1")
$null = $builder.AppendLine($mainContent)
$null = $builder.AppendLine("#END MAIN: mainFinal.ps1")

[System.IO.File]::WriteAllText($compiledPs1, $builder.ToString(), [System.Text.Encoding]::UTF8)
Write-Host "Created compiled script: $compiledPs1"

# Exe param logic & installps2exe logic
if (-not $SkipExe) {
	if (-not (Get-Command Invoke-ps2exe -ErrorAction SilentlyContinue)) {
		if ($InstallPs2ExeIfMissing) {
			Install-Module ps2exe -Scope CurrentUser -Force -ErrorAction Stop
		}
		else {
			throw "PS2EXE is not installed. Run: Install-Module ps2exe -Scope CurrentUser, or rerun with -InstallPs2ExeIfMissing."
		}
	}

	# Parameters for running
	$ps2exeParams = @{
		inputFile = $compiledPs1
		outputFile = $compiledExe
		title = "SwiftEdge Security & Optimizer"
		version = "1.0.0"
		requireAdmin = $true
		noConsole = $true
	}

	# Use NoOutput unless debugging.
	if ($NoOutput) {
		$ps2exeParams["noOutput"] = $true
	}

	# Call PS2EXE
	Invoke-ps2exe @ps2exeParams

	Write-Host "Created executable: $compiledExe"
}
