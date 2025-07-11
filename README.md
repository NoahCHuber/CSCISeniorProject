# SwiftEdge Security & Optimizer

## Brief Project Description

SwiftEdge Security & Optimizer is a lightweight software application designed to enhance computer performance and security in a single, streamlined solution. The project aims to eliminate the need for multiple optimization and security tools by integrating system cleanup, performance tuning, and enhanced cybersecurity into one intuitive platform.

The application offers features such as junk file removal, system optimization, high-risk software version numbers, and real-time security checking. By leveraging automation and smart search algorithms, SwiftEdge enhances device speed, prevents slowdowns, and safeguards against cyber threats without requiring constant user intervention.

## Compile/Deploy

This application is developed using PowerShell scripts and will be compiled into a single executable using PS2EXE. 
This application must be run using administrator privileges when opening the .exe. A Windows Form should open and the user can select the options they would like before running the script for each section. The GUI is modular and each section will have its own interface and button to execute the script. To learn more details please see the user interface section in the requirements document. 
> NOTE: All changes performed using scripts can be reverted using the revert script for each module or as a whole. 

## Usage

System Clean Up (Unused System Files)   
Performance Optimizations (Changes Registry for performance booster)       
Security Check and Hardening (Checks for Generic Vulnerabilities and Optional System Hardening)      
Software Version Checker (Checks Software Version Numbers for Vulnerabilities using external NVD CVE)      

## Suggested Options 

**Performance Module:**
> Options focused on improving speed, responsiveness, and reducing system overhead:

- Set Power Plan to “High Performance” or “Ultimate Performance”
- Disable SysMain (Superfetch) service
- Disable Search Indexing (WSearch)
- Disable Xbox-related services (XblAuthManager, XblGameSave, etc.) (optional)
- Disable background apps via registry
- Remove startup delay via registry
- Turn off Windows animations and visual effects
- Disable telemetry-related scheduled tasks
- Adjust visual settings for best performance
- Restart Windows Explorer (quick refresh option)

**Security Hardening Module:**
> Options for improving system security and reducing the attack surface:

- Disable SMBv1 protocol
- Disable Remote Assistance
- Disable Remote Registry
- Enable Windows Defender cloud protection
- Enable Windows Defender tamper protection
- Disable Windows Script Host
- Configure basic outbound firewall rules
- Disable data collection and telemetry features
- Disable Wi-Fi Sense
- Create a System Restore Point before changes

**System Cleanup Module:**
> Options for removing junk, temp files, and unnecessary applications:

- Clean %TEMP% and C:\Windows\Temp
- Clear prefetch/superfetch cache
- Clear Windows Update cache
- Remove old system restore points (optional)
- Clear Event Viewer logs
- Uninstall OneDrive (optional)
- Remove Xbox Game Bar and Feedback Hub (optional)
- Disable hibernation (optional)
- Run Disk Cleanup silently
- Empty Recycle Bin

**Vulnerability & Software Scanning Module:**
> Options for inspecting installed applications and identifying known risks:

- Scan and list installed programs with versions
- Query NVD API for known vulnerabilities
- Query Vulners API for advanced CVE info (optional)
- Display CVE ID, severity score (CVSS), and summary
- Export vulnerability results to TXT or CSV
- Flag outdated or unsupported software

**Optional:** Check for latest versions of detected software

## Testing
> This section outlines the key validation and testing criteria for SwiftEdge Security. Each feature module must function independently and correctly, without requiring external runtimes or manual configuration. The following checklist ensures that all performance, security, cleanup, and vulnerability scan operations perform as expected in the final executable version.

**General Application Behavior:**
| *Test Case*	                                   | *Expected Result*                                         |
| ---------------------------------------------- | --------------------------------------------------------- |
| Application launches without errors	           | Main GUI loads with all tabs and buttons functional       |
| GUI layout renders properly              	     | All text is visible and no elements are clipped           |
| Runs without requiring external dependencies	 | No errors related to ps1, .NET Core, or external database |
| Elevated permissions are requested when needed | UAC prompt appears for operations requiring admin rights  |
| Log files are generated when enabled	         | Logs record operation timestamps and success/failure      |   

**Performance Module Checklist:**
| *Test Case*	                                  | *Expected Result*                                   |
| --------------------------------------------- | --------------------------------------------------- |
| A high-performance power plan is applied	    | Power plan changes are confirmed via powercfg       |
| SysMain and WSearch services are disabled	    | Services are stopped and set to Disabled            |
| Background apps disabled in registry	        | Registry key reflects the correct setting           |
| Visual effects are turned off	                | Animations and transparency are disabled            |
| Startup delay removed	                        | Registry key StartupDelayInMSec is set to 0         |
| Indexing is turned off on C: drive	          | Indexing checkbox is cleared under drive properties |
| Explorer restart button functions	            | Explorer restarts without crashing                  |   

**Security Hardening Checklist:**
| *Test Case*	                                  | *Expected Result*                                                 | 
| --------------------------------------------- | ----------------------------------------------------------------- |
| SMBv1 is disabled	                            | Feature is not listed in Windows Features                         | 
| Remote assistance and registry are disabled	  | Services are stopped and the registry reflects the disabled state | 
| Windows Defender settings are updated	        | Tamper protection and cloud protection are enabled                | 
| A system restore point is created	            | Restore point is visible in the System Restore panel              | 
| Telemetry and tracking features are off	      | Data collection registry keys are set correctly                   | 

**Cleanup Module Checklist:**
| *Test Case*	                              | *Expected Result*                                       | 
| ----------------------------------------- | ------------------------------------------------------- |
| Temporary folders are emptied	            | %TEMP% and C:\Windows\Temp show a reduced file count    | 
| Event Viewer logs are cleared	            | Application/System/Security logs show no recent entries | 
| Windows Update cache is cleared	          | SoftwareDistribution\Download folder is empty           | 
| Preinstalled apps removed	                | App list no longer includes OneDrive/Xbox               | 
| RecycleBin is emptied	                    | Bin is confirmed to be empty                            |    

**Vulnerability Scanning Checklist:**
| *Test Case*	                               | *Expected Result*                                  | 
| ------------------------------------------ | -------------------------------------------------- |
| The installed software list is retrieved	 | The List shows app names and version numbers       | 
| NVD API is queried successfully	           | CVEs with IDs, summaries, and CVSS scores appear   | 
| Optional Vulners API returns valid         | JSON	Results that match expected software versions | 
| Export to TXT or CSV works                 | File is created with scan results                  |    
| No connection = graceful failure	         | App shows a message without crashing               |     

**Pass/Fail Criteria:**   \
*Pass:* All core modules are complete with no errors, changes confirmed, and scan results displayed or exported.

*Fail:* Application crashes do not apply expected system changes or do not retrieve vulnerability data when online.
