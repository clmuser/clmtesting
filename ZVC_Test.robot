*** Settings ***
Library  zebrauiautomatorlibrary
Library  BuiltIn
Library  OperatingSystem
Library  String

Library  ../../../Lib/Android/ZVC/Executioncommands.py

Variables  ../../../VariableFiles/Android/ZVC/VolSliderCoordinates.yaml

Suite Setup  Suite_Setup
Suite Teardown  Suite_Teardown


*** Test Cases ***
STTL-102589 Toggle_Volume_profile_panel
        set images directory  ${ImageDir}
        open settings  Sound
        ${VolumePage}  Get Object  text=Volumes  className=android.widget.TextView
        click on object  ${VolumePage}
        wait for exists  text=factoryPreset  className=android.widget.Button

        :FOR  ${index}  IN RANGE  4
            \  drag by coordinates  ${ScrollToScreenEnd.${DUT_NAME}[0]}  ${ScrollToScreenEnd.${DUT_NAME}[1]}  ${ScrollToScreenEnd.${DUT_NAME}[2]}  ${ScrollToScreenEnd.${DUT_NAME}[3]}
            \  BuiltIn.sleep  3

        :FOR  ${index}  IN RANGE  4
                \  run keyword if  '${DUT_NAME}' == 'MC40'  run keywords
                ...  log  Tapping on icons from right to left for ${index} time  AND
                ...  click on image  Speaker.png  AND
                ...  locate image  SpeakerSelected.png  AND
                ...  click on image  VibrateIcon.png  AND
                ...  locate image  VibrateSelected.png  AND
                ...  click on image  SilentIcon.png  AND
                ...  locate image  SilentSelected.png
                \  run keyword if  '${DUT_NAME}' == 'MC67'  run keywords
                ...  log  Tapping on icons from right to left for ${index} time  AND
                ...  click on image  Speaker.png  AND
                ...  locate image  SpeakerSelected.png  AND
                ...  click on image  VibrateIcon.png  AND
                ...  locate image  VibrateSelected.png  AND
                ...  click on image  SilentIcon.png  AND
                ...  locate image  SilentSelected.png
                \  run keyword if  '${DUT_NAME}' == 'MC18'  run keywords
                ...  log  Tapping on icons from right to left for ${index} time  AND
                ...  click on image  Speaker.png  AND
                ...  locate image  SpeakerSelected.png  AND
	            ...  click on image  SilentIcon.png  AND
                ...  locate image  SilentSelected.png
                \  run keyword if  '${DUT_NAME}' == 'MC92'  run keywords
                ...  log  Tapping on icons from right to left for ${index} time  AND
                ...  click on image  Speaker.png  AND
                ...  locate image  SpeakerSelected.png  AND
	            ...  click on image  SilentIcon.png  AND
                ...  locate image  SilentSelected.png

        Click  text=OK  className=android.widget.Button
		
