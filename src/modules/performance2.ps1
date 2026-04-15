# performance2.ps1
# SwiftEdge Security - Performance Module 

# Performance Tweaks
# PM1 - Set Ultimate Performance 
function Set-UltimatePerformance {
	try {
		powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>$null | Out-Null
		powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 2>$null
		return "PM1: Ultimate Performance plan is now active."
	} catch {
		try {
			$highPerfGUID = (powercfg -list | Select-String "High performance").ToString().Split()[3]
			powercfg -setactive $highPerfGUID
			return "PM1: Ultimate Performance not available. High Performance plan enabled."
		} catch {
			return "PM1 ERROR: Unable to activate power plan. $($_.Exception.Message)"
		}
	}
}

# PM2 - Disable SysMain
function Disable-SysMain {
	try {
		Stop-Service SysMain -Force -ErrorAction SilentlyContinue
		Set-Service SysMain -StartupType Disabled
		return "PM2: SysMain disabled."
	} catch {
		return "PM2 ERROR (SysMain): $($_.Exception.Message)"
	}
}

# PM2 - Disable WSearch
function Disable-WSearch {
	try {
		Stop-Service WSearch -Force -ErrorAction SilentlyContinue
		Set-Service WSearch -StartupType Disabled
		return "PM2: Windows Search disabled."
	} catch {
		return "PM2 ERROR (WSearch): $($_.Exception.Message)"
	}
}

# PM2 Disable DiagTrack
function Disable-DiagTrack {
	try {
		Stop-Service DiagTrack -Force -ErrorAction SilentlyContinue
		Set-Service DiagTrack -StartupType Disabled
		return "PM2: DiagTrack disabled."
	} catch {
		return "PM2 ERROR (DiagTrack): $($_.Exception.Message)"
	}
}

function Disable-Animations {
	try {
		Set-ItemProperty "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0
		return "PM3: Window animations disabled."
	} catch {
		return "PM3 ERROR (Animations): $($_.Exception.Message)"
	}
}

# PM3 Disable Transparency
function Disable-Transparency {
	try {
		$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
		if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
		Set-ItemProperty -Path $path -Name "EnableTransparency" -Value 0
		return "PM3: Transparency disabled."
	} catch {
		return "PM3 ERROR (Transparency): $($_.Exception.Message)"
	}
}

# PM4 - Disable BackgroundApps
function Disable-BackgroundApps {
	try {
		$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
		if (-not (Test-Path $path)) { New-Item $path -Force | Out-Null }
		Set-ItemProperty $path -Name "GlobalUserDisabled" -Value 1 -Force
		return "PM4: Background apps disabled."
	} catch {
		return "PM4 ERROR (Background Apps): $($_.Exception.Message)"
	}
}

# PM5 - Disable WindowsTips
function Disable-WindowsTips {
	try {
		$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
		if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
		Set-ItemProperty $path -Name "SoftLandingEnabled" -Value 0 -Force
		Set-ItemProperty $path -Name "SubscribedContent-310093Enabled" -Value 0 -Force
		return "PM5: Windows Tips disabled."
	} catch {
		return "PM5 ERROR (Tips): $($_.Exception.Message)"
	}
}

# PM5 - Disable Hibernation
function Disable-Hibernation {
	try {
		powercfg -h off
		return "PM5: Hibernation disabled."
	} catch {
		return "PM5 ERROR (Hibernation): $($_.Exception.Message)"
	}
}

# PM6 - Optimize StartupDelay
function Optimize-StartupDelay {
	try {
		$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
		if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
		Set-ItemProperty $path -Name "StartupDelayInMSec" -Value 0
		return "PM6: Startup delay optimized."
	} catch {
		return "PM6 ERROR (Startup Delay): $($_.Exception.Message)"
	}
}

# PM7 - Disable startup applications (Run keys backup + clear)
function Disable-StartupApplications {
	try {
		$backupRoot = "HKCU:\Software\SwiftEdge\Backup\Startup"
		$runPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
		$backupRun = Join-Path $backupRoot "Run"

		if (-not (Test-Path $backupRoot)) { New-Item -Path $backupRoot -Force | Out-Null }
		if (-not (Test-Path $backupRun)) { New-Item -Path $backupRun -Force | Out-Null }

		if (Test-Path $runPath) {
			$props = (Get-ItemProperty -Path $runPath).PSObject.Properties |
				Where-Object { $_.Name -notin @("PSPath","PSParentPath","PSChildName","PSDrive","PSProvider") }

			foreach ($p in $props) {
				New-ItemProperty -Path $backupRun -Name $p.Name -Value ([string]$p.Value) -PropertyType String -Force | Out-Null
				Remove-ItemProperty -Path $runPath -Name $p.Name -ErrorAction SilentlyContinue
			}
		}

		return "PM7: Startup applications disabled for current user (Run key entries backed up)."
	} catch {
		return "PM7 ERROR (Startup Apps): $($_.Exception.Message)"
	}
}

