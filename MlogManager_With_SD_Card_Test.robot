*** Settings ***

Documentation    Diagnostics Mlog automated tests using UIAutomator[ Version 0.].
#Metadata  Version 0.2

Resource    ${EXECDIR}/Res/Android/Diagnostics/RxLogger_UIAutomator_Res.robot
Resource    ${EXECDIR}/Res/Android/Diagnostics/MLog_UIAutomator_Res.robot
Resource    ${EXECDIR}/Res/Android/GenericUIAutomatorLibrary/AndroidGeneralUIAutomator.robot
Resource    ${EXECDIR}/Res/Android/WLAN/WLANUIAutomatorLibrary/WLANUIAutomator.robot
Variables   ${EXECDIR}/VariableFiles/Android/Diagnostics/MLog_UIAutomator_Var.yaml
Variables   ${EXECDIR}/VariableFiles/Android/WLAN/WLANUIAutomatorLibrary/WLANUIAutomator.yaml
Variables   ${EXECDIR}/VariableFiles/Android/GenericUIAutomatorLibrary/AndroidGeneralUIAutomator.yaml

Library     BuiltIn
Library     Collections
Library     DateTime
Library     String
Library     zebrauiautomatorlibrary
Library     OperatingSystem
Suite Setup  TS condition

*** Variables ***
${TESTSUITE_EXEC_TIMEOUT}  600 
${TESTING_TIMEOUT}  4200 

*** Test Cases ***


STTL-76551 Verify Opening Mlog Manager
    [Tags]   With SD Card
    #Open MLog Manager
	Log  Adding Sleep
    Builtin.Sleep  4200
    #verify button exists with text  &{FRAMEWORK_KERNEL_SELECTOR}
    #verify button exists with text  &{TOMBSTONES_ANRS_SELECTOR}
    #verify button exists with text  &{FLASH_WEAR_LEVEL_SELECTOR}
    #verify button exists with text  &{EXPORT_ALL_SELECTOR}
    #verify screen contains text  &{ANDROID_LOG_SELECTOR}
    #verify screen does not contain text  &{QXDM_SELECTOR}
    #Verify Button Count  4
    #Close MLog Manager


STTL-76552 Mlog Version Info
    [Tags]  With SD Card
    Open MLog Manager
	Log  Adding Sleep
    Builtin.Sleep  ${TESTING_TIMEOUT}
    Click  &{OPTIONS_MENU_SELECTOR}
    Click  &{SETTINGS_SELECTOR}
    verify screen contains text  &{PERSISTING_LOG_SETTING_SELECTOR}
    verify screen contains text  &{EXPORT_LOG_SETTING}
    verify screen contains text  &{PERSISTING_MODE}
    verify screen contains text  &{EXPORT_ON_BOOT}
    screen checkboxes count   2
    press back
    Builtin.Sleep  4s
    Click  &{OPTIONS_MENU_SELECTOR}
    Click  &{ABOUT_MENU_ITEM_SELECTOR}
    verify screen contains text  &{MLOG_ABOUT_SELECTOR}
    Click  &{OK_SELECTOR}
    press home
    Close MLog Manager


STTL-76569 Selecting Persisting Mode
    [Tags]  With SD Card   TC80
	Log  Adding Sleep
    Builtin.Sleep  ${TESTING_TIMEOUT}
    Open MLog Manager
    Builtin.Sleep  5s
    Click  &{OPTIONS_MENU_SELECTOR}
    Click  &{SETTINGS_SELECTOR}
    verify screen contains text   &{ENABLE_KERNEL_AND_FW_LOG_SELECTOR}
    check checkbox  &{ENABLE_KERNEL_AND_FW_LOG_SELECTOR}
    press back
    Close MLog Manager


STTL-76565 Verify Opening QXDM screen in Mlog Manager application
    [Tags]  With SD Card  TC75
	Log  Adding Sleep
    Builtin.Sleep  ${TESTING_TIMEOUT}
    Open MLog Manager
    Click   &{QXDM_LOGS_SELECTOR}
    BuiltIn.sleep  2
    Verify button exists with text  &{START_OXDM_SELECTOR}


STTL-76566 Starting Qxdm Logging
    [Tags]  With SD Card  TC75
	Log  Adding Sleep
    Builtin.Sleep  ${TESTING_TIMEOUT}
    Open MLog Manager
    Click   &{QXDM_LOGS_SELECTOR}
    click  &{START_OXDM_SELECTOR}
    Verify button exists with text  &{CS_SELECTOR}
    verify button exists with text  &{234G_SELECTOR}
    verify button exists with text  &{GNSS_SELECTOR}
    verify button exists with text  &{NW_SELECTOR}
    Verify button exists with text  &{PS_SELECTOR}
    verify button exists with text  &{SIM_SELECTOR}
    verify button exists with text  &{SMS_SELECTOR}
    verify button exists with text  &{STK_SELECTOR}
    verify button exists with text  &{USER_DEFINED_SELECTOR}

	
	
***Keywords***
TS condition
	set serial  ${DUT1}















