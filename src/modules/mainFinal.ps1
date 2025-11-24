# main3.ps1 - SwiftEdge Security & Optimizer TEST
# - - - - - - - - - - - - - - - - - - - - - - 

# Description: Provides a simple Windows Forms GUI in a dark theme
# with CSU Navy & Gold accent colors. Four main functional tabs:
# Performance, Security, Cleanup, & Vulnerability.
# - - - - - - - - - - - - - - - - - - - - - - 
# - Windows 11 23H2 or 24H2
# - Windows Powershell 5.1 (or newer) 
# - To Be Compiled with PS2EXE

# - - - - - - - - - - - - - - - - - - - - - - 

# Import Modules
. ".\performance2.ps1"
. ".\cleanup2.ps1"
. ".\security2.ps1"
. ".\scannerTest.ps1"

# # Import Modules
# . "$PSScriptRoot\performance2.ps1"
# . "$PSScriptRoot\cleanup2.ps1"
# . "$PSScriptRoot\security2.ps1"
# . "$PSScriptRoot\scannerTest.ps1"

# Logging Setup 
$logTime = Get-Date -Format "yyyyMMdd_HHmmss"
$moduleName = "Performance"
$logFolder = Join-Path $env:USERPROFILE "Documents\SwiftEdgeLogs"
$logPath = Join-Path $logFolder "SwiftEdgeLog_${logTime}_${moduleName}.txt"

if (-not (Test-Path $logFolder)) {
	New-Item -ItemType Directory -Path $logFolder -Force | Out-Null
}

function Log {
	param ([string]$Message)
	Write-Host $Message
	Add-Content -Path $logPath -Value $Message
}

# - - - - - - - - - - - - - - - - - - - - -