# PM8 - Enable Game Mode
function Enable-GameMode {
	try {
		$gbPath = "HKCU:\Software\Microsoft\GameBar"
		if (-not (Test-Path $gbPath)) { New-Item -Path $gbPath -Force | Out-Null }
		New-ItemProperty -Path $gbPath -Name "AutoGameModeEnabled" -Value 1 -PropertyType DWord -Force | Out-Null
		New-ItemProperty -Path $gbPath -Name "AllowAutoGameMode" -Value 1 -PropertyType DWord -Force | Out-Null
		return "PM8: Game Mode enabled."
	} catch {
		return "PM8 ERROR (Game Mode): $($_.Exception.Message)"
	}
}

# PM9 - Enable hardware-acceleration(reboot may be required)
function Enable-HwGpuScheduling {
	try {
		$gdPath = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
		if (-not (Test-Path $gdPath)) { New-Item -Path $gdPath -Force | Out-Null }
		New-ItemProperty -Path $gdPath -Name "HwSchMode" -Value 2 -PropertyType DWord -Force | Out-Null
		return "PM9: Hardware-acceleration enabled (restart may be required)."
	} catch {
		return "PM9 ERROR (GPU Scheduling): $($_.Exception.Message)"
	}
}

# Performance reset helpers (restore common Windows defaults)
function Set-BalancedPerformancePlan {
	try {
		$balancedGuid = (powercfg -list | Select-String "Balanced").ToString().Split()[3]
		powercfg -setactive $balancedGuid
		return "PR1: Balanced power plan restored."
	} catch {
		return "PR1 ERROR (Power Plan): $($_.Exception.Message)"
	}
}

# Reset
function Enable-SysMain {
	try {
		Set-Service SysMain -StartupType Automatic
		Start-Service SysMain -ErrorAction SilentlyContinue
		return "PR2: SysMain restored."
	} catch {
		return "PR2 ERROR (SysMain): $($_.Exception.Message)"
	}
}

# Reset
function Enable-WSearch {
	try {
		Set-Service WSearch -StartupType Automatic
		Start-Service WSearch -ErrorAction SilentlyContinue
		return "PR2: Windows Search restored."
	} catch {
		return "PR2 ERROR (WSearch): $($_.Exception.Message)"
	}
}

# Reset
function Enable-DiagTrack {
	try {
		Set-Service DiagTrack -StartupType Manual
		return "PR2: DiagTrack startup restored to Manual."
	} catch {
		return "PR2 ERROR (DiagTrack): $($_.Exception.Message)"
	}
}

# Reset
function Enable-Animations {
	try {
		Set-ItemProperty "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 1
		return "PR3: Window animations restored."
	} catch {
		return "PR3 ERROR (Animations): $($_.Exception.Message)"
	}
}

# Reset
function Enable-Transparency {
	try {
		$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
		if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
		Set-ItemProperty -Path $path -Name "EnableTransparency" -Value 1
		return "PR3: Transparency restored."
	} catch {
		return "PR3 ERROR (Transparency): $($_.Exception.Message)"
	}
}

# Reset
function Enable-BackgroundApps {
	try {
		$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
		if (-not (Test-Path $path)) { New-Item $path -Force | Out-Null }
		Set-ItemProperty $path -Name "GlobalUserDisabled" -Value 0 -Force
		return "PR4: Background apps restored."
	} catch {
		return "PR4 ERROR (Background Apps): $($_.Exception.Message)"
	}
}

# Reset
function Enable-WindowsTips {
	try {
		$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
		if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
		Set-ItemProperty $path -Name "SoftLandingEnabled" -Value 1 -Force
		Set-ItemProperty $path -Name "SubscribedContent-310093Enabled" -Value 1 -Force
		return "PR5: Windows Tips restored."
	} catch {
		return "PR5 ERROR (Tips): $($_.Exception.Message)"
	}
}

