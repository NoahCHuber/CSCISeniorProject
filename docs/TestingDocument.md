# Testing Document

## SwiftEdge Security & Optimizer
**Testing Summary** \
Prepared by: Noah Huber and Daniel Howard  
Date: March 27, 2026  

Table of Contents
=================
* 1 [Testing Purpose](#1-testing-purpose)
* 2 [Testing Approach](#2-testing-approach)
* 3 [Test Environment](#3-test-environment)
* 4 [Test Plan Ideas and Coverage](#4-test-plan-ideas-and-coverage)
* 5 [Manual Testing Steps](#5-manual-testing-steps)
* 6 [Actual Testing Data](#6-actual-testing-data)
* 7 [Interpretation of Results](#7-interpretation-of-results)

## 1. Testing Purpose
This document exists to capture the practical testing work performed for SwiftEdge Security & Optimizer in a single place. It is intended to summarize the testing idea, the manual verification steps used during development, and the observed results recorded for the current implementation.

## 2. Testing Approach
Testing for this project is developer-driven and centered on functional verification of the implemented modules. The current testing process focuses on:

- Launch and GUI validation
- Performance module verification
- Security module verification
- Cleanup module verification
- Vulnerability scanner verification
- Build and packaging verification

The project testing strategy was designed to emphasize measurable and visible outcomes such as GUI behavior, registry or service changes, log output, completion prompts, and vulnerability output in the scanner panel.

This document distinguishes between two kinds of evidence during review:

- Pass: supported by the maintained test-plan baseline, project notes, and current implementation review
- Fail: machine-dependent items that may vary by the Windows device being tested

## 3. Test Environment
The documented project test environment is based on the current project requirements and test-plan baseline:

- Operating System: Windows 11 x64
- Runtime: PowerShell 5.1+
- Permissions: Standard workflow tasks can be completed without elevation; some system-level actions, such as restore-point creation and certain machine-wide registry or service changes, may require administrator rights on the target Windows device
- Tools: PowerCfg, Get-Service, Get-ItemProperty, cleanmgr, Windows Forms GUI, and NVD feed retrieval
- Logging: Module log output written to the user Documents log folder

## 4. Test Plan Ideas and Coverage
The project test-plan idea is to validate each module both independently and in the context of the shared GUI. The intended coverage includes:

- Confirm the GUI launches correctly and all tabs are reachable
- Confirm each module runs from the correct tab and gives completion feedback
- Confirm logs are written during execution
- Confirm restore-point prompting and warning behavior at startup
- Confirm major system-level actions align with the selected module
- Confirm the vulnerability scanner retrieves feed data and produces output
- Confirm the build workflow can produce combined and executable outputs

The current testing record is aligned to the active unit, regression, and integration cases in the maintained test plan. Where the original objective cases were broader than the current implementation, this document follows the current codebase rather than the older wording. Examples include:

- vulnerability scanning is described in terms of NVD feed retrieval and ranked GUI output rather than full per-CVE summaries
- module execution is treated as independent tab-based execution rather than an all-in-one workflow
- restore-point handling is recorded as a startup workflow with confirmation or warning behavior rather than as a blanket elevation gate for the whole application

The maintained detailed testing baseline remains in:

- [Test Plan](/docs/test-plan.md)

## 5. Manual Testing Steps
### 5.1 GUI and Workflow
1. Launch the script or executable.
2. Observe the welcome screen and restore-point prompt.
3. Select or deselect option for restore-point and observe changes.
4. Select continue into the main GUI.
5. Select each module tab and confirm the layout appears correctly.

### 5.2 Performance Module
1. Open the Performance tab.
2. Select one or more performance options.
3. Run the module.
4. Confirm completion messaging and log output in Documents Folder.

### 5.3 Security Module
1. Open the Security tab.
2. Select one or more security options.
3. Run the module.
4. Confirm completion messaging and log output in Documents Folder.

### 5.4 Cleanup Module
1. Open the Cleanup tab.
2. Select one or more cleanup options.
3. Run the module.
4. Confirm completion messaging and log output in Documents Folder.

### 5.5 Vulnerability Scanner
1. Open the Vulnerability tab.
2. There is a known vulnerable software on the computer.
3. Run the scanner.
4. Wait for feed retrieval or local cache usage.
5. Review scanner results in the output panel.
6. Review scanner output and update vulnerable applications. 
7. Update software and re-run scanner until zero vulnerabilites found.

### 5.6 Build Verification
1. Run the build workflow from the project root.
2. Confirm the combined script is generated.
3. Confirm executable generation is available through the build script.

## 6. Actual Testing Data

Actual testing data obtains combines test cases in the test-plan.md. 

| Test Area | Initial State | Test Steps | Expected Outcome | Actual Outcome |
| --------- | ------------- | ---------- | ---------------- | -------------- |
| GUI Launch and Layout | Application closed | Launch the script or executable and continue through the opening workflow | Welcome screen appears, restore-point prompt is shown, and the main GUI opens with four tabs | The application opens into the welcome screen and then loads the four main tabs correctly. This covers the GUI launch and tab layout checks from the test plan. |
| GUI Navigation and Controls | GUI open | Click each tab, review the buttons, and verify module layout | Tabs display correctly and controls remain responsive | The tabs, buttons, and module controls respond correctly and stay aligned with the current GUI workflow. This covers the basic input and navigation checks in the test plan. |
| Restore Point Workflow | Application launched from startup screen | Leave the restore-point option enabled and continue | Restore-point attempt is performed, and the user receives confirmation or warning before entering the main GUI | The startup workflow handles restore-point creation and user messaging correctly before entering the main interface. This matches the restore-point coverage in the test plan. |
| Performance Module Core Services | Pre-change system state | Select power-plan and service options and run the Performance module | Power plan and selected service changes apply and log output is written | The performance module applies the main power and service changes correctly and returns log-friendly results. This covers the core performance test cases in the test plan. |
| Performance Module Startup and Gaming Tweaks | Pre-change user and graphics settings | Run startup-delay, startup-application, Game Mode, and HAGS options from the Performance tab | Registry-backed performance options apply and module feedback is shown | Machine dependent, but passed on the test machine. Startup items, Game Mode, and HAGS worked as expected during testing. |
| Security Module Hardening | Pre-change security state | Select SMB, remote-feature, Defender, and firewall options and run the Security module | Security settings harden correctly and logs are written | Machine dependent, but passed on the test machine. The security options applied correctly during testing. |
| Cleanup Module Execution | Cleanup targets present | Select cleanup options and run the Cleanup module | Cleanup tasks complete and write result logs | The cleanup module runs the current temp-file, cache, recycle-bin, app-removal, event-log, and Disk Cleanup tasks as expected. This matches the cleanup scope in the test plan. |
| Vulnerability Scanner Feed Processing | Scanner idle, feed not yet processed in session. Known vulnerabilities on the system. | Run the scanner from the Vulnerability tab | Feed is retrieved or reused from cache, installed applications are matched, and results display in the output panel | The scanner retrieves or reuses the NVD feed, checks installed applications, and produces ranked results in the GUI. This matches the scanner workflow in the test plan. |
| Vulnerability Output and Guidance | Scanner has completed a run | Review the vulnerability output panel after a completed scan | Ranked vulnerable applications, CVE IDs, severity data, and update/removal guidance are displayed | The output shows ranked vulnerable applications, CVE IDs, severity information, and update guidance in the GUI. This matches the current vulnerability output requirements in the test plan. |
| Logging Behavior and Cross-Module Execution | At least one module action completed | Run multiple modules in sequence and review the log output | Logs contain timestamped results, and sequential module execution remains stable | Logging stays consistent across module runs, and the modules can be executed one after another without breaking the workflow. This covers the integration logging and stability checks. |
| Build Verification | Modular project source present | Run the build workflow from the project root | Combined script and executable build path are available | The build workflow successfully creates the combined script and executable output. This matches the packaging and build expectations for the current project. |

## 7. Interpretation of Results
The current testing evidence indicates that SwiftEdge is functioning as an integrated tool rather than as a collection of disconnected scripts. The most strongly supported results are the GUI structure, module execution wiring, vulnerability-scanner workflow, and logging behavior, because those areas are backed both by the current implementation and the maintained project tests.

The most important caution in the current record is that some results are machine-dependent even though they passed on the test machine. That is especially true for registry-backed performance changes and some security settings, because the final result can vary based on Windows version, Defender state, local policy, hardware support, and whether a restart is required.

Overall, the testing record supports the conclusion that the implemented project meets its core functional goals. The strongest next step is to capture a few supporting screenshots or logs for the machine-dependent rows so the defense evidence is even clearer.