# Load .NET WindowsForms + Drawings Modules
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# Base64 Icon (IGNORE IMAGE BASE64 CODE. Hardcoded to avoid external media.)
$IconBase64 = @"
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
O6Prk3NVlrSvkMfKObRzolcoFQSoACMDEIAPoEuEQxAAFQAAAAyAqA3fhrimm2n9l6uu0xZbRpyJb81G
3yVJ96S8JeHj07uf13DcmPJ9q0nVbtjv+u5Y6fVVtXyWbl3uv4o4MvwN7qt8jCftRyK1u4Q712iXctvn
Lo/hvsbWg4ti1P3L/dv2xPyeWo0dsf3q9cHD+ZXHEsrx7cfH1F3KXbZSrXaYnJ/DrtmnGt83Xrtv5k6z
Fec8WyRNse3KOye+YjrkwXiMcxWYi3t7nLzOHtTz40v1Gt2Vqasy67cNesqUt4uXI0ui6b9Wzyx67R6a
bf3J2nlExbq8N+9nfBmyxH3Y3794bbwlo10caUcjsciynemmNd0pRhT156OZLkjLfdS2336KT6Lam4hr
Mflomm9Yt1zvHb2Ttz27v0bunw2im1tp2+tnJ1vTbPU5WUQqw7tnGLttkoU0S37SM5xTiovr0fsptPo0
tvLS6mk54reZvEd0c5jltHs/NnlxW6G9eqWkYHC2pYUp2+oV3b1ThVZO3FlXTZLblvSk2m14brxL7LxL
SaisV8pMdfXG07z7OrvV1NNmxzv0d/y/NjqGX/Y76s+3GyMyUq/U1R2NluNtL96521rlSa2XLu3v5GWH
FP2ittPW1adfS332nu2if3L3/tzGSYm3Z7PycHhvhbJ1KS7KPJQntPJsT7Ndeqj/ADy+C+9o2NdxPDpI
+9O9uyI5/wDHng0t809XLvbFq+v42l0y07SHzWvpk5qak+fue0l8qf0dI+HXuq9Noc2tyRqdZy/xr9fU
trLnpgr5PDz7ZaEdJyViEgBQlkAAAYhCAfQlLhGLEAAVAAAADJAVAGB33D3F2Zp8XXTNTpae1Nyc4Qk1
8qPXePXwT2fkV2s4Xp9VMWtG098dUtnDqsmKNonq9rpbLHOUpye8ptyk0lFOTe76LovuLCtYrERHY15n
ed2eLkWUyU6bJ1TXVTrk4S/FGOTFTJG14iY9qa3tWd6zs9O4R1e7Lo7bInCNsZOEcypctqUduuRXso21
e0k2vk79eX5ZyfEtLjwZOhjiZj/WeX/mecT3R2+3kuNLmteu9vz/AJcziTUb8ei29dlZk1dXZZzSox5K
Si68arb25RclzTlt1ezfzF46HT48uStJ3is9kc59tp7N+yI/6z1GW1azaOf6fB5VqGfdlSdmTdO6b672
Sb2+hdyX0HYYcGLDHRx1iI9imvkted7S46PZg7/P4uzb8eGJK1QqhDs5djFVyuiu7na8Numy2T8dytxc
K02PNOaK7zPX19e3g2b6vLakU36vY6FFk1gAAAoSyQAABiwhAPoSlwjFiAACAoAABUBQMmBEBUBSRtHA
uqWwu9Vb3os5rfa6xx7Iwf77b+Xl3U14wcio4rpqWp5X/KOrx9nj3e1uaPLMW6HZ+312udx7qFlXJhVx
7KqcVK1RlvzKEnGNG/jGDTT/AJp87PDhOClt81p3mOX8+M/pGz01mSY+5HL66vg0ovleqCVAAAAAChKo
CgAJIDEIfQlLhGLEAAAKAAAVAUDJAQCoCkjaPRpFS1ShNJpwvTT7mnTLdFTxudtHaY74/dt6H00fF9/S
LBRnp6Xd6hS+rbbblJttvve/U8uCTNq5Zn/eXpr42msexqRdtBAMgkAAAAFQFQSoACSAxCH0JS4RixAA
ACoAAAoFAqAAUCkjafRl71x/8t3/AIZFRxz1O3jH7tzQenj4uR6SP4mB9n0/8yPLgfmZffl6cQ86vg08
vGgBDJBIwAAABQKEqAAMDAIfQJcIhiAAAFQAAAAyQFQBgAMiRtHo6kqsyWZZJRowaLb75dW+RxcOiXVv
eX9Co4zvfBGGvnXmIhuaHqydOeUQ5HHlteTXp+Zjz58d0PDUpRcJ9pTJ828X4e14b9x5cIrbFfLhyRtb
fpd/VLPWzF4revLbZqCLxogQyiEgAAAAAUJZAAAGIQzJS4RixAAAAgKAAAZICoAwAFA5uj6pbhXRyKGl
OO8WpLeFlb+VCS8Ys8NTpqajHOO/L9vbD0xZbY7dKrkcQ67bqFqssUYQgnCmivpXTDxS+L8X4/ckeej0
VNLTo165nnM85ZZs9stt5dYjceIwlYgUAgAAABQlkgAACLvCGQS4RDEAAACAoAABUBQMmBEBUBSQAoAA
glkAAAAAFQFQSoAB4gUDhEMQAAAAUAAAqAoFQACoCkgBQKEoBkAAAAAFQFQSoAABQOEQxAAAABUAAAVA
UCoABUAJFAoAJAhkEjAAAAFAqCVAAAAH/9k= 
"@
# - - - - - - - - - - - - - - - - - - - - - - 

# Theme Settings
$ColorBg = [System.Drawing.Color]::FromArgb(20,22,26)
$ColorNavy = [System.Drawing.Color]::FromArgb(10,34,64)
$ColorGold = [System.Drawing.Color]::FromArgb(218,165,32)
$ColorCard = [System.Drawing.Color]::FromArgb(32,36,42)
$ColorText = [System.Drawing.Color]::Gainsboro
$ColorMuted = [System.Drawing.Color]::FromArgb(160,170,180)

# - - - - - - - - - - - - - - - - - - - - - - 

# Helper Functions: (Buttons, Labels, Dividers, Cards)
# Primary Look For All Buttons
function New-AccentButton {
	param (
		[string]$Text = "Run",
		[int]$W = 200,
		[int]$H = 50
	)
	$btn = New-Object System.Windows.Forms.Button
	$btn.Text = $Text
	$btn.Size = New-Object System.Drawing.Size($W, $H)
	$btn.BackColor = $ColorNavy
	$btn.ForeColor = $ColorGold
	$btn.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
	$btn.FlatAppearance.BorderSize = 1
	$btn.FlatAppearance.BorderColor = $ColorGold
	$btn.Cursor = [System.Windows.Forms.Cursors]::Hand
	return $btn
}

