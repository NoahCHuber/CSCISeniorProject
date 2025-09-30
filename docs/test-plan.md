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
- [USER-ACCEPTANCE TEST (To be completed by the business office)](#user-acceptance-test-to-be-completed-by-the-business-office)
  - [User-Acceptance Test Strategy](#user-acceptance-test-strategy)
  - [User-Acceptance Test Cases](#user-acceptance-test-cases)
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

The objective of this test plan is to validate and ensure that SwiftEdge Security & Optimizer functions as intended, meets project requirements, and operates reliably under multiple system conditions. Testing will confirm performance enhancements, verify vulnerability scanning accuracy, ensure the ability to rollback changes, and evaluate usability. The goal is to identify defects early and confirm that our solution is a viable and stable product for real-world uses.

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
- PowerShell script, API queries, Registry, & Service operations complete successfully (SW1, SW2, SW9).
- CVE/Application Version Numbers Compared against NVD API CVE/Application Version Numbers checked properly (SW1, SW4, SW6, SW7, SW8).

#### General Functional Requirements
- GUI with a functional tab system with four modules (GFR1).
- Admin privilege prompt/enforcement (GFR2, GFR5).
- Independent or Combined execution of modules (GFR3).
- Status/Completion messages for all operations (GFR4).

#### Performance Module (PM1 - PM7)
- Power plan changes successfully (PM1).
- Disable SysMain, Search, and other non-essential services successfully (PM2).
- Successfully disables performance hits animation/transparency effects (PM3).
- All background apps and startup apps should be disabled (PM4, PM5).
- Startup delay optimized correctly (PM6).
- Prompt Defrag & Optimize drives (PM7).

#### Security Module (SM1 - SM5)
- Successful creation of system restore point (SM1).
- Disabled SMBv1 and Remote features (SM2, SM3).
- Enable proper Windows Defender configuration (SM4).
- System provides confirmation messages before applying major/critical security hardening operations (SM5).

#### Cleanup Module (CM1 - CM7)
- Clear TEMP, %TEMP%, PREFETCH, Update caches, & Recycle Bin (CM1 - CM3).
- Remove checked built-in applications (CM4).
- Clear Event Viewer Logs (CM5).
- Run disk cleanup (CM6).
- Perform any additional cleanup commands to improve organization and performance (CM7).

#### Vulnerability Scanner Module (VSM1 - VSM6)
- Retrieve installed software/version list (VSM1).
- Query NVD API for CVEs & corresponding version list (VSM2).
- Display CVE ID, version number, severity, & summary (if necessary) (VSM3).
- Export results to log file (VSM4).
- Handle API framework/network failure message (VSM5).
- Provide user guidance on vulnerable software if detected (VSM6).

### Features Not to Be Tested

- Future API integrations beyond the current scope (e.g., signed certificates, system update prompting, alternative APIs for vulnerability scanning. 
- Cross-platform compatibility: macOS/Linux will not be tested.
- Non-administrator runtime (Requires elevated permissions).
- Debloat Features: The tool is not a Windows debloater and will not be tested as such. 
- External application removal, installation, or repair is not within scope.
- Legacy Windows versions are not supported and out of scope.
- Performance benchmarking is only relevant to scripts that require completion within a reasonable time frame. 

UNIT TEST
---------

### UNIT TEST STRATEGY / EXTENT OF UNIT TESTING:

Evaluate new features and bug fixes introduced in this release. 
(Specify the properties of test environment: hardware, software, network etc.)

### UNIT TEST CASES

| \#  | OBJECTIVE | INPUT | EXPECTED RESULTS | TEST DELIVERABLES |
| --: | --------- | ----- | ---------------- | ----------------- |
|  1  |           |       |                  |                   |
|  2  |           |       |                  |                   |


REGRESSION TEST
---------------

Ensure that previously developed and tested software still performs after change.

### Regression Test Strategy

Evaluate all reports introduced in previous releases.

### Regression Test Cases

| #   | OBJECTIVE | INPUT | EXPECTED RESULTS | OBSERVED |
| --: | --------- | ----- | ---------------- | -------- |
|  1  |           |       |                  |          |
|  2  |           |       |                  |          |


INTEGRATION TEST
----------------

Combine individual software modules and test as a group.

### Integration Test Strategy and Extent of Integration Testing

Evaluate all integrations with locally developed shared libraries, with consumed services, and other touch points.

### Integration Test Cases

| #   | OBJECTIVE | INPUT | EXPECTED RESULTS | TEST DELIVERABLES |
| --: | --------- | ----- | ---------------- | ----------------- |
|  1  |           |       |                  |                   |
|  2  |           |       |                  |                   |


USER-ACCEPTANCE TEST
--------------------

Verify that the solution works for potential user. Include the method (e.g.,
heuristic, performance measures, thinking aloud, observation, questionnaire, 
interviews, etc.), the number of participants and demographics, the concent
form, *scenarios*, scripts to read, and data collection methods.

### User-Acceptance Test Strategy

(Explain how user acceptance testing will be accomplished.)

### User-Acceptance Test Cases

| #   | TEST ITEM | EXPECTED RESULTS | ACTUAL RESULTS | DATE |
| --: | --------- | ---------------- | -------------- | ---- |
|  1  |           |                  |                |      |
|  2  |           |                  |                |      |


Test Deliverables
-----------------

-   Test Plan Document (this document).
-   Test Cases (Unit, Regression, Integration, and UAT with requirement maps).
-   Test Scripts (PowerShell scripts used for automated checks, including reversion scripts).
-   Defect/Enhancement Logs (Logs of issues, bugs, and suggested improvements from our advisor).
-   Test Execution Logs (Output logs from each module run).
-   Screenshots & System Snapshots (Before/After comparison).
-   Test Result Reports (Summary of testing results, pass/fail status, and status of requirements met).
-   User Acceptance Test & Feedback (Completed by the test group of end users during UAT). 

Schedule
--------

(Provide a summary of the testing schedule, specifying key test milestones, 
and/or provide a link to the detailed schedule.)

Risks
-----

-   (If any risks have been identified, list them here.)
-   (Specify the mitigation plan and the contingency plan for each risk.)


Appendix
--------

(Include any information that is helpful to reference.)