STTL-22893 Profiles
        set images directory  ${ImageDir}

        # Pushing multiple Profiles
        # Installing MXMF App
        execute adb command  -s ${DUT1} install ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\AudioVolMgr\\MXMFtestapp.apk
        BuiltIn.sleep  5
        # CommonPofile
        execute adb command  -s ${DUT1} push ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\AudioVolMgr\\CommonProfile\\Config.xml /storage/sdcard0/
        BuiltIn.sleep  5
        launch app  MXMF
        BuiltIn.sleep  3
        click  text=/sdcard0  className=android.widget.RadioButton
        click  text=SEND XML VIA BIND SERVICE  className=android.widget.TextView
        wait for exists  text=MXMF Response  className=android.widget.TextView
        wait for exists  text=Ok  className=android.widget.Button
        click  text=Ok  className=android.widget.Button
        BuiltIn.sleep  3

        # AlarmProfile
        execute adb command  -s ${DUT1} push ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\AudioVolMgr\\AlarmProfile\\Config.xml /storage/sdcard0/
        BuiltIn.sleep  5
        launch app  MXMF
        BuiltIn.sleep  3
        click  text=/sdcard0  className=android.widget.RadioButton
        click  text=SEND XML VIA BIND SERVICE  className=android.widget.TextView
        wait for exists  text=MXMF Response  className=android.widget.TextView
        wait for exists  text=Ok  className=android.widget.Button
        click  text=Ok  className=android.widget.Button
        BuiltIn.sleep  3

        # ScanStressProfile
        execute adb command  -s ${DUT1} push ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\AudioVolMgr\\ScanStressProfile\\Config.xml /storage/sdcard0/
        BuiltIn.sleep  5
        launch app  MXMF
        BuiltIn.sleep  3
        click  text=/sdcard0  className=android.widget.RadioButton
        click  text=SEND XML VIA BIND SERVICE  className=android.widget.TextView
        wait for exists  text=MXMF Response  className=android.widget.TextView
        wait for exists  text=Ok  className=android.widget.Button
        click  text=Ok  className=android.widget.Button

        open settings  Sound
		BuiltIn.sleep  3
        ${VolumePage}  Get Object  text=Volumes  className=android.widget.TextView
        click on object  ${VolumePage}
        wait for exists  text=Scanstress  className=android.widget.Button

        # Checking the dropdown
        click  text=Scanstress  className=android.widget.Button
        ${Profile}  get object  text=Select Volume UI Profile  className=android.widget.TextView
        run keyword if  ${Profile}  log  All Profiles Listed-Expected Behaviour
        run keyword unless  ${Profile}  FAIL  Profiles not Listed-Unexpected Behaviour

        #Checking for the profiles
        wait for exists  text=Scanstress  className=android.widget.CheckedTextView
        wait for exists  text=common  className=android.widget.CheckedTextView
        BuiltIn.sleep  3

STTL-22854 Verify_ZVC_with_AudioVolMgr_CSP
        set images directory  ${ImageDir}

        # pushing AudioVolMgr CSP
        execute adb command  -s ${DUT1} push ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\AudioVolMgr\\CommonProfile\\Config.xml /storage/sdcard0/
        BuiltIn.sleep  8

        launch app  MXMF
        BuiltIn.sleep  5
        click  text=/sdcard0  className=android.widget.RadioButton
        click  text=SEND XML VIA BIND SERVICE  className=android.widget.TextView
        wait for exists  text=MXMF Response  className=android.widget.TextView
        wait for exists  text=Ok  className=android.widget.Button
        click  text=Ok  className=android.widget.Button

        open settings  Sound
		BuiltIn.sleep  3
        ${VolumePage}  Get Object  text=Volumes
        click on object  ${VolumePage}
        BuiltIn.sleep  5
        wait for exists  text=common  className=android.widget.CheckedTextView

        BuiltIn.sleep  5
        ${AudioVolMgrCSPStatus}  locate image  ${DUT_Name}_VolAfterAudioVolMangrCSP.png
        run keyword if  ${AudioVolMgrCSPStatus}  log  All VolumeSliders Set
        BuiltIn.sleep  3

        Click  text=OK  className=android.widget.Button