function New-HeaderLabel {
	param([string]$Text, [int]$X = 16, [int]$Y = 12)
	$lbl = New-Object System.Windows.Forms.Label
	$lbl.Text = $Text
	$lbl.AutoSize = $true
	$lbl.Location = New-Object System.Drawing.Point($X, $Y)
	$lbl.ForeColor = $ColorText
	$lbl.Font = New-Object System.Drawing.Font("Segoe UI", 12)
	return $lbl
}

function New-Divider {
	param ([int]$W = 720, [int]$X = 16, [int]$Y = 48)
	$dvdr = New-Object System.Windows.Forms.Panel
	$dvdr.Size = New-Object System.Drawing.Size($W, 1)
	$dvdr.Location = New-Object System.Drawing.Point($X, $Y)
	$dvdr.BackColor = $ColorGold
	return $dvdr
}

function New-Card {
	param([int]$W = 740, [int]$H = 160, [int]$X = 16, [int]$Y = 16)
	$card = New-Object System.Windows.Forms.Panel
	$card.Size = New-Object System.Drawing.Size($W, $H)
	$card.Location = New-Object System.Drawing.Point($X, $Y)
	$card.BackColor = $ColorCard
	return $card
}

# Restore Point Function
function New-SystemRestorePoint {
	try {
		Checkpoint-Computer -Description "SwiftEdge Before Changes" -RestorePointType MODIFY_SETTINGS
		[System.Windows.Forms.MessageBox]::Show("System Restore Point Created.","SwiftEdge",'OK','Information') | Out-Null
		return $true
	} catch {
		[System.Windows.Forms.MessageBox]::Show("Failed to create restore point: `n$($_.Exception.Message)","SwiftEdge",'OK','Error') | Out-Null
		return $false
	}
}

# - - - - - - - - - - - - - - - - - - - - - - 

# Main Forms GUI 
$form = New-Object System.Windows.Forms.Form
$form.Text = "SwiftEdge Security & Optimizer"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(1200, 700)
$form.MinimumSize = $form.Size
$form.BackColor = $ColorBg
$form.ForeColor = $ColorText
$form.MaximizeBox = $true

# Sets Windows Forms Icon converting base64
$iconBytes = [Convert]::FromBase64String($IconBase64)
$memStream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
$form.Icon = [System.Drawing.Icon]::FromHandle(([System.DRawing.Bitmap]::new($memStream).GetHicon()))

# Set base font
$baseFont = New-Object System.Drawing.Font("Segoe UI", 14)
$form.Font = $baseFont

# Title 
$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "SwiftEdge Security && Optimizer"
$lblTitle.AutoSize = $true
$lblTitle.Location = New-Object System.Drawing.Point(16, 5)
$lblTitle.ForeColor = $ColorGold
$lblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 28)
$form.Controls.Add($lblTitle)

# Subtitle 
$lblSub = New-Object System.Windows.Forms.Label
$lblSub.Text = "Performance Tweaks | File Cleanup | Security Hardening | Vulnerability Scanning"
$lblSub.AutoSize = $true
$lblSub.Location = New-Object System.Drawing.Point(18, 55)
$lblSub.ForeColor = $ColorMuted
$lblSub.Font = New-Object System.Drawing.Font("Segoe UI", 16)
$form.Controls.Add($lblSub)

# - - - - - - - - - - - - - - - - - - - - - - 

# Welcome Screen w/Restore Point
$welcomeScreen = New-Object System.Windows.Forms.Panel
$welcomeScreen.Size = New-Object System.Drawing.Size(1160, 500)
$welcomeScreen.Location = New-Object System.Drawing.Point(16, 100)
$welcomeScreen.BackColor = $ColorBg
$form.Controls.Add($welcomeScreen)