# Reset
function Enable-Hibernation {
	try {
		powercfg -h on
		return "PR5: Hibernation restored."
	} catch {
		return "PR5 ERROR (Hibernation): $($_.Exception.Message)"
	}
}

# Reset
function Reset-StartupDelayDefault {
	try {
		$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
		Remove-ItemProperty -Path $path -Name "StartupDelayInMSec" -ErrorAction SilentlyContinue
		return "PR6: Startup delay restored to Windows default."
	} catch {
		return "PR6 ERROR (Startup Delay): $($_.Exception.Message)"
	}
}

# Reset
function Enable-StartupApplications {
	try {
		$backupRun = "HKCU:\Software\SwiftEdge\Backup\Startup\Run"
		$runPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"

		if (-not (Test-Path $runPath)) { New-Item -Path $runPath -Force | Out-Null }
		if (Test-Path $backupRun) {
			$props = (Get-ItemProperty -Path $backupRun).PSObject.Properties |
				Where-Object { $_.Name -notin @("PSPath","PSParentPath","PSChildName","PSDrive","PSProvider") }

			foreach ($p in $props) {
				New-ItemProperty -Path $runPath -Name $p.Name -Value ([string]$p.Value) -PropertyType String -Force | Out-Null
			}
		}

		return "PR7: Startup applications restored from backup."
	} catch {
		return "PR7 ERROR (Startup Apps): $($_.Exception.Message)"
	}
}

# Reset
function Disable-GameMode {
	try {
		$gbPath = "HKCU:\Software\Microsoft\GameBar"
		if (-not (Test-Path $gbPath)) { New-Item -Path $gbPath -Force | Out-Null }
		New-ItemProperty -Path $gbPath -Name "AutoGameModeEnabled" -Value 0 -PropertyType DWord -Force | Out-Null
		New-ItemProperty -Path $gbPath -Name "AllowAutoGameMode" -Value 0 -PropertyType DWord -Force | Out-Null
		return "PR8: Game Mode restored to default-off state."
	} catch {
		return "PR8 ERROR (Game Mode): $($_.Exception.Message)"
	}
}

# Reset
function Reset-HwGpuSchedulingDefault {
	try {
		$gdPath = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
		Remove-ItemProperty -Path $gdPath -Name "HwSchMode" -ErrorAction SilentlyContinue
		return "PR9: Hardware-acceleration restored to system default."
	} catch {
		return "PR9 ERROR (GPU Scheduling): $($_.Exception.Message)"
	}
}

# Reset to default call
function Invoke-PerformanceDefaultsReset {
	$results = @()
	$results += Set-BalancedPerformancePlan
	$results += Enable-SysMain
	$results += Enable-WSearch
	$results += Enable-DiagTrack
	$results += Enable-Animations
	$results += Enable-Transparency
	$results += Enable-BackgroundApps
	$results += Enable-WindowsTips
	$results += Enable-Hibernation
	$results += Reset-StartupDelayDefault
	$results += Enable-StartupApplications
	$results += Disable-GameMode
	$results += Reset-HwGpuSchedulingDefault
	return $results
}

# Array for main UI buidler (checkbox list)
$PerfTweaks = @(
	@{ Text = "Ultimate Performance Power Plan"; Script = { Set-UltimatePerformance } }
	@{ Text = "Disable SysMain"; Script = { Disable-SysMain } }
	@{ Text = "Disable Windows Search"; Script = { Disable-WSearch } }
	@{ Text = "Disable DiagTrack"; Script = { Disable-DiagTrack } }
	@{ Text = "Disable Window Animations"; Script = { Disable-Animations } }
	@{ Text = "Disable Transparency"; Script = { Disable-Transparency } }
	@{ Text = "Disable Background Apps"; Script = { Disable-BackgroundApps } }
	@{ Text = "Disable Windows Tips"; Script = { Disable-WindowsTips } }
	@{ Text = "Disable Hibernation"; Script = { Disable-Hibernation } }
	@{ Text = "Optimize Startup Delay"; Script = { Optimize-StartupDelay } }
	@{ Text = "Disable Startup Applications"; Script = { Disable-StartupApplications } }
	@{ Text = "Enable Game Mode"; Script = { Enable-GameMode } }
	@{ Text = "Enable Hardware-Acceleration"; Script = { Enable-HwGpuScheduling } }
)