STTL-22884 Disable/Enable_ZVC
        set images directory  ${ImageDir}

        open settings  Apps
        # swipe till ALL widget
        :FOR    ${index}  IN RANGE  3
        \  swipe left  steps=10
        BuiltIn.sleep  3

        # scroll till ZebraVolumeControl
        :FOR    ${index}  IN RANGE  30
        \  run keyword if  '${DUT_NAME}' == 'MC92'  run keywords
        ...  drag by coordinates  442  485  442  175  AND
        ...  BuiltIn.sleep  2
        BuiltIn.sleep  5
        scroll to end vertically  steps=10

        # Disabling ZVC
        click  text=ZebraVolumeControl  className=android.widget.TextView
        click  text=Disable  className=android.widget.Button
        wait for exists  text=OK  className=android.widget.Button
        wait for exists  text=Ok  className=android.widget.Button
        click  text=OK  className=android.widget.Button

        swipe left  steps=10
        ${DisabledStatus}  get object  text=ZebraVolumeControl  className=android.widget.TextView
        run keyword if  ${DisabledStatus}  log  ZVC successfully Disabled
        run keyword unless  ${DisabledStatus}  FAIL  ZVC not Disabled!!

        open settings  Sound
        ${VolumePage}  Get Object  text=Volumes  className=android.widget.TextView
        click on object  ${VolumePage}
        BuiltIn.sleep  3
        ${AndroidVolCtrlStatus}  wait for exists  text=Music, video, games, & other media  className=android.widget.TextView
        #${AndroidVolCtrlStatus}  locate image  ${DUT_NAME}_AVC.png
        run keyword if  ${AndroidVolCtrlStatus}  log  AVC Taken Effect
        run keyword unless  ${AndroidVolCtrlStatus}  FAIL  AVC Not Taken Effect!!

        BuiltIn.sleep  3

	    #Before Inc/Dec of Vol sliders
	    ${BeforeIncreseDecrease}  locate Image  ${DUT_NAME}_AVC.png
	    BuiltIn.sleep  3

        :FOR    ${index}  IN RANGE  1
	        \  #Increase Vol sliders
	        \  click at coordinates  ${VolIncreaseForAVC.${DUT_NAME}[0]}  ${VolIncreaseForAVC.${DUT_NAME}[1]}

	        \  #Decrease Vol sliders
	        \  BuiltIn.sleep  3
	        \  click at coordinates  ${VolDecreaseForAVC.${DUT_NAME}[0]}  ${VolDecreaseForAVC.${DUT_NAME}[1]}

            \  BuiltIn.sleep  3
            \  drag by coordinates  452  367  452  248

        ${VersionCheck}  wait for exists  textContains=v 1  className=android.widget.TextView
        run keyword if  ${VersionCheck}  FAIL  ZVC version displayed
        run keyword unless  ${VersionCheck}  log  ZVC version not displayed

        :FOR  ${index}  IN RANGE  6
            \  drag by coordinates  ${ScrollToScreenEnd.${DUT_NAME}[2]}  ${ScrollToScreenEnd.${DUT_NAME}[3]}  ${ScrollToScreenEnd.${DUT_NAME}[0]}  ${ScrollToScreenEnd.${DUT_NAME}[1]}
            \  BuiltIn.sleep  3

        ${AfterIncreseDecrease}  locate image  ${DUT_NAME}_AVC.png
	    run keyword if  ${AfterIncreseDecrease}  FAIL  Vol levels not adjusted.
	    run keyword unless  ${AfterIncreseDecrease}  log  Vol levels adjusted.

	    Click  text=OK  className=android.widget.Button

        press back

        open settings  Apps

		:FOR    ${index}  IN RANGE  4
        \  swipe left  steps=10
        BuiltIn.sleep  3

        click  text=ZebraVolumeControl  className=android.widget.TextView
        click  text=Enable  className=android.widget.Button