# Welcome Text
$welcomeTitle = New-Object System.Windows.Forms.Label
$welcomeTitle.Text = "Welcome to SwiftEdge"
$welcomeTitle.Font = New-Object System.Drawing.Font("Segoe UI", 30, [System.Drawing.FontStyle]::Bold)
$welcomeTitle.AutoSize = $true
$welcomeTitle.Location = New-Object System.Drawing.Point(205, 40)
$welcomeTitle.ForeColor = $ColorText
$welcomeScreen.Controls.Add($welcomeTitle)

# About Text
$welcomeAbout = New-Object System.Windows.Forms.Label
$welcomeAbout.Text = @"
SwiftEdge Security && Optimizer is a lightweight software application designed 
to enhance computer performance and security in a single, streamlined solution.
The project aims to eliminate the need for multiple optimization and security 
tools by integrating system cleanup, performance tuning, and enhanced 
cybersecurity practices all into one intuitive platform.

Recommended: Create a System Restore Point before proceeding.
"@
$welcomeAbout.AutoSize = $true
$welcomeAbout.MaximumSize = New-Object System.Drawing.Size(800, 0)
$welcomeAbout.Location = New-Object System.Drawing.Point(205, 100)
$welcomeAbout.ForeColor = $ColorText
$welcomeAbout.Font = New-Object System.Drawing.Font("Segoe UI", 16)
$welcomeScreen.Controls.Add($welcomeAbout)

# Checkbox for System Restore Point
$restoreBox = New-Object System.Windows.Forms.CheckBox
$restoreBox.Text = "Create a System Restore Point before continuing"
$restoreBox.AutoSize = $true
$restoreBox.Checked = $true
$restoreBox.Location = New-Object System.Drawing.Point(210, 320)
$restoreBox.ForeColor = $ColorText
$restoreBox.BackColor = $ColorBg
$welcomeScreen.Controls.Add($restoreBox)

# Warning Label for Checkbox
$lblWarn = New-Object System.Windows.Forms.Label
$lblWarn.Text = "Warning: Proceeding without a restore point may make changes hard to revert"
$lblWarn.AutoSize = $true
$lblWarn.Location = New-Object System.Drawing.Point(205, 350)
$lblWarn.ForeColor = [System.Drawing.Color]::FromArgb(255,204,0)
$lblWarn.Visible = $false
$welcomeScreen.Controls.Add($lblWarn)

# Toggle warning visibility
$restoreBox.Add_CheckedChanged({
	$lblWarn.Visible = -not $restoreBox.Checked
})

# Continue button (created restore point if checked)
$btnCont = New-AccentButton -Text "Continue" -W 220 -H 56
$btnCont.Location = New-Object System.Drawing.Point(205, 385)
$welcomeScreen.Controls.Add($btnCont)

# - - - - - - - - - - - - - - - - - - - - - - 

# Tab Setup & Control
$tabs = New-Object System.Windows.Forms.TabControl
$tabs.Size = New-Object System.Drawing.Size(1160, 550)
$tabs.Location = New-Object System.Drawing.Point(16, 100)
$tabs.Visible = $false
$form.Controls.Add($tabs)

# Helper function for dark tabs
function New-DarkTab {
	param([string]$Text)
	$tab = New-Object System.Windows.Forms.TabPage
	$tab.Text = $Text
	$tab.BackColor = $ColorBg
	$tab.ForeColor = $ColorText
	return $tab
}

# Create the four tabs
$tabPerf = New-DarkTab -Text "Performance"
$tabClean = New-DarkTab -Text "Cleanup"
$tabSec = New-DarkTab -Text "Security"
$tabVuln = New-DarkTab -Text "Vulnerability"

# Add tabs to the control
[void]$tabs.TabPages.AddRange(@($tabPerf, $tabClean, $tabSec, $tabVuln))
#$form.Controls.Add($tabs)

# - - - - - - - - - - - - - - - - - - - - - - 

