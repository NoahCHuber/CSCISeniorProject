Test Plan Document
==================
SwiftEdge Security & Optimizer

- [IDENTIFICATION INFORMATION](#identification-information)
  - [Product](#product)
  - [Project Description](#project-description)
  - [Testing Objectives](#testing-objectives)
  - [Features to be Tested](#features-to-be-tested)
  - [Features Not to Be Tested](#features-not-to-be-tested)
- [UNIT TEST](#unit-test)
  - [UNIT TEST STRATEGY / EXTENT OF UNIT TESTING:](#unit-test-strategy--extent-of-unit-testing)
  - [UNIT TEST CASES](#unit-test-cases)
- [REGRESSION TEST](#regression-test)
  - [Regression Test Strategy](#regression-test-strategy)
  - [Regression Test Cases](#regression-test-cases)
- [INTEGRATION TEST](#integration-test)
  - [Integration Test Strategy and Extent of Integration Testing](#integration-test-strategy-and-extent-of-integration-testing)
  - [Integration Test Cases](#integration-test-cases)
- [Test Deliverables](#test-deliverables)
- [Schedule](#schedule)
- [Risks](#risks)
- [Appendix](#appendix)


IDENTIFICATION INFORMATION
--------------------------

### Product

- **Product Name:** SwiftEdge Security & Optimizer

### Project Description

SwiftEdge Security & Optimizer is a lightweight Windows-based software application designed to enhance computer performance and security in a single, streamlined solution. The project aims to eliminate the need for multiple optimization and security tools by integrating system cleanup, performance tuning, and enhanced cybersecurity measures into one intuitive platform. The application offers features such as junk file removal, system optimization, high-risk software version numbers comparison, and generic security checking.

### Testing Objectives

The objective of this test plan is to validate and ensure that SwiftEdge Security & Optimizer functions as intended, meets project requirements, and operates reliably under multiple system conditions. Testing will confirm performance enhancements, verify vulnerability scanning behavior and output, confirm cleanup and security workflows, and evaluate usability. The goal is to identify defects early and confirm that our solution is a viable and stable product for real-world uses.

### Features to be Tested

> Note: Features being tested may change with the addition of new features or alteration of established features. 

#### User Interfaces (R-UI1 - R-UI12)
- GUI design and tab switching (R-UI1, R-UI8, R-UI9).
- Input handling via mouse, keyboard, buttons, and checkboxes (R-UI2, R-UI4, R-UI7).
- Output handling with logs, alerts, and completion status (R-UI3, R-UI10, R-UI12).
- All actions must be completed within a reasonable time frame (R-UI6).

#### Hardware Interfaces (HW1 - HW10)
- Compatibility with Windows 11 x64 systems & Windows-compatible hardware (HW1, HW4).
- Execution of hardware/service interaction commands: powercfg, Stop-Service (HW2, HW9).
- Disk, power, and other service metrics measured in proper units (HW5).
- Completion messages are output correctly and are provided in the log file (HW10).

#### Software Interfaces (SW1 - SW10)
- PowerShell script, NVD feed retrieval, Registry, and service operations complete successfully (SW1, SW2, SW9).
- CVE/application version matching against NVD feed data is handled correctly (SW1, SW4, SW6, SW7, SW8).

#### General Functional Requirements
- GUI with a functional tab system with four modules (GFR1).
- Restore-point workflow and startup warning behavior (GFR2, GFR5).
- Independent execution of modules through the GUI (GFR3).
- Status/Completion messages for all operations (GFR4).

#### Performance Module (PM1 - PM9)
- Power plan changes successfully (PM1).
- Disable SysMain, Search, and other non-essential services successfully (PM2).
- Successfully disables performance hits animation/transparency effects (PM3).
- Background apps should be disabled (PM4).
- Hibernation should be disabled (PM5).
- Startup delay optimized correctly (PM6).
- Startup applications can be disabled and restored through reset workflow (PM7).
- Game Mode and Hardware-Accelerated GPU Scheduling can be enabled (PM8, PM9).

#### Security Module (SM1 - SM6)
- Successful creation of system restore point (SM1).
- Disabled SMBv1 and Remote features (SM2, SM3).
- Enable proper Windows Defender configuration (SM4).
- System provides confirmation messages before applying major/critical security hardening operations (SM5).
- Enable Windows Firewall Features (SM6).

#### Cleanup Module (CM1 - CM7)
- Clear TEMP, %TEMP%, PREFETCH, Update caches, & Recycle Bin (CM1 - CM3).
- Remove checked built-in applications (CM4).
- Clear Event Viewer Logs (CM5).
- Run disk cleanup (CM6).
- Perform any additional cleanup commands to improve organization and performance (CM7).

#### Vulnerability Scanner Module (VSM1 - VSM6)
- Retrieve installed software/version list (VSM1).
- Query NVD feed for CVEs & corresponding version list (VSM2).
- Display ranked vulnerability results with CVE IDs and severity data in the GUI output panel (VSM3).
- Display vulnerability results in GUI output panel (VSM4).
- Handle feed/network failure message (VSM5).
- Provide user guidance on vulnerable software if detected (VSM6).

### Features Not to Be Tested

- Future API integrations beyond the current scope (e.g., signed certificates, system update prompting, alternative APIs for vulnerability scanning. 
- Cross-platform compatibility: macOS/Linux will not be tested.
- Debloat Features: The tool is not a Windows debloater and will not be tested as such. 
- External application removal, installation, or repair is not within scope.
- Legacy Windows versions are not supported and out of scope.
- Performance benchmarking is only relevant to scripts that require completion within a reasonable time frame. 

UNIT TEST
---------

### UNIT TEST STRATEGY / EXTENT OF UNIT TESTING:

Evaluate new features and bug fixes introduced in this release. 

**Hardware:** Windows-compatible x64 desktops/laptops, > 8GB of RAM, SSD preferred. \
**OS:** Windows 11 23H2-24H2. \
**Permissions:** Standard workflow testing may be performed without elevation; restore-point creation has a separate admin warning path.\
**Network:** Online network access required for NVD feed retrieval testing. Cached/offline follow-up testing may be used after initial feed download. \
**Data/Artifacts:** Logs generated by the application should be placed in the Documents folder. \
**Verification Tools:** powercfg, Get-Service, Get-WindowsFeature, Get-Preference, Get-AppxPackage, Application number comparison, timestamped logs, etc. 

### UNIT TEST CASES

| \#  | OBJECTIVE | INPUT | EXPECTED RESULTS | TEST DELIVERABLES |
| --: | --------- | ----- | ---------------- | ----------------- |
|  1  | Verify GUI configuration (4 Tabs)[Req: R-UI1, R-UI8, R-UI9, GFR1] | Launch Script/EXE | Windows Forms GUI opens with 4 set tabs (Performance, Security, Cleanup, Vulnerability) | Screenshot & possible initial log. |
|  2  | Validate basic inputs (tabs & buttons) [Req: R-UI2, R-UI4, R-UI7] | Click each tab & press buttons.| Controls respond, no overlap or improper action. | Screen recording of the function. |
|  3  | Performance: Power & Core Service [Req: PM1, PM2, HW2, HW9] | Click optimize performance button. | Activate Ultimate Power plan and disable SysMain, WSearch, etc. | Before/After Log &Or Screenshots |
|  4  | Performance: Visuals, Background, Startup [Req: PM3, PM4, PM7] | Click optimize performance button | Disables animations/transparency/background apps and disables startup applications for current user (Run key). | Change log &Or Screenshots |
|  5  | Performance: Startup Delay + Gaming Tweaks [Req: PM6, PM8, PM9] | Click optimize performance button | Applies startup-delay tweak and enables Game Mode/HAGS (reboot may be required). | Change Log &Or Screenshots |
|  6  | Restore Point Workflow and Confirmation [Req: SM1, SM5] | Leave restore-point checkbox enabled and continue from opening screen | Restore point attempt is performed, and confirmation or warning is shown before entering the main GUI | Confirmation shown in application log or message box |
|  7  | Security: SMBv1 & Remote Features Disabled [Req: SM2, SM3] | Click/Run security hardening button/module | SMBv1 off, remote services disabled | Feature-Status/confirmation log |
|  8  | Security: Defender configuration & Firewall settings [Req: SM4, SW2] | Click/Run security hardening button/module | Defender real-time/behavior/IOAV enabled, firewall enabled across profiles | Change/Confirmation Log |
|  9  | Cleanup Module: File Cleaning [Req: CM1, CM2, CM3] | Run file cleanup button | TEMP, %TEMP%, PREFETCH, WU cache, Recycle bin cleared. | Change/Confirmation Log |
|  10  | Cleanup Module: Select Package Removal [Req: CM4] | Click cleanup button | Removed select packages for cleaner system. | Change/Confirmation Log |
|  11  | Cleanup: Logs & Disk Cleanup [Req: CM5, CM6, CM7] | Click cleanup button | Extra logs, event logs, disk cleanup run, and miscellaneous extras performed | Free space value & Change/Confirmation Log |
|  12  | Vulnerability Module: NVD Pull/Query [Req: VSM1, VSM2, VSM3, SW1, SW4, SW6, SW8] | Click Run Vulnerability Scanner button | Scans installed app list and versions, retrieves NVD feed data, and matches CVEs. Output shows ranked vulnerable applications with associated CVE IDs and severity data. | Feed pull log, app/version confirmation log |
|  13  | Vulnerability Module: GUI Output, Offline Handling, User Warning [Req: VSM4, VSM5, VSM6] | Click Run Vulnerability Scanner button | Displays results in GUI output panel, handles feed/network failure through visible error messaging, and provides user guidance when CVEs are found. | GUI output capture, confirmation log |

REGRESSION TEST
---------------

### Regression Test Strategy

**Purpose of Regression Testing:** Ensures that previous working functionality remains intact after fixes/changes or new features are created. Re-running low-level tests across all aspects of the application, including UI, Performance, Security, Cleanup, and Vulnerability modules, helps focus on timing limits, restore-point workflow, system changes, and stable logging.

**Hardware:** Windows-compatible x64 desktops/laptops, > 8GB of RAM, SSD preferred. \
**OS:** Windows 11 23H2-24H2. \
**Permissions:** Standard workflow testing may be performed without elevation; restore-point creation has a separate admin warning path.\
**Network:** Online network access required for NVD feed retrieval testing. Cached/offline follow-up testing may be used after initial feed download. \
**Data/Artifacts:** Logs generated by the application should be placed in the Documents folder. \
**Verification Tools:** powercfg, Get-Service, Get-WindowsFeature, Get-Preference, Get-AppxPackage, Application number comparison, timestamped logs, etc. 

### Regression Test Cases

| #   | OBJECTIVE | INPUT | EXPECTED RESULTS | OBSERVED |
| --: | --------- | ----- | ---------------- | -------- |
|  1  | Verify GUI configuration (4 Tabs)[Req: R-UI1, R-UI8, R-UI9, GFR1] | Launch Script/EXE | Windows Forms GUI opens with 4 set tabs (Performance, Security, Cleanup, Vulnerability) | TBD |
|  2  | Re-Validate basic inputs (tabs & buttons) [Req: R-UI2, R-UI4, R-UI7] | Click each tab & press buttons.| Controls respond, no overlap or improper action. | TBD |
|  3  | Verify Performance: Powercfg & Core Services [Req: PM1, PM2, HW2, HW9] | Click optimize performance button. | Activate Ultimate Power plan and disable SysMain, WSearch, etc. | TBD |
|  4  | Verify Performance: Visuals, Background, Startup [Req: PM3, PM4, PM7] | Click optimize performance button | Disables animations/transparency/background apps and disables startup applications for current user (Run key). | TBD |
|  5  | Verify Performance: Startup Delay + Gaming Tweaks [Req: PM6, PM8, PM9] | Click optimize performance button | Applies startup-delay tweak and enables Game Mode/HAGS (reboot may be required). | TBD |
|  6  | Verify Restore Point Workflow and Confirmation [Req: SM1, SM5] | Leave restore-point checkbox enabled and continue from opening screen | Restore point attempt is performed, and confirmation or warning is shown before entering the main GUI | TBD |
|  7  | Verify Changes - Security: SMBv1 & Remote Features Disabled [Req: SM2, SM3] | Click/Run security hardening button/module | SMBv1 off, remote services disabled | TBD |
|  8  | Verify Config - Security: Defender configuration & Firewall settings [Req: SM4, SW2] | Click/Run security hardening button/module | Defender real-time/behavior/IOAV enabled, firewall enabled across profiles | TBD |
|  9  | Check Deletion - Cleanup Module: File Cleaning [Req: CM1, CM2, CM3] | Run file cleanup button | TEMP, %TEMP%, PREFETCH, WU cache, Recycle bin cleared. | TBD |
|  10  | Check Removal - Cleanup Module: Select Package Removal [Req: CM4] | Click cleanup button | Removed select packages for cleaner system. | TBD |
|  11  | Check - Cleanup: Logs & Disk Cleanup [Req: CM5, CM6, CM7] | Click cleanup button | Extra logs, event logs, disk cleanup run, and miscellaneous extras performed | TBD |
|  12  | Verify Query - Vulnerability Module: NVD Pull/Query [Req: VSM1, VSM2, VSM3, SW1, SW4, SW6, SW8] | Click Run Vulnerability Scanner button | Scans installed app list and versions, retrieves NVD feed data, and matches CVEs. Output shows ranked vulnerable applications with associated CVE IDs and severity data. | TBD |
|  13  | Confirm GUI Output & Warnings - Vulnerability Module: GUI Output, Offline Handling, User Warning [Req: VSM4, VSM5, VSM6] | Click Run Vulnerability Scanner button | Displays results in GUI output panel, handles feed/network failure through visible error messaging, and flags user guidance when CVEs are found. | TBD |


INTEGRATION TEST
----------------

### Integration Test Strategy and Extent of Integration Testing

**Purpose of Integration Testing:** Integration testing focuses on verifying that all modules for SwiftEdge operate correctly within the shared Windows Forms GUI. Although each module runs independently, integration testing ensures that shared components such as logging, restore-point creation, and user warnings function consistently across all modules. The main goal is to confirm that all modules can be executed in sequence or out of order without conflict. 

### Integration Test Cases

| #   | OBJECTIVE | INPUT | EXPECTED RESULTS | TEST DELIVERABLES |
| --: | --------- | ----- | ---------------- | ----------------- |
|  1  | Verify GUI & Module Integration: Ensure each tab correctly triggers the corresponding script and updates the UI & log folder. | Execute EXE -> execute one action from each tab. | GUI is stable (No Artifacts), no overlap between actions, and all actions performed correctly for each module. | Screenshots of GUI & Consolidated Log File |
|  2  | Verify Restore Point Integration | Check the box for creating a restore point on the startup screen before entering the main GUI. | A restore point is created during the startup workflow and does not interfere with later GUI actions. | Log or message showing restore point creation. |
|  3  | Consistent Logging Across All Modules | Run each module in sequence and then run each out of order. | Logs from all modules use the same timestamp format and file structure. No missing or duplicated data. | Consolidated log file & Screenshot of separated log files in folder. |
|  4  | Module Execution Stability | Run any of the modules followed by another module. | All modules must complete within a reasonable time, complete successfully, and the GUI must remain responsive throughout execution. | Timestamped log entries for each completed log & possible screenshot of utilized system resources. |
|  5  | Restore Point Warning & GUI Feedback | Launch application with restore-point option enabled without proper admin level. | Restore-point creation warns when elevation is missing, and the GUI still provides the correct warning/feedback path. | Warning message screenshots, screenshot of GUI feedback. |

Test Deliverables
-----------------

-   Test Plan Document (this document).
-   Test Cases (Unit, Regression, and Integration with requirement maps).
-   Defect/Enhancement Logs.
-   Test Execution Logs (Output logs from each module run).
-   Screenshots & System Snapshots (Before/After comparison).
-   Test Result Reports (Summary of testing results, pass/fail status, and status of requirements met).

Schedule
--------

October 26: Unit testing and log validation \
November 5: Regression testing post-fixes \
November 16: Integration testing across modules \
March 16: Testing Performed and Completed \
March 27: Testing Revisions & Updated Documentation

Risks
-----

| Risk                       | Mitigation Plan                 | Contingency Plan              |
| -------------------------- | ------------------------------- | ----------------------------- |
| NVD feed download or network failure | Use cached feed data when available | Retry after connectivity is restored or rerun with cached data |
| Restore point warning path | Continue without restore point or relaunch elevated if needed | Proceed with warning acknowledgement |
| Log corruption             | Enable timestamped log rotation | Backup logs in temp directory |

Appendix
--------

(Include any information that is helpful to reference.)

**Note:** The Test-Plan will be utilized in conducting manual confirmation and verification of scripts and system changes implemented by SwiftEdge.
Please reach out to Noah Huber or Daniel Howard via Email, and we should be available to resolve any issues in a reasonable time frame. Thank you for your understanding. 
