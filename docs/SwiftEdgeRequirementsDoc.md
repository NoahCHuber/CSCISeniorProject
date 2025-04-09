# Software Requirements Document

## SwiftEdge Security & Optimizer
Version: 1.0 (Pre-release)  
Prepared by: Noah Huber and Daniel Howard  
Organization: SwiftEdge Security   
Date Created: April 8th, 2025  

Table of Contents
=================
* [Revision History](#revision-history)
* 1 [Introduction](#1-introduction)
  * 1.1 [Document Purpose](#11-document-purpose)
  * 1.2 [Product Scope](#12-product-scope)
  * 1.3 [Definitions, Acronyms, and Abbreviations](#13-definitions-acronyms-and-abbreviations)
  * 1.4 [References](#14-references)
  * 1.5 [Document Overview](#15-document-overview)
* 2 [Product Overview](#2-product-overview)
  * 2.1 [Product Perspective](#21-product-perspective)
  * 2.2 [Product Functions](#22-product-functions)
  * 2.3 [Product Constraints](#23-product-constraints)
  * 2.4 [User Characteristics](#24-user-characteristics)
  * 2.5 [Assumptions and Dependencies](#25-assumptions-and-dependencies)
* 3 [Requirements](#3-requirements)
  * 3.1 [External Interfaces](#31-external-interfaces)
    * 3.1.1 [User Interfaces](#311-user-interfaces)
    * 3.1.2 [Hardware Interfaces](#312-hardware-interfaces)
    * 3.1.3 [Software Interfaces](#313-software-interfaces)
  * 3.2 [Functional](#32-functional)
  * 3.3 [Quality of Service](#33-quality-of-service)
    * 3.3.1 [Performance](#331-performance)
    * 3.3.2 [Security](#332-security)
    * 3.3.3 [Reliability](#333-reliability)
    * 3.3.4 [Availability](#334-availability)
  * 3.4 [Compliance](#34-compliance)
  * 3.5 [Design and Implementation](#35-design-and-implementation)
    * 3.5.1 [Installation](#351-installation)
    * 3.5.2 [Distribution](#352-distribution)
    * 3.5.3 [Maintainability](#353-maintainability)
    * 3.5.4 [Reusability](#354-reusability)
    * 3.5.5 [Portability](#355-portability)
    * 3.5.6 [Cost](#356-cost)
    * 3.5.7 [Deadline](#357-deadline)
    * 3.5.8 [Proof of Concept](#358-proof-of-concept)
* 4 [Verification](#4-verification)
  * 4.1 [Product Testing and Verification](#41-product-testing-and-verification)
* 5 [References](#5-references)
  * 5.1 [Documentation](#51-documentation)
  * 5.2 [Github Repositories](#52-github-repositories)
  * 5.3 [BAD EXAMPLES OF SOFTWARE](#53-bad-examples-of-software)

## Revision History
|  Name(s)  |    Date    |    Reason For Changes   |   Version   |
| --------- | ---------- | ----------------------- | ----------- |
|   Swift   | 2025-08-04 | Intiial Requirments Doc |     1.0     |
|           |            |                         |             |
|           |            |                         |             |

## 1. Introduction
> This document defines the system requirements for SwiftEdge Security, a modular, GUI-based Windows utility designed to improve system performance, enhance security, perform cleanup operations, and check for known vulnerabilities. Developed entirely in PowerShell with a Windows Forms front end, this tool provides users with a streamlined interface and powerful functionality—all packaged as a standalone executable.

This Software Requirements Document (SRD) aims to outline the functional and non-functional requirements of SwiftEdge Security, including performance targets, security expectations, user interaction, system interfaces, and constraints. It serves as a single reference point for developers, testers, and academic advisors to ensure a consistent understanding of the system’s scope, behavior, and expected outcomes. This document is intended for software developers, academic advisors, and IT professionals who are interested in the design, implementation, and implications of the application. This document also includes references for external APIs, packaging tools, and third-party components used during development. 

### 1.1 Document Purpose
This document aims to define the software requirements for SwiftEdge Security & Optimizer, a performance and security utility for Windows systems. The application is developed using PowerShell and utilizes Windows Forms to deliver a sleek, modern, and minimal GUI. SwiftEdge Security is designed to improve performance, enhance system security, perform system cleanups, and provide vulnerability scanning by interfacing with open-source Common Vulnerabilities and Exposures(CVE) APIs. It is built to be a one-stop solution for IT professionals, cybersecurity students, and system administrators who need a lightweight yet powerful tool without external frameworks.

### 1.2 Product Scope
SwiftEdge Security is a modular utility for Windows designed to streamline system maintenance and protection through four key functions: performance tuning, security hardening, system cleanup, and vulnerability scanning. Each module operates independently, offering users a focused experience through a unified PowerShell-based GUI. 
This software operates as a self-contained executable that performs real-time system configuration tasks using native Windows features and external vulnerability databases. Its intended use is for enhancing local machine performance and reducing exposure to known vulnerabilities—without requiring deep system knowledge or large, third-party frameworks.

Key deliverables for this version (v1.0) include:
- Provide a lightweight, portable, and efficient tool for optimizing and securing Windows systems.
- Replace the need for multiple standalone scripts or tools by consolidating core administrative tasks into a unified interface.
- Offer open-source vulnerability checking through integration with APIs like the National Vulnerability Database (NVD) and Vulners.
- Deliver a clean and professional GUI experience without requiring .NET installation or third-party frameworks—ensuring minimal dependencies and maximum accessibility.
- Compatibility with Windows 11.
- A Windows Forms-based GUI with tab navigation.

SwiftEdge Security aligns with broader educational and practical goals by offering a real-world cybersecurity solution that demonstrates scripting, GUI design, API integration, and system administration techniques, all while addressing key points in day-to-day Windows system management.

### 1.3 Definitions, Acronyms and Abbreviations
> Below are definitions, acronyms, or abbreviations used through the SRD.

**GUI:** Graphical User Interface  
**SRD:** Software Requirements Document  
**IT:** Information Technology  
**API:** Application Programming Interface  
**CVE:** Common Vulnerabilities and Exposures  
**NVD:** National Vulnerability Database  
**AV:** Anti-Virus  
**Powershell:** 	A command-line shell and scripting language designed for system admin tasks in Windows.  
**PS2EXE:** 	A third-party PowerShell module used to compile .ps1 scripts into standalone Windows executable (.exe) files.  
**Windows Forms:** A GUI framework in the .NET platform used for building desktop interfaces, accessible through PowerShell.  
**Module:** A specific functional unit within SwiftEdge Security (e.g., Performance, Security, Cleanup, or Vulnerability Scan).  
**Standalone Executable:** A self-contained application that does not require the installation of external frameworks to run.  

### 1.4 References
> This Software Requirements Document (SRD) does not rely on any previously established vision or scope document. All project-related references, including external tools, APIs, and third-party components, are included in Section 5 – References.

### 1.5 Document Overview
>This document is structured to comprehensively define the requirements for the SwiftEdge Security software. It is organized to follow industry-standard software engineering practices to ensure clarity, traceability, and completeness throughout the software development lifecycle.

*Below are the sections of this document with a brief overview of what each section contains.*

**Section 2 – Product Overview:** 
*Provides general background information, including the system's origin, its major functionalities, external constraints, user characteristics, assumptions, and how requirements are distributed across the software's components.*

**Section 3 – Requirements:** 
*Details both the functional and non-functional requirements of the system. This includes software features, quality attributes (such as performance, reliability, and security), and compliance with standards or regulations. External interfaces and design constraints are also described here.*

**Section 4 – Verification:** 
*Outlines how the software will be tested and validated against the requirements specified in Section 3. It includes the planned verification methods and criteria for determining successful implementation.
(Due to the size of this project, actual verification of the software will not be filed)*

**Section 5 – Appendices:** 
*Contains any supplemental material, such as references, diagrams, mockups, glossaries, and additional documentation that support or extend the main content of the SRD.*

## 2. Product Overview
> This section should describe the general factors that affect the product and its requirements. This section does not state specific requirements. Instead, it provides a background for those requirements, which are defined in detail in Section 3, and makes them easier to understand.

### 2.1 Product Perspective
SwiftEdge Security is a new, self-contained system developed as a standalone utility for Windows 11 environments. It is not part of an existing software family and does not serve as a direct replacement for any commercial or enterprise-level product. However, it draws conceptual inspiration from tools like Chris Titus Tech’s Windows Utility, Talon by RavenDevTeam, and Azurite Optimizer, while providing a cleaner, more security-driven PowerShell-native alternative.

This product is designed to consolidate multiple commonly used administrative and security actions—such as disabling bloatware, optimizing performance settings, and checking for known software vulnerabilities inside a unified user interface. By building the software entirely in PowerShell and packaging it with PS2EXE, SwiftEdge Security eliminates the need for Python runtimes, Python wrapping with Nuitka, third-party debloaters, and manual PowerShell script execution.

**There are no direct dependencies on other systems. However, it does interface with:**
- The Windows Registry (for performance and privacy tweaks),
- The Windows Service Controller (to manage and disable services),
- The NVD API (to retrieve vulnerability data based on installed software),
- Local system components like Power Plans, Disk Cleanup, Defragmentation, and Temp File Directories.

### 2.2 Product Functions
> SwiftEdge Security provides a modular interface that enables users to perform common system maintenance, optimization, and security tasks on Windows 11 systems. Each function is encapsulated within its own script and is accessible via a centralized GUI.

**At a high level, the product must allow users to:**   

*Performance Optimization*
- Enable the High Performance or Ultimate Performance power plan. 
- Disable non-essential services such as SysMain and Windows Search.
- Disable background apps, animations, and transparency effects.
- Optimize registry settings for boot and responsiveness improvements.

*Security Hardening*
- Disable vulnerable or unnecessary services (e.g., SMBv1, Remote Assistance).
- Enable key Windows Defender features like tamper protection and memory integrity.
- Apply firewall or system-level security tweaks to reduce attack surface.
- Offer the option to create a System Restore Point before applying changes.

*System Cleanup*
- Clear system temp folders and Windows Update caches.
- Remove unused or unwanted built-in Windows applications.
- Clear Event Viewer logs and optionally disable hibernation.
- Free up storage by automating disk cleanup and emptying the recycle bin.

*Vulnerability Scanning*
- Detect installed applications and retrieve their version numbers.
- Query open-source CVE databases (e.g., NVD API) to identify known vulnerabilities.
- Display CVE results with severity scores and summaries.
- Allow export of scan results to CSV or TXT.

*User Interface and Workflow*
- Provide a tab-based GUI built in PowerShell using Windows Forms.
- Require administrative privileges for critical operations.
- Display status and result feedback within the GUI.
- Function as a standalone EXE file requiring no third-party framework installation.

### 2.3 Product Constraints
> The following constraints define limitations that impact the design, development, or implementation of SwiftEdge Security:

**Interface Constraints:**
- The graphical user interface (GUI) must be implemented using Windows Forms within PowerShell, limiting the available design flexibility compared to full GUIs like Tkinter, .NET, or other web-based frameworks.
- All modules must be accessible through a tabbed layout, restricting deeper nested features or advanced navigation models.
The application will run only on Windows 11 (64-bit) systems and does not support macOS or Linux environments.

**Quality of Service Constraints:**
- All actions must complete with minimal delay (under 30 seconds), particularly on low-end systems with 4GB RAM and dual-core processors.
- Vulnerability scanning requires internet access and may be limited by API rate limits or response time from external databases.

**Standards and Compliance Constraints:**
- PowerShell scripts must comply with Windows Execution Policy and may require elevated privileges (Administrator access) to perform system-level changes.
- When deployed in educational or institutional settings, the tool must not violate FERPA, PII handling guidelines, or local IT usage policies.

**Design and Implementation Constraints:**
- The application must be built using only PowerShell 5.1+ without relying on third-party frameworks such as Python, Node.js, or compiled .NET projects.
- Final distribution must be in the form of a standalone executable created with PS2EXE, requiring all features to be embedded within a single compiled script.
- Modules must remain functionally independent, avoiding shared state or dependencies across performance, security, cleanup, or scanning functions.

### 2.4 User Characteristics
> SwiftEdge Security is designed with usability in mind, targeting a range of user classes with varying levels of technical expertise. The software’s simple, tab-based interface and modular structure allow it to serve both professional and non-professional users, with most functionality accessible in a few clicks. User groups are distinguished based on how frequently they use the tool, their level of system access, and their understanding of Windows system administration.

**Primary User Classes:**   
**1. IT Professionals / System Administrators**   
**Role:** *Maintain Windows systems in school districts, small businesses, or tech support environments.*   
**Technical Skill Level:**  *Intermediate to advanced.*   
**Frequency of Use:** *Moderate to frequent.*   
**Privileges:** *Full administrative access.*   
**Modules Used:** *All (Performance, Security, Cleanup, Vulnerability Scan).*   
**Priority Level:** *High — this group is most critical to satisfy, as they will benefit the most from the tool’s full range of features.*   

**2. Cybersecurity Students / Technical Interns**   
**Role:** *Use SwiftEdge Security for learning, testing, or auditing basic vulnerabilities and configurations.*   
**Technical Skill Level:** *Moderate.*   
**Frequency of Use:** *Occasional or course-dependent.*   
**Privileges:** *May have admin access depending on system policy.*   
**Modules Used:** *Primarily Security and Vulnerability Scan.*   
**Priority Level:** *High — aligns with the educational purpose of the tool.*   

**Secondary User Classes:**   
**3. Power Users / Tech Enthusiasts**   
**Role:** *Use the tool to maintain personal machines or optimize performance.*   
**Technical Skill Level:** *Moderate (comfortable with system settings, but not scripting).*   
**Frequency of Use:** *Infrequent or as-needed basis.*   
**Privileges:** *Typically have admin rights on personal machines.*   
**Modules Used:** *Performance and Cleanup.*   
**Priority Level:** *Medium — important for usability and adoption but not the core focus.*   

**4. Casual Users (Non-Technical):**   
**Role:** *End users seeking a "one-click" cleanup or performance boost.*   
**Technical Skill Level:** *Basic.*   
**Frequency of Use:** *Rare.*   
**Privileges:** *May lack admin access.*   
**Modules Used:** *Mostly Cleanup; limited use of other tabs.*   
**Priority Level:** *Low — tool will still function for this group, but with limited results or without admin-required features.*   

### 2.5 Assumptions and Dependencies
>The development and functionality of SwiftEdge Security rely on several assumptions and external dependencies. These are not guaranteed conditions but are considered true for the successful design, testing, and use of the software. If any of these assumptions prove to be invalid or these dependencies change, they may impact the final requirements or functionality of the system.

**Assumptions:**
- The end user will have administrative privileges on the Windows system to apply performance, security, and cleanup configurations.
- The operating environment is assumed to be Windows 11 (64-bit) or later, with PowerShell 5.1+ pre-installed.
- The system will have access to the internet when using the Vulnerability Scanner module to query external APIs.
- End users are expected to have basic to moderate familiarity with system maintenance tools and GUI-based applications.
- Windows will maintain consistent registry and service names (e.g., SysMain, DiagTrack) relevant to script logic.
- The PS2EXE module used to compile the application into an .exe will remain compatible with PowerShell 5.1 and Windows Forms functionality.

**Dependencies:**
- NVD API is used to retrieve CVE information for the Vulnerability Scanner module. This dependency includes:
- Continued availability and free access to the API.
- Stability of response formats (JSON).
- The application relies on several native Windows tools and services, including:
- powercfg, Get-Service, Stop-Service, Get-ItemProperty, and cleanmgr.
- All external scripts and modules (e.g., PS2EXE) must be downloadable and usable within the project’s timeframe.
- No commercial libraries, SDKs, or paid APIs are required or integrated into the system.

*These assumptions and dependencies form the basis for requirement decisions and software behavior. If any become invalid or unsupported, adjustments in requirements, testing, or distribution methods may be necessary.*

## 3. Requirements
> This section specifies the software product's requirements. Specify all of the software requirements to a level of detail sufficient to enable designers to design a software system to satisfy those requirements, and to enable testers to test that the software system satisfies those requirements.

> The specific requirements should:
* Be uniquely identifiable.
* State the subject of the requirement (e.g., system, software, etc.) and what shall be done.
* Optionally state the conditions and constraints, if any.
* Describe every input (stimulus) into the software system, every output (response) from the software system, and all functions performed by the software system in response to an input or in support of an output.
* Be verifiable (e.g., the requirement realization can be proven to the customer's satisfaction)
* Conform to agreed upon syntax, keywords, and terms.

### 3.1 External Interfaces
> This subsection defines all the inputs into and outputs requirements of the software system. Each interface defined may include the following content:
* Name of item
* Source of input or destination of output
* Valid range, accuracy, and/or tolerance
* Units of measure
* Timing
* Relationships to other inputs/outputs
* Screen formats/organization
* Window formats/organization
* Data formats
* Command formats
* End messages

#### 3.1.1 User interfaces
Define the software components for which a user interface is needed. Describe the logical characteristics of each interface between the software product and the users. This may include sample screen images, any GUI standards or product family style guides that are to be followed, screen layout constraints, standard buttons and functions (e.g., help) that will appear on every screen, keyboard shortcuts, error message display standards, and so on. Details of the user interface design should be documented in a separate user interface specification.

Could be further divided into Usability and Convenience requirements.

#### 3.1.2 Hardware interfaces
Describe the logical and physical characteristics of each interface between the software product and the hardware components of the system. This may include the supported device types, the nature of the data and control interactions between the software and the hardware, and communication protocols to be used.

#### 3.1.3 Software interfaces
Describe the connections between this product and other specific software components (name and version), including databases, operating systems, tools, libraries, and integrated commercial components. Identify the data items or messages coming into the system and going out and describe the purpose of each. Describe the services needed and the nature of communications. Refer to documents that describe detailed application programming interface protocols. Identify data that will be shared across software components. If the data sharing mechanism must be implemented in a specific way (for example, use of a global data area in a multitasking operating system), specify this as an implementation constraint.

### 3.2 Functional
> This section specifies the requirements of functional effects that the software-to-be is to have on its environment.

### 3.3 Quality of Service
> This section states additional, quality-related property requirements that the functional effects of the software should present.

#### 3.3.1 Performance
If there are performance requirements for the product under various circumstances, state them here and explain their rationale, to help the developers understand the intent and make suitable design choices. Specify the timing relationships for real time systems. Make such requirements as specific as possible. You may need to state performance requirements for individual functional requirements or features.

#### 3.3.2 Security
Specify any requirements regarding security or privacy issues surrounding use of the product or protection of the data used or created by the product. Define any user identity authentication requirements. Refer to any external policies or regulations containing security issues that affect the product. Define any security or privacy certifications that must be satisfied.

#### 3.3.3 Reliability
Specify the factors required to establish the required reliability of the software system at time of delivery.

#### 3.3.4 Availability
Specify the factors required to guarantee a defined availability level for the entire system such as checkpoint, recovery, and restart.

### 3.4 Compliance
Specify the requirements derived from existing standards or regulations, including:  
* Report format
* Data naming
* Accounting procedures
* Audit tracing

For example, this could specify the requirement for software to trace processing activity. Such traces are needed for some applications to meet minimum regulatory or financial standards. An audit trace requirement may, for example, state that all changes to a payroll database shall be recorded in a trace file with before and after values.

### 3.5 Design and Implementation

#### 3.5.1 Installation
Constraints to ensure that the software-to-be will run smoothly on the target implementation platform.

#### 3.5.2 Distribution
Constraints on software components to fit the geographically distributed structure of the host organization, the distribution of data to be processed, or the distribution of devices to be controlled.

#### 3.5.3 Maintainability
Specify attributes of software that relate to the ease of maintenance of the software itself. These may include requirements for certain modularity, interfaces, or complexity limitation. Requirements should not be placed here just because they are thought to be good design practices.

#### 3.5.4 Reusability
<!-- TODO: come up with a description -->

#### 3.5.5 Portability
Specify attributes of software that relate to the ease of porting the software to other host machines and/or operating systems.

#### 3.5.6 Cost
Specify monetary cost of the software product.

#### 3.5.7 Deadline
Specify schedule for delivery of the software product.

#### 3.5.8 Proof of Concept
<!-- TODO: come up with a description -->

## 4. Verification
> This section outlines the key validation and testing criteria for SwiftEdge Security. Each feature module must function independently and correctly, without requiring external runtimes or manual configuration. The following checklist ensures that all performance, security, cleanup, and vulnerability scan operations perform as expected in the final executable version.

### 4.1 Product Testing and Verification

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

## 5. References
> References listed below are split between documentation and GitHub repositories for inspired projects.

### 5.1 Documentation
Style Guide for SRD: [SRS-Template - Jam01](https://github.com/jam01/SRS-Template/tree/master)   
NIST NVD Developer Database: [NIST NVD Database](https://nvd.nist.gov/developers/start-here)   
CVE Program: [CVE Program](https://www.cve.org/)   
Avast Security (GUI Inspiration): [Avast Security](https://www.avast.com/)   
Norton 360 (Software Version Scanning Inspiration): [Norton360](https://us.norton.com/products/norton-360-standard)   
Chris Titus WinUtil (Inspiration): [ChrisTitus - WinUtil](https://christitus.com/windows-tool/)   
RavenDevTeam Talon (Inspiration): [RavenDevTeam - Talon](https://ravendevteam.org/software/talon/)   

### 5.2 Github Repositories
PS2EXE PS1 Compiler: [PS2EXE - MScholtes](https://github.com/MScholtes/PS2EXE)   
Chris Titus WinUtil (Inspiration): [ChrisTitus - WinUtil](https://github.com/ChrisTitusTech/winutil)   
RavenDevTeam Talon (Inspiration): [RavenDevTeam - Talon](https://github.com/ravendevteam/talon)   

### 5.3 BAD EXAMPLES OF SOFTWARE
> Note: that the software listed below is either suspicious or malware, the design and idea behind the project was an original inspiration to making a secure optimizer. These are bad examples of performance or security optimizers and should not be installed or followed for creating secure optimizing software.

Azurite Optimizer (WARNING: MALWARE) (Although it is malware it was an original inspiration for this project due to the idea/design)  
**Due to Azurite being malware or suspicious activity, I will not be including the download link.**  
8 PC Optimizers that are wrapped as malware. [Beware of these 8 PC tune-up tools](https://www.fortect.com/malware-damage/pc-tuneup-software-malware/?srsltid=AfmBOopUsrZr6Lp9m9m6dvqGR7q1RNxFhEN8nOjlVGoIciYyk3rwpeQG)

> Note: Talon by the RavenDevTeam was considered malware by AVs and other cybersecurity professionals. However, after digging and carving out the file it became clear that the reason Talon is flagged as malware by AVs is due to the wrapper used to wrap the Python code as an executable. Talon uses Nuitka which wraps the Python code and makes it difficult for AVs and other professionals to read and understand what the program does. However, RavenDevTeam has all of the code in the GitHub repository to view and go through to understand exactly what the program does. 
ANYRUN [ANYRUN Malware Analysis](https://any.run/report/c41c420a472489de4f13c849b3baeb169f6fa0924a2abbb7a4bce57eb08ae9fa/590776c0-408d-4877-a6fb-1aa00a5fdc22)

**OTHER REFERENCES ADD HERE**  