# Continue Click & Additional Warning
$btnCont.Add_Click({
	if ($restoreBox.Checked) {
		# Must be admin
		$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
					).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
		if (-not $isAdmin) {
			[System.Windows.Forms.MessageBox]::Show(
				"Please run SwiftEdge as Administrator to create a System Restore Point.",
				"Administrator Required",
				[System.Windows.Forms.MessageBoxButtons]::OK,
				[System.Windows.Forms.MessageBoxIcon]::Warning
			) | Out-Null
		} else {
			# Enable System Restore on system drive (best-effort)
			try {
				Enable-ComputerRestore -Drive "$env:SystemDrive"
			} catch {
				# non-fatal
			}

			# Allow multiple restore points per day (if not present)
			try {
				$srKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore"
				$exists = Get-ItemProperty -Path $srKey -Name "SystemRestorePointCreationFrequency" -ErrorAction SilentlyContinue
				if ($null -eq $exists) {
					New-ItemProperty -Path $srKey -Name "SystemRestorePointCreationFrequency" -Value 0 -PropertyType DWord -Force | Out-Null
				}
			} catch {
				# non-fatal
			}

			# Ensure module with Get-ComputerRestorePoint is available Ignore Warning
			try { Import-Module Microsoft.PowerShell.Management -ErrorAction Stop } catch { }

			# Create a restore point if one not already created today
			$createdRP = $false
			try {
				$today = (Get-Date).Date
				$existingToday = @()
				try {
					$existingToday = Get-ComputerRestorePoint | Where-Object { $_.CreationTime.Date -eq $today }
				} catch { }

				if (($existingToday | Measure-Object).Count -eq 0) {
					Checkpoint-Computer -Description "SwiftEdge Before Changes" -RestorePointType "MODIFY_SETTINGS"
					$createdRP = $true
				}
			} catch {
				# surface the error, but continue to UI
				[System.Windows.Forms.MessageBox]::Show(
					"Failed to create a System Restore Point:`n$($_.Exception.Message)",
					"SwiftEdge",
					[System.Windows.Forms.MessageBoxButtons]::OK,
					[System.Windows.Forms.MessageBoxIcon]::Warning
				) | Out-Null
			}

			# Notify outcome (optional, but user-friendly)
			if ($createdRP) {
				[System.Windows.Forms.MessageBox]::Show(
					"System Restore Point created successfully.",
					"SwiftEdge",
					[System.Windows.Forms.MessageBoxButtons]::OK,
					[System.Windows.Forms.MessageBoxIcon]::Information
				) | Out-Null
			} else {
				[System.Windows.Forms.MessageBox]::Show(
					"A restore point already exists for today, or creation was skipped.",
					"SwiftEdge",
					[System.Windows.Forms.MessageBoxButtons]::OK,
					[System.Windows.Forms.MessageBoxIcon]::Information
				) | Out-Null
			}
		}
	} else {
		# Confirm skipping restore point
		$r = [System.Windows.Forms.MessageBox]::Show(
			"No restore point will be created. Proceed?",
			"Continue without Restore Point?",
			[System.Windows.Forms.MessageBoxButtons]::YesNo,
			[System.Windows.Forms.MessageBoxIcon]::Question
		)
		if ($r -ne [System.Windows.Forms.DialogResult]::Yes) { return }
	}

	# Proceed to app
	$welcomeScreen.Visible = $false
	$tabs.Visible = $true
})

# - - - - - - - - - - - - - - - - - - - - - - 

# Performance Tab UI
# Header and divider
$perfHeader = New-HeaderLabel -Text "Performance Module" -X 16 -Y 12 
$perfDivider = New-Divider -W 1120 -X 16 -Y 48
$tabPerf.Controls.AddRange(@($perfHeader, $perfDivider))

# Card with description + button
$perfCard = New-Card -W 1120 -H 310 -X 16 -Y 70
$tabPerf.Controls.Add($perfCard)

$perfDesc = New-Object System.Windows.Forms.Label
$perfDesc.Text = "Select which performance tweaks to apply:"
$perfDesc.AutoSize = $true
$perfDesc.MaximumSize = New-Object System.Drawing.Size(760, 0)
$perfDesc.Location = New-Object System.Drawing.Point(16, 16)
$perfDesc.ForeColor = $ColorText
$perfDesc.Font = New-Object System.Drawing.Font("Segoe UI", 14)
$perfCard.Controls.Add($perfDesc)

# Dynamic Two-Column Checkbox Builder
$checkboxes = @()

$col1X = 30
$col2X = 420
$startY = 60
$verticalSpacing = 32
$itemsPerColumn = 6

