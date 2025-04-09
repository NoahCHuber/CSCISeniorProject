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
  * 2.6 [Apportioning of Requirements](#26-apportioning-of-requirements)
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
* 5 [References](#5-references)

## Revision History
|  Name(s)  |    Date    |    Reason For Changes   |   Version   |
| --------- | ---------- | ----------------------- | ----------- |
|   Swift   | 2025-08-04 | Intiial Requirments Doc |     1.0     |
|           |            |                         |             |
|           |            |                         |             |

## 1. Introduction
This document defines the system requirements for SwiftEdge Security, a modular, GUI-based Windows utility designed to improve system performance, enhance security, perform cleanup operations, and check for known vulnerabilities. Developed entirely in PowerShell with a Windows Forms front end, this tool provides users with a streamlined interface and powerful functionality—all packaged as a standalone executable.

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

GUI: Graphical User Interface  
SRD: Software Requirements Document  
IT: Information Technology  
API: Application Programming Interface  
CVE: Common Vulnerabilities and Exposures  
NVD: National Vulnerability Database  
Powershell: 	A command-line shell and scripting language designed for system admin tasks in Windows.  
PS2EXE: 	A third-party PowerShell module used to compile .ps1 scripts into standalone Windows executable (.exe) files.  
Windows Forms: A GUI framework in the .NET platform used for building desktop interfaces, accessible through PowerShell.  
Module: A specific functional unit within SwiftEdge Security (e.g., Performance, Security, Cleanup, or Vulnerability Scan).  
Standalone Executable: A self-contained application that does not require the installation of external frameworks to run.  

### 1.4 References
This Software Requirements Document (SRD) does not rely on any previously established vision or scope document. All project-related references, including external tools, APIs, and third-party components, are included in Section 5 – References.

### 1.5 Document Overview
This document is structured to comprehensively define the requirements for the SwiftEdge Security software. It is organized to follow industry-standard software engineering practices to ensure clarity, traceability, and completeness throughout the software development lifecycle. Below are the sections of this document with a brief overview of what each section contains. 

**Section 2 – Product Overview:** Provides general background information, including the system's origin, its major functionalities, external constraints, user characteristics, assumptions, and how requirements are distributed across the software's components.

**Section 3 – Requirements:** Details both the functional and non-functional requirements of the system. This includes software features, quality attributes (such as performance, reliability, and security), and compliance with standards or regulations. External interfaces and design constraints are also described here.

**Section 4 – Verification:** Outlines how the software will be tested and validated against the requirements specified in Section 3. It includes the planned verification methods and criteria for determining successful implementation.
(Due to the size of this project, actual verification of the software will not be filed)

**Section 5 – Appendices:** Contains any supplemental material, such as references, diagrams, mockups, glossaries, and additional documentation that support or extend the main content of the SRD.

## 2. Product Overview
> This section should describe the general factors that affect the product and its requirements. This section does not state specific requirements. Instead, it provides a background for those requirements, which are defined in detail in Section 3, and makes them easier to understand.

### 2.1 Product Perspective
Describe the context and origin of the product being specified in this SRS. For example, state whether this product is a follow-on member of a product family, a replacement for certain existing systems, or a new, self-contained product. If the SRS defines a component of a larger system, relate the requirements of the larger system to the functionality of this software and identify interfaces between the two. A simple diagram that shows the major components of the overall system, subsystem interconnections, and external interfaces can be helpful.

### 2.2 Product Functions
Summarize the major functions the product must perform or must let the user perform. Details will be provided in Section 3, so only a high level summary (such as a bullet list) is needed here. Organize the functions to make them understandable to any reader of the SRS. A picture of the major groups of related requirements and how they relate, such as a top level data flow diagram or object class diagram, is often effective.

### 2.3 Product Constraints
This subsection should provide a general description of any other items that will limit the developer’s options. These may include:  

* Interfaces to users, other applications or hardware.  
* Quality of service constraints.  
* Standards compliance.  
* Constraints around design or implementation.

### 2.4 User Characteristics
Identify the various user classes that you anticipate will use this product. User classes may be differentiated based on frequency of use, subset of product functions used, technical expertise, security or privilege levels, educational level, or experience. Describe the pertinent characteristics of each user class. Certain requirements may pertain only to certain user classes. Distinguish the most important user classes for this product from those who are less important to satisfy.

### 2.5 Assumptions and Dependencies
List any assumed factors (as opposed to known facts) that could affect the requirements stated in the SRS. These could include third-party or commercial components that you plan to use, issues around the development or operating environment, or constraints. The project could be affected if these assumptions are incorrect, are not shared, or change. Also identify any dependencies the project has on external factors, such as software components that you intend to reuse from another project, unless they are already documented elsewhere (for example, in the vision and scope document or the project plan).

### 2.6 Apportioning of Requirements
Apportion the software requirements to software elements. For requirements that will require implementation over multiple software elements, or when allocation to a software element is initially undefined, this should be so stated. A cross reference table by function and software element should be used to summarize the apportioning.

Identify requirements that may be delayed until future versions of the system (e.g., blocks and/or increments).

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
> This section provides the verification approaches and methods planned to qualify the software. The information items for verification are recommended to be given in a parallel manner with the requirement items in Section 3. The purpose of the verification process is to provide objective evidence that a system or system element fulfills its specified requirements and characteristics.

<!-- TODO: give more guidance, similar to section 3 -->
<!-- ieee 15288:2015 -->

## 5. References
Style Guide for SRD: [SRS-Template - Jam01](https://github.com/jam01/SRS-Template/tree/master)   
PS2EXE PS1 Compiler: [PS2EXE - MScholtes](https://github.com/MScholtes/PS2EXE)   
NIST NVD Developer Database: [NIST NVD Database](https://nvd.nist.gov/developers/start-here)   
CVE Program: [CVE Program](https://www.cve.org/)   
Chris Titus WinUtil (Inspiration): [ChrisTitus - WinUtil](https://christitus.com/windows-tool/)   
RavenDevTeam Talon (Inspiration): [RavenDevTeam - Talon](https://ravendevteam.org/software/talon/)   
Avast Security (GUI Inspiration): [Avast Security](https://www.avast.com/)   
Norton 360 (Software Version Scanning Inspiration): [Norton360](https://us.norton.com/products/norton-360-standard)   
Azurite Optimizer (WARNING: MALWARE) (Although it is malware it was an original inspiration for this project)  
**Due to Azurite being malware or suspicious activity, I will not be including the download link.**  
**OTHER REFERENCES ADD HERE**  