STTL-22891 Factory_Preset
        set images directory  ${ImageDir}

        execute adb command  -s ${DUT1} push ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\AudioVolMgr\\factoryPresetProfile\\Config.xml /storage/sdcard0/
        BuiltIn.sleep  3

        launch app  MXMF
        BuiltIn.sleep  3
        click  text=/sdcard0  className=android.widget.RadioButton
        click  text=SEND XML VIA BIND SERVICE  className=android.widget.TextView
        wait for exists  text=MXMF Response  className=android.widget.TextView
        wait for exists  text=Ok  className=android.widget.Button
        click  text=Ok  className=android.widget.Button

        BuiltIn.sleep  3
        open settings  Sound
        ${VolumePage}  Get Object  text=Volumes  className=android.widget.TextView
        click on object  ${VolumePage}
        wait for exists  text=factoryPreset  className=android.widget.Button

        :FOR    ${index}  IN RANGE  4
	        \  #Increase Vol sliders
	        \  click at coordinates  ${IncreaseVolSliders.${DUT_NAME}[0]}  ${IncreaseVolSliders.${DUT_NAME}[1]}

	        \  #Decrease Vol sliders
	        \  BuiltIn.sleep  3
	        \  click at coordinates  ${DecreaseVolSliders.${DUT_NAME}[0]}  ${DecreaseVolSliders.${DUT_NAME}[1]}

            \  BuiltIn.sleep  3
            \  drag by coordinates  452  367  452  248

        :FOR  ${index}  IN RANGE  4
            \  drag by coordinates  ${ScrollToScreenEnd.${DUT_NAME}[2]}  ${ScrollToScreenEnd.${DUT_NAME}[3]}  ${ScrollToScreenEnd.${DUT_NAME}[0]}  ${ScrollToScreenEnd.${DUT_NAME}[1]}
            \  BuiltIn.sleep  3


        Click  text=OK  className=android.widget.Button

        launch app  MXMF
        BuiltIn.sleep  3
        click  text=/sdcard0  className=android.widget.RadioButton
        click  text=SEND XML VIA BIND SERVICE  className=android.widget.TextView
        wait for exists  text=MXMF Response  className=android.widget.TextView
        wait for exists  text=Ok  className=android.widget.Button
        click  text=Ok  className=android.widget.Button

        open settings  Sound
        ${VolumePage}  Get Object  text=Volumes  className=android.widget.TextView
        click on object  ${VolumePage}
        wait for exists  text=factoryPreset  className=android.widget.Button
        ${factoryValuesStatus}  locate image  ${DUT_NAME}_FactoryPreset_BeforeIncDec.png
        run keyword if   ${factoryValuesStatus}  log  Volume levels set back to the factory Preset Levels
        run keyword unless  ${factoryValuesStatus}  FAIL  Volume levels not set back to the factory Preset Levels

        Click  text=OK  className=android.widget.Button
		
*** Keywords ***
Suite_Setup
    [Documentation]  Get the device info
    ${command}  set variable  -s ${DUT1} shell getprop ro.product.name
    @{Model}  execute adb command  ${command}
    ${status}=  getConncetedDevice  @{Model}[0]
    Set Global Variable     ${DUT_NAME}         ${status}
	Set Global Variable  ${DUT1}  ${DUT1}
    set serial  ${DUT1}
	${ImageDir}  set variable  ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\Images
	Set Global Variable   ${ImageDir}
    AddDeviceIdToBatchFile  ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\HardKeys\\${DUT_Name}\\Volume_UpPress.bat  ${DUT1}
    AddDeviceIdToBatchFile  ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\HardKeys\\${DUT_Name}\\Volume_UpRelease.bat  ${DUT1}
    AddDeviceIdToBatchFile  ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\HardKeys\\${DUT_Name}\\Volume_DownRelease.bat  ${DUT1}
    AddDeviceIdToBatchFile  ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\HardKeys\\${DUT_Name}\\Volume_DownPress.bat  ${DUT1}
	
Suite_Teardown
	RemoveDeviceIdsFromBatchFile  ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\HardKeys\\${DUT_Name}\\Volume_UpPress.bat  ${DUT1}
	RemoveDeviceIdsFromBatchFile  ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\HardKeys\\${DUT_Name}\\Volume_UpRelease.bat  ${DUT1}
    RemoveDeviceIdsFromBatchFile  ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\HardKeys\\${DUT_Name}\\Volume_DownPress.bat  ${DUT1}
    RemoveDeviceIdsFromBatchFile  ${OUTPUTDIR}\\ExternalFiles\\Android\\ZVC\\HardKeys\\${DUT_Name}\\Volume_DownRelease.bat  ${DUT1}