for ($i = 0; $i -lt $PerfTweaks.Count; $i++) {

	# Determine which column and row
	if ($i -lt $itemsPerColumn) {
		$x = $col1X
		$y = $startY + ($i * $verticalSpacing)
	} else {
		$x = $col2X
		$y = $startY + ( ($i - $itemsPerColumn) * $verticalSpacing )
	}

	# Build checkbox
	$cb = New-Object System.Windows.Forms.CheckBox
	$cb.Text = $PerfTweaks[$i].Text
	$cb.Tag  = $PerfTweaks[$i].Script
	$cb.AutoSize = $true
	$cb.ForeColor = $ColorText
	$cb.BackColor = $ColorCard
	$cb.Font = New-Object System.Drawing.Font("Segoe UI", 13)
	$cb.UseVisualStyleBackColor = $false
	$cb.Location = New-Object System.Drawing.Point($x, $y)

	# Add to UI + keep track for run button
	$perfCard.Controls.Add($cb)
	$checkboxes += $cb
}

# Run Button — Executes all checked tweaks
$btnRunPerf = New-AccentButton -Text "Run Selected Performance Tweaks" -W 325 -H 60
$btnRunPerf.Location = New-Object System.Drawing.Point(775, 225)
$perfCard.Controls.Add($btnRunPerf)

# Button Click Functionality
$btnRunPerf.Add_Click({
	$selected = $checkboxes | Where-Object { $_.Checked }

	if (-not $selected) {
		[System.Windows.Forms.MessageBox]::Show(
			"Please select at least one tweak.",
			"SwiftEdge Performance",
			[System.Windows.Forms.MessageBoxButtons]::OK,
			[System.Windows.Forms.MessageBoxIcon]::Warning
		) | Out-Null
		return
	}

	foreach ($cb in $selected) {
		try {
			$result = & $cb.Tag # call the function
			Log $result # log the returned string
		} catch {
			Log "Error executing [$($cb.Text)]: $($_.Exception.Message)"
		}
	}

	Log "[Performance Module] Complete."

	#UI Complete Popup
	[System.Windows.Forms.MessageBox]::Show(
		"Performance Module Completed!",
		"SwiftEdge",
		[System.Windows.Forms.MessageBoxButtons]::OK,
		[System.Windows.Forms.MessageBoxIcon]::Information
	) | Out-Null

	# Reset Checkboxes
	$checkboxes | ForEach-Object { $_.Checked = $false }

})

# Other Tabs Default
$cleanHeader  = New-HeaderLabel -Text "System Cleanup Module" -X 16 -Y 12 
$cleanDivider = New-Divider -W 1120 -X 16 -Y 48
$tabClean.Controls.AddRange(@($cleanHeader, $cleanDivider))

# Cleanup Card
$cleanCard = New-Card -W 1120 -H 310 -X 16 -Y 70
$tabClean.Controls.Add($cleanCard)

# Description Label
$cleanDesc = New-Object System.Windows.Forms.Label
$cleanDesc.Text = "Select which cleanup tasks to apply:"
$cleanDesc.AutoSize = $true
$cleanDesc.MaximumSize = New-Object System.Drawing.Size(760, 0)
$cleanDesc.Location = New-Object System.Drawing.Point(16, 16)
$cleanDesc.ForeColor = $ColorText
$cleanDesc.Font = New-Object System.Drawing.Font("Segoe UI", 14)
$cleanCard.Controls.Add($cleanDesc)

# Dynamic Two-Column Checkbox Builder
$cleanCheckboxes = @()

$col1X = 30
$col2X = 420
$startY = 60
$verticalSpacing = 32
$itemsPerColumn = 6

for ($i = 0; $i -lt $CleanTweaks.Count; $i++) {

	# Determine position
	if ($i -lt $itemsPerColumn) {
		$x = $col1X
		$y = $startY + ($i * $verticalSpacing)
	} else {
		$x = $col2X
		$y = $startY + ( ($i - $itemsPerColumn) * $verticalSpacing )
	}

	# Build checkbox
	$cb = New-Object System.Windows.Forms.CheckBox
	$cb.Text = $CleanTweaks[$i].Text
	$cb.Tag  = $CleanTweaks[$i].Script
	$cb.AutoSize = $true
	$cb.ForeColor = $ColorText
	$cb.BackColor = $ColorCard
	$cb.Font = New-Object System.Drawing.Font("Segoe UI", 13)
	$cb.UseVisualStyleBackColor = $false
	$cb.Location = New-Object System.Drawing.Point($x, $y)

	$cleanCard.Controls.Add($cb)
	$cleanCheckboxes += $cb
}

