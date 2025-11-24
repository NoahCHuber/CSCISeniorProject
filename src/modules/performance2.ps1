# performance.ps1
# SwiftEdge Security - Performance Module (Functions Only)
# NO automatic execution. Safe for PS2EXE.

# Performance Tweaks

# PM1 - Set Ultimate Performance 
function Set-UltimatePerformance {
	try {
		powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
		powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
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

# This is what main.ps1 loops through
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
)