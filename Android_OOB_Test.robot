*** Settings ***
Library  zebrauiautomatorlibrary

Resource  ../../../Res/Android/OOB/OOB_Calender_Res.robot
Resource  ../../../Res/Android/OOB/OOB_UIAutomator_Res.robot

Suite Setup  Suite_Setup

*** Variables ***
${TESTSUITE_EXEC_TIMEOUT}  360 
${TESTING_TIMEOUT}  3600


*** Test Cases ***
STTL-44815 [Automated]Verify Opening Calender Application
     [Tags]  Calendar
	 Log  Adding Sleep
     Builtin.Sleep  3600
     Verify opening Calender application

STTL-44934 [Automated]Verify Launching Menu Options Of Calendar Application
    [Tags]  Calendar
    Log  Adding Sleep
    Builtin.Sleep  ${TESTING_TIMEOUT}
	Verify Calendar-Menu Options

STTL-44585 [Automated]Verify Opening Settings Of Calendar Application
    [Tags]  Calendar
	Log  Adding Sleep
    Builtin.Sleep  ${TESTING_TIMEOUT}
    verify Calendar-Settings

STTL-44586 [Automated]Verify Opening Calendar General Settings
    [Tags]  Calendar
	Log  Adding Sleep
    Builtin.Sleep  ${TESTING_TIMEOUT}
    verify calendar-general settings

STTL-44588 [Automated]Verify Opening Calendar Application After Suspend\Resume
    [Tags]  Calendar
	Log  Adding Sleep
    Builtin.Sleep  ${TESTING_TIMEOUT}
    verify Opening Calendar application after suspend\resume

	
*** Keywords ***
Suite_Setup
    [Documentation]  Get the device info
    set serial  ${DUT1}