# RUN CLEANUP BUTTON
$btnRunClean = New-AccentButton -Text "Run Selected Cleanup Tweaks" -W 320 -H 60
$btnRunClean.Location = New-Object System.Drawing.Point(780, 225)
$cleanCard.Controls.Add($btnRunClean)

# Button Click Logic
$btnRunClean.Add_Click({

	# Switch the log to CLEANUP file instead of Performance
	$logTime = Get-Date -Format "yyyyMMdd_HHmmss"
	$moduleName = "Cleanup"
	$logFolder = Join-Path $env:USERPROFILE "Documents\SwiftEdgeLogs"
	$script:logPath = Join-Path $logFolder "SwiftEdgeLog_${logTime}_${moduleName}.txt"

	if (-not (Test-Path $logFolder)) {
		New-Item -ItemType Directory -Path $logFolder -Force | Out-Null
	}

	$selected = $cleanCheckboxes | Where-Object { $_.Checked }

	if (-not $selected) {
		[System.Windows.Forms.MessageBox]::Show(
			"Please select at least one task.",
			"SwiftEdge Cleanup",
			[System.Windows.Forms.MessageBoxButtons]::OK,
			[System.Windows.Forms.MessageBoxIcon]::Warning
		) | Out-Null
		return
	}

	foreach ($cb in $selected) {
		try {
			$result = & $cb.Tag
			Log $result
		} catch {
			Log "Error executing [$($cb.Text)]: $($_.Exception.Message)"
		}
	}

	Log "[Cleanup Module] Complete."

	[System.Windows.Forms.MessageBox]::Show(
		"Cleanup Module Completed!",
		"SwiftEdge",
		[System.Windows.Forms.MessageBoxButtons]::OK,
		[System.Windows.Forms.MessageBoxIcon]::Information
	) | Out-Null

	# Reset checkboxes
	$cleanCheckboxes | ForEach-Object { $_.Checked = $false }

})

# Security Module Tab Creation
$secHeader  = New-HeaderLabel -Text "Security Module" -X 16 -Y 12 
$secDivider = New-Divider -W 1120 -X 16 -Y 48
$tabSec.Controls.AddRange(@($secHeader, $secDivider))

# Security Module UI (Dynamic Checkbox Builder)
# Card for Security module
$secCard = New-Card -W 1120 -H 350 -X 16 -Y 70
$tabSec.Controls.Add($secCard)

# Description text
$secDesc = New-Object System.Windows.Forms.Label
$secDesc.Text = "Select which security hardening operations to apply:"
$secDesc.AutoSize = $true
$secDesc.MaximumSize = New-Object System.Drawing.Size(760, 0)
$secDesc.Location = New-Object System.Drawing.Point(16, 16)
$secDesc.ForeColor = $ColorText
$secDesc.Font = New-Object System.Drawing.Font("Segoe UI", 14)
$secCard.Controls.Add($secDesc)

# Dynamic Checkbox Builder for SecurityTweaks
$secCheckboxes = @()

$secCol1X = 30
$secCol2X = 420
$secStartY = 60
$secSpacing = 32
$secItemsPerColumn = 8   # more items than performance module

# For loop to iterate through the tweaks/checkbox(s)
for ($i = 0; $i -lt $SecurityTweaks.Count; $i++) {

	if ($i -lt $secItemsPerColumn) {
		$x = $secCol1X
		$y = $secStartY + ($i * $secSpacing)
	} else {
		$x = $secCol2X
		$y = $secStartY + (($i - $secItemsPerColumn) * $secSpacing)
	}

	# Check Box Details
	$cb = New-Object System.Windows.Forms.CheckBox
	$cb.Text = $SecurityTweaks[$i].Text
	$cb.Tag  = $SecurityTweaks[$i].Script
	$cb.AutoSize = $true
	$cb.ForeColor = $ColorText
	$cb.BackColor = $ColorCard
	$cb.Font = New-Object System.Drawing.Font("Segoe UI", 13)
	$cb.UseVisualStyleBackColor = $false
	$cb.Location = New-Object System.Drawing.Point($x, $y)

	$secCard.Controls.Add($cb)
	$secCheckboxes += $cb
}

# Run button for Security module
$btnRunSec = New-AccentButton -Text "Run Security Hardening Tweaks" -W 330 -H 60
$btnRunSec.Location = New-Object System.Drawing.Point(770, 225)
$secCard.Controls.Add($btnRunSec)

# Button logic
$btnRunSec.Add_Click({
	$selected = $secCheckboxes | Where-Object { $_.Checked }

	# If none are selected to run. 
	if (-not $selected) {
		[System.Windows.Forms.MessageBox]::Show(
			"Please select at least one security hardening option.",
			"SwiftEdge Security",
			[System.Windows.Forms.MessageBoxButtons]::OK,
			[System.Windows.Forms.MessageBoxIcon]::Warning
		) | Out-Null
		return
	}

	foreach ($cb in $selected) {
		try {
			$result = & $cb.Tag
			Log $result
		} catch {
			Log "Error executing [$($cb.Text)]: $($_.Exception.Message)"
		}
	}

	Log "[Security Module] Complete."

	# Security Module Complete UI Popup
	[System.Windows.Forms.MessageBox]::Show(
		"Security Hardening Completed!",
		"SwiftEdge",
		[System.Windows.Forms.MessageBoxButtons]::OK,
		[System.Windows.Forms.MessageBoxIcon]::Information
	) | Out-Null

	# Reset checkboxes
	$secCheckboxes | ForEach-Object { $_.Checked = $false }
})

# Vulnerability Module Header
$vulnHeader  = New-HeaderLabel -Text "Vulnerability Module" -X 16 -Y 12 
$vulnDivider = New-Divider -W 1120 -X 16 -Y 48
$tabVuln.Controls.AddRange(@($vulnHeader, $vulnDivider))

# Vulnerability Scanner Card
$vulnCard = New-Card -W 1120 -H 430 -X 16 -Y 70
$tabVuln.Controls.Add($vulnCard)

# Description
$vulnDesc = New-Object System.Windows.Forms.Label
$vulnDesc.Text = "Run the vulnerability scanner. Results will appear below:"
$vulnDesc.AutoSize = $true
$vulnDesc.Location = New-Object System.Drawing.Point(16, 16)
$vulnDesc.ForeColor = $ColorText
$vulnDesc.Font = New-Object System.Drawing.Font("Segoe UI", 14)
$vulnCard.Controls.Add($vulnDesc)

# Scrollable output (terminal box)
$txtVulnOutput = New-Object System.Windows.Forms.TextBox
$txtVulnOutput.Multiline  = $true
$txtVulnOutput.ScrollBars = "Vertical"
$txtVulnOutput.ReadOnly   = $true
$txtVulnOutput.BackColor  = "Black"
$txtVulnOutput.ForeColor  = "White"
$txtVulnOutput.Font       = "Consolas, 10"
$txtVulnOutput.Location   = New-Object System.Drawing.Point(16, 60)
$txtVulnOutput.Size       = New-Object System.Drawing.Size(830, 350)
$vulnCard.Controls.Add($txtVulnOutput)

# Run Scanner Button
$btnRunVuln = New-AccentButton -Text "Run Vulnerability Scan" -W 250 -H 60
$btnRunVuln.Location = New-Object System.Drawing.Point(860, 60)
$vulnCard.Controls.Add($btnRunVuln)

$btnRunVuln.Add_Click({
	$txtVulnOutput.Text = "Running vulnerability scan... please wait.`r`n"
	$form.Refresh()

	try {
		$outputText = Run-VulnScan   # Call your wrapped scanner
		$txtVulnOutput.Text = $outputText
	}
	catch {
		$txtVulnOutput.Text = "Error running vulnerability scan:`r`n$($_.Exception.Message)"
	}
})


[void]$form.ShowDialog()