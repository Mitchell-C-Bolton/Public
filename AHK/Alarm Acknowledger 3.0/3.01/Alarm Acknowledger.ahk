/* Information
Version: 3.01

Name: Mitchell Bolton
Date: 04/27/2022
Changes:
- Impliment Trevor Burch's section of script
*/
ScriptVersion = 3.01

SetBatchLines, -1

;---------------------------------------------------------------------------------------- Don't Break My Script

Hotkey, ^Down, Off

;---------------------------------------------------------------------------------------- Loading Splash

Thing =◟

Gui, AA: +AlwaysOnTop +Disabled -SysMenu +Owner -Border
Gui, AA: Font, bold
Gui, AA: Add, Text, x30 y18, LOADING
Gui, AA: Add, Text, VLoadingThing x55 y30, % Thing
Gui, AA: Show, H54 W120,

SetTimer, UpdateThing, 75

;---------------------------------------------------------------------------------------- Presets

SetKeyDelay, 50
FormatTime, Date,, MM/dd/yyyy
FormatTime, Time,, HHmm
SetNumLockState, AlwaysOn
#SingleInstance force
DetectHiddenWindows, On

;---------------------------------------------------------------------------------------- Version Check

FileRead, CurrentVersion,% "\\ant\DEPT\ACS-back-up\Second-Shift\Bolton(DO-NOT-DELETE)\AAVersion.txt"

if (ScriptVersion = CurrentVersion or ScriptVersion > CurrentVersion) {
	Goto VersionGood
}
else
{

Run, https://share.amazon.com/sites/ACS-BAC/Applications/Forms/AllItems.aspx
MsgBox, 16, Error,There was an issue while initializing Alarm Acknowledger.`n`nPlease confirm you are connected to VPN and are using the most recent version of Alarm Acknowleger.
ExitApp
}

;---------------------------------------------------------------------------------------- Loader

VersionGood:
FileCreateDir, %A_Appdata%\AlarmAcknowledger
FileRemoveDir, %A_Appdata%\AlarmAcknowledger, 1
FileCreateDir, %A_Appdata%\AlarmAcknowledger
SetWorkingDir, %A_Appdata%\AlarmAcknowledger
FileInstall, Resources.zip,% A_WorkingDir . "\Resources.zip", 1
FileCopy, Resources.zip,% A_WorkingDir . "\Resources.zip", 1 ; moves resources for non compiled script. This should not be included in the compiled version if directives are working properly.

SmartZip(s, o, t = 4)
{
	IfNotExist, %s%
		return, -1        ; The souce is not exist. There may be misspelling.

	oShell := ComObjCreate("Shell.Application")

	if (SubStr(o, -3) = ".zip")	; Zip
	{
		IfNotExist, %o%        ; Create the object ZIP file if it's not exist.
			CreateZip(o)

		Loop, %o%, 1
			sObjectLongName := A_LoopFileLongPath

		oObject := oShell.NameSpace(sObjectLongName)

		Loop, %s%, 1
		{
			if (sObjectLongName = A_LoopFileLongPath)
			{
				continue
			}
			ToolTip, Zipping %A_LoopFileName% ..
			oObject.CopyHere(A_LoopFileLongPath, t)
			SplitPath, A_LoopFileLongPath, OutFileName
			Loop
			{
				oObject := "", oObject := oShell.NameSpace(sObjectLongName)	; This doesn't affect the copyhere above.
				if oObject.ParseName(OutFileName)
					break
			}
		}
		ToolTip
	}
	else if InStr(FileExist(o), "D") or (!FileExist(o) and (SubStr(s, -3) = ".zip"))	; Unzip
	{
		if !o
			o := A_WorkingDir        ; Use the working dir instead if the object is null.
		else IfNotExist, %o%
			FileCreateDir, %o%

		Loop, %o%, 1
			sObjectLongName := A_LoopFileLongPath

		oObject := oShell.NameSpace(sObjectLongName)

		Loop, %s%, 1
		{
			oSource := oShell.NameSpace(A_LoopFileLongPath)
			oObject.CopyHere(oSource.Items, t)
		}
	}
}

CreateZip(n)
{
	ZIPHeader1 := "PK" . Chr(5) . Chr(6)
	VarSetCapacity(ZIPHeader2, 18, 0)
	ZIPFile := FileOpen(n, "w")
	ZIPFile.Write(ZIPHeader1)
	ZIPFile.RawWrite(ZIPHeader2, 18)
	ZIPFile.close()
}

SmartZip("Resources.zip", "")

FileDelete,  %A_WorkingDir%\Resources.zip

;---------------------------------------------------------------------------------------- Hide Resources

FileSetAttrib, +RH, %A_WorkingDir%
FileSetAttrib, +RH, %A_WorkingDir%\*.*
FileSetAttrib, +RH, %A_WorkingDir%\Resources
FileSetAttrib, +RH, %A_WorkingDir%\Resources\*.*
SetWorkingDir, %A_Appdata%\AlarmAcknowledger\Resources

;---------------------------------------------------------------------------------------- AA Background Generator

Random, PictureNumber , 1, 20

If (PictureNumber = 1)
{
BackgroundImmage = AAcknowledgerGUI1.png
}
Else If (PictureNumber = 2)
{
BackgroundImmage = AAcknowledgerGUI2.png
}
Else If (PictureNumber = 3)
{
BackgroundImmage = AAcknowledgerGUI3.png
}
Else If (PictureNumber = 4)
{
BackgroundImmage = AAcknowledgerGUI4.png
}
Else If (PictureNumber = 5)
{
BackgroundImmage = AAcknowledgerGUI5.png
}
Else If (PictureNumber = 6)
{
BackgroundImmage = AAcknowledgerGUI6.png
}
Else If (PictureNumber = 7)
{
BackgroundImmage = AAcknowledgerGUI7.png
}
Else If (PictureNumber = 8)
{
BackgroundImmage = AAcknowledgerGUI8.png
}
Else If (PictureNumber = 9)
{
BackgroundImmage = AAcknowledgerGUI9.png
}
Else If (PictureNumber = 10)
{
BackgroundImmage = AAcknowledgerGUI10.png
}
Else If (PictureNumber = 11)
{
BackgroundImmage = AAcknowledgerGUI11.png
}
Else If (PictureNumber = 12)
{
BackgroundImmage = AAcknowledgerGUI12.png
}
Else If (PictureNumber = 13)
{
BackgroundImmage = AAcknowledgerGUI13.png
}
Else If (PictureNumber = 14)
{
BackgroundImmage = AAcknowledgerGUI14.png
}
Else If (PictureNumber = 15)
{
BackgroundImmage = AAcknowledgerGUI15.png
}
Else If (PictureNumber = 16)
{
BackgroundImmage = AAcknowledgerGUI16.png
}
Else If (PictureNumber = 17)
{
BackgroundImmage = AAcknowledgerGUI17.png
}
Else If (PictureNumber = 18)
{
BackgroundImmage = AAcknowledgerGUI18.png
}
Else If (PictureNumber = 19)
{
BackgroundImmage = AAcknowledgerGUI19.png
}
Else If (PictureNumber = 20)
{
BackgroundImmage = AAcknowledgerGUI20.png
}

;BackgroundImmage := "AAcknowledgerGUI" . PictureNumber . ".png" ; shortened the if/else chain to just throw the variable in for make startup quicker.

Goto ScriptMain

;---------------------------------------------------------------------------------------- Main Script

ScriptMain:

Gui, AA: Destroy

;---------------------------------------------------------------------------------------- Making All GUI's Moveable

WM_MOUSEMOVE( wparam, lparam, msg, hwnd )
{
	if wparam = 1 ; LButton
		PostMessage, 0xA1, 2,,, A ; WM_NCLBUTTONDOWN
}

OnMessage( 0x200, "WM_MOUSEMOVE" )

;---------------------------------------------------------------------------------------- Groups
; kept these as they might still be needed for other functions
GroupAdd, Lenel, ahk_class RAIL_WINDOW
GroupAdd, Lenel, ahk_class TscShellContainerClass

GroupAdd, AlarmAcknowledgment, Alarm Acknowledgment (BAC-RDS.CORP.AMAZON.COM)
GroupAdd, AlarmAcknowledgment, Alarm Acknowledgment (GS-TS-BR-NA.CORP.AMAZON.COM)
GroupAdd, AlarmAcknowledgment, Alarm Acknowledgment (gs-app-ue1d022p.ant.amazon.com)
GroupAdd, AlarmAcknowledgment, ahk_class TscShellContainerClass

GroupAdd, FastGroup, Fast/Group Acknowledge (BAC-RDS.CORP.AMAZON.COM)
GroupAdd, FastGroup, Fast/Group Acknowledge (GS-TS-BR-NA.CORP.AMAZON.COM)
GroupAdd, FastGroup, Fast/Group Acknowledge (gs-app-ue1d022p.ant.amazon.com)
GroupAdd, FastGroup, ahk_class TscShellContainerClass

GroupAdd, Acknowledgeselectedalarms, Acknowledge selected alarms (BAC-RDS.CORP.AMAZON.COM)
GroupAdd, Acknowledgeselectedalarms, Acknowledge selected alarms (GS-TS-BR-NA.CORP.AMAZON.COM)
GroupAdd, Acknowledgeselectedalarms, Acknowledge selected alarms (gs-app-ue1d022p.ant.amazon.com)
GroupAdd, Acknowledgeselectedalarms, ahk_class TscShellContainerClass

;---------------------------------------------------------------------------------------- Initial GUI Cordinates

acknowledgeX = 816
acknowledgeY = 437

acstkX = 816
acstkY = 437

;---------------------------------------------------------------------------------------- OK break the script

Hotkey, ^Down, On

;---------------------------------------------------------------------------------------- Toolkit Global Variables

MDFPlaceholder =
(
For verification purposes, please have security go to the MDF room, badge on the reader and enter the PIN 1111.

Can you please advise the cause for the alarm and if it is due to planned work, do you have a trouble ticket for the work?
)

IDFPlaceholder =
(
For verification purposes, please have security go to the IDF alarm point and badge on the reader.

Can you please advise the cause for the alarm and if it is due to planned work, do you have a trouble ticket for the work?
)

DoorForcedOpenTroubleshooting =
(
1. Is there a Lenel outage or impairment?

2. Does the alarm activate after a valid badge scan on entry or exit?

3. Is any part of the door or turnstile hardware preventing the door from securing appropriately?

4. Is there a facility issue preventing the door from operating normally?

5. Does the locking mechanism take more or less than 5 seconds to re-engage after badge scan?

6. Is a masking or unlock schedule currently or recently in place?

7. Are badge scans showing up on the device?

8. Did an individual utilize a hard key in order to open a door with a malfunctioning (or functioning) badge reader?

9. Did the individual accessing the space have the appropriate permissions?

10. Are there any signs of forced entry?

11. Is the alarm generated due to testing?

12. Does an alarm activate when the door handle is moved, but the door itself is not opened?
)

DoorHeldOpenTroubleshooting =
(
1. Is any part of the door or turnstile hardware preventing the door from securing appropriately?

2. Is there a facility issue preventing the door from operating normally such as HVAC pressure difference or an automatic closer issue?

3. Is a masking or unlock schedule currently or recently in place?

4. Is the alarm generated due to testing?
)

EmergencyDoorReleaseTroubleshooting =
(
1. Is any part of the door hardware preventing the door from securing appropriately?

2. Is there a facility issue preventing the door from operating normally such as HVAC pressure difference or an automatic closer issue?

3. Does the locking mechanism take more or less than 5 seconds to re-engage after the EDR is activated?

4. Does an alarm activate when the door is budged or handle is moved, but the door itself is not opened?
)

EmergencyExitTroubleshooting =
(
1. Is any part of the door hardware preventing the door from securing appropriately?

2. Is there a facility issue preventing the door from operating normally such as HVAC pressure difference or an automatic closer issue?

3. Does an alarm activate when the door is budged or handle is moved, but the door itself is not opened?
)

AntiPassbackTroubleshooting =
(
1. Is there a Lenel outage or impairment?

2. Did an individual recently exit a space without scanning their badge on exit?
)

PowerFailTroubleshooting =
(
1. Is planned work being completed on a panel or device?

2. Is the associated badge reader for the alarm point functioning?

3. Is ad-hoc work being done in response to a device or system malfunction?
)

TGorPBorBorPB =
(
1. Does the alarm activate when only one person enters or exits?

2. Does the alarm activate when no one is entering or exiting?

3. Does the alarm activate after a valid badge scan on entry or exit?

4. Does an alarm activate when standing in the turnstile lane and making no attempt to enter or exit?
)

ClimbOrCrawlOverTroubleshooting =
(
1. Does the alarm activate when only one person enters or exits?

2. Is the alarm activating when weight is placed on the turnstile?

3. Does the alarm activate after a valid badge scan on entry or exit?

4. Does an alarm activate when standing in the turnstile lane and making no attempt to enter or exit?
)

MotionDetectorTroubleshooting =
(
1. Does an alarm activate when outside of the room?

2. Is the MDF caged within another room?

3. Does the room contain an additional cooling unit that can be moved by the FM?

4. Are there any loose items in the room such as stacks of paper, boxes, etc?

5. Did multiple people badge into the room?
)

CabinetTamperTroubleshooting =
(
1. Is planned work being completed on a panel?

2. Is ad-hoc work being done in response to a device or system malfunction?

3. Is the associated badge reader for the alarm point functioning?
)

DCInUseTroubleshooting =
(
1. Is "DC In Use" generated as an alarm?
)

ReaderAuxiliaryInputTroubleshooting =
(
1. Is "Reader Auxiliary Input" the alarm's Input/Output?
)

RunawayDeviceTroubleshooting =
(
1. Is the Alarm Description "Runaway Device?"
)

;---------------------------------------------------------------------------------------- Toolkit GUI

Gui, Toolkit: Color, 232F3E

Gui, Toolkit: -Resize +alwaysontop -SysMenu +ToolWindow -Caption -Border

Gui, Toolkit: Add, Picture, x0 y0 +BackgroundTrans gTab1 vTab1, A_WorkingDir\Tab1.png
Gui, Toolkit: Add, Picture, x100 y0 +BackgroundTrans gTab2 vTab2, %A_WorkingDir%\Tab2.png
Gui, Toolkit: Add, Picture, x150 y0 +BackgroundTrans gTab3 vTab3, %A_WorkingDir%\Tab3.png
Gui, Toolkit: Add, Picture, x50 y0 +BackgroundTrans gTab4 vTab4, %A_WorkingDir%\Tab4.png

Gui, Toolkit: Add, Picture, x0 y0 +BackgroundTrans vTab1Clicked, %A_WorkingDir%\Tab1Clicked.png
Gui, Toolkit: Add, Picture, x100 y0 +BackgroundTrans +Hidden vTab2Clicked, %A_WorkingDir%\Tab2Clicked.png
Gui, Toolkit: Add, Picture, x150 y0 +BackgroundTrans +Hidden vTab3Clicked, %A_WorkingDir%\Tab3Clicked.png
Gui, Toolkit: Add, Picture, x50 y0 +BackgroundTrans +Hidden vTab4Clicked, %A_WorkingDir%\Tab4Clicked.png

Gui, Toolkit: Add, Picture, x200 y38 +BackgroundTrans +Hidden vExtendoBar, %A_WorkingDir%\ExtendoBar.png

Gui, Toolkit: Add, Picture, x200 y0 +BackgroundTrans vExit gExit, %A_WorkingDir%\Exit.png

Gui, Toolkit: Font, s14 cFFFFFF, Arial Bold
Gui, Toolkit: Add, Text, x10 y50 +BackgroundTrans vQuestionsText, SOP Questions
Gui, Toolkit: Font, s9, Arial
Gui, Toolkit: Add, DDL, x10 y80 w230 h235 Choose1 gRegion vRegion, Select your region...|ACS BAC|ACS India|ACS LATAM
Gui, Toolkit: Add, DDL, x10 y110 w230 h235 +Disabled gQuestionsDDL vQuestionsDDL,
Gui, Toolkit: Font, s10 cFFFFFF, Arial
Gui, Toolkit: Add, Edit, x10 y140 w230 h140 +ReadOnly +BackgroundTrans vQuestions,
Gui, Toolkit: Font, s10 c000000, Arial
Gui, Toolkit: Add, Button, x10 y287 w100 +Disabled vPowerDMS gPowerDMS, PowerDMS
Gui, Toolkit: Add, Button, x115 y287 w125 +Disabled vCopyQuestions gCopyQuestions, Copy to Clipboard

Gui, Toolkit: Font, s14 cFFFFFF, Arial Bold
Gui, Toolkit: Add, Text, x10 y50 +BackgroundTrans +Hidden vARCIText, Alarm Root Cause Identifier

Gui, Toolkit: Font, s12 cDBDBDB, Arial Bold
Gui, Toolkit: Add, Text, x10 y85 +BackgroundTrans +Hidden vARCILocationText, Alarm Location
Gui, Toolkit: Add, Text, x10 y150 +BackgroundTrans +Hidden vARCIAlarmDescriptionText, Alarm Description
Gui, Toolkit: Add, Text, x180 y85 +BackgroundTrans +Hidden vARCITroubleshootingText, Troubleshooting Questions
Gui, Toolkit: Add, Text, x10 y260 +BackgroundTrans +Hidden vARCIIdentifiedIssueText, Identified Issue

Gui, Toolkit: Font, s18 c94ed88, Arial Bold
Gui, Toolkit: Add, Text, x10 y317 w500  +BackgroundTrans +Hidden +Center vARCIRootCause,

Gui, Toolkit: Font, s12 cACACAC, Arial Bold
Gui, Toolkit: Add, Text, x10 y352 w500 h100 +BackgroundTrans +Hidden +Center vARCIDefinition,

Gui, Toolkit: Font, s10 cFFFFFF, Arial
Gui, Toolkit: Add, Edit, x180 y110 w330 h130 +BackgroundTrans +Hidden +Disabled +ReadOnly vARCITroubleshooting,

Gui, Toolkit: Font, s10, Arial
Gui, Toolkit: Add, DDL, x10 y110 w160 +Hidden Choose1 gARCILocationDDL vARCILocationDDL, Select a Location...|Door|Turnstile|Room|Panel
Gui, Toolkit: Add, DDL, x10 y175 w160 +Hidden +Disabled gARCIAlarmDescriptionDDL vARCIAlarmDescriptionDDL,
Gui, Toolkit: Add, Button, x10 y210 w160 +Hidden +Disabled vARCICopyTroubleshootingQuestions gARCICopyTroubleshootingQuestions, Copy Questions
Gui, Toolkit: Add, Button, x370 y345 w130 +Hidden vARCISimT gARCISimT, Create a SIM-T

Gui, Toolkit: Font, s8.5, Arial
Gui, Toolkit: Add, DDL, x10 y285 w500 r6 +Hidden +Disabled gARCIIdentifiedIssueDDL vARCIIdentifiedIssueDDL,

Gui, Toolkit: Font, s16 cWhite, Arial Bold
Gui, Toolkit: Add, Text, x10 y50 +Hidden vWC1, AMER
Gui, Toolkit: Add, Text, x10 y170 +Hidden vWC2, World

Gui, Toolkit: Font, s10 cbd7100, Arial Bold

Gui, Toolkit: Add, Text, x197 y55 +Hidden vMonthDayText, MM/DD

Gui, Toolkit: Font, s12 ca8dfee, Arial Bold

Gui, Toolkit: Add, Text, x10 y135 +Hidden vWC3, Eastern
Gui, Toolkit: Add, Text, x112 y135 w180 +Hidden vTimeString, %TimeString%

Gui, Toolkit: Font, s12 ccccccc, Arial Bold

Gui, Toolkit: Add, Text, x10 y115 +Hidden vWC4, Central
Gui, Toolkit: Add, Text, x112 y115 w180 +Hidden vACSCST, %ACSCST%

Gui, Toolkit: Add, Text, x10 y95 +Hidden vWC5, Mountain
Gui, Toolkit: Add, Text, x112 y95 w180 +Hidden vACSMST, %ACSMST%

Gui, Toolkit: Font, s12 ca8dfee, Arial Bold

Gui, Toolkit: Add, Text, x10 y75 +Hidden vWC6, Pacific
Gui, Toolkit: Add, Text, x112 y75 w180 +Hidden vACSPST, %ACSPST%

Gui, Toolkit: Font, s12 ccccccc, Arial Bold

Gui, Toolkit: Add, Text, x10 y195 +Hidden vWC8, London
Gui, Toolkit: Add, Text, x112 y195 w180 +Hidden vlndt, %lndt%

Gui, Toolkit: Add, Text, x10 y215 +Hidden vWC10, Berlin
Gui, Toolkit: Add, Text, x112 y215 w180 +Hidden vbert, %bert%

Gui, Toolkit: Add, Text, x10 y235 +Hidden vWC7, India
Gui, Toolkit: Add, Text, x112 y235 w180 +Hidden vindt, %indt%

Gui, Toolkit: Add, Text, x10 y255 +Hidden vWC11, Beijing
Gui, Toolkit: Add, Text, x112 y255 w180 +Hidden vbejt, %bejt%

Gui, Toolkit: Add, Text, x10 y275 +Hidden vWC12, Tokyo
Gui, Toolkit: Add, Text, x112 y275 w180 +Hidden vtokt, %tokt%

Gui, Toolkit: Add, Text, x10 y295 +Hidden vWC9, Sydney
Gui, Toolkit: Add, Text, x112 y295 w180 +Hidden vsydt, %sydt%

settimer, ACSTime, 500

Gui, Toolkit: Font, s14 cFFFFFF, Arial Bold
Gui, Toolkit: Add, Text, x10 y50 +BackgroundTrans +Hidden vDispatchText, Dispatch Messages
Gui, Toolkit: Font, s10, Arial
Gui, Toolkit: Add, DDL, x10 y80 w230 h235 Choose1 +Hidden gDispatchMessage vDispatchMessage, MDF|IDF
Gui, Toolkit: Font, s10 cFFFFFF, Arial
Gui, Toolkit: Add, Edit, x10 y110 w230 h170 +ReadOnly +BackgroundTrans +Hidden vDispatchEditBox,
Gui, Toolkit: Font, s10 c000000, Arial
Gui, Toolkit: Add, Button, x10 y287 w230 +Hidden vCopyDispatchMessage gCopyDispatchMessage, Copy to Clipboard

;---------------------------------------------------------------------------------------- Hotkeys
#IfWinActive, Remote Desktop
^0::
^Numpad0::
#IfWinActive, Alarm Acknowledgment
^0::
^Numpad0::
#IfWinActive, Alarm Monitoring
^0::
^Numpad0::
WinGet, lenelWinId, ID, A
Gosub, ReloadCauseInformation
return

;---------------------------------------------------------------------------------------- Acknowledge GUI
/*
#IfWinExist Alarm Acknowledger
WinActivate, Alarm Acknowledger
gosub, AAGuiEscape
return
#IfWinExist Quick Clear
WinActivate, Quick Clear
gosub, AAGuiEscape
return
#IfWinExist Update
WinActivate, Update
gosub, AAGuiEscape
return
#IfWinExist InformationSize
WinActivate, InformationSize
gosub, AAGuiEscape
return
#IfWinExist Information
WinActivate, Information
gosub, AAGuiEscape
return
#IfWinExist SLA Information
WinActivate, SLA Information
gosub, AAGuiEscape
return

AAGuiEscape:
WinGetPos, acknowledgeX, acknowledgeY,,,A
goSub, Cancel
return
*/

ReloadCauseInformation:

SLA = 0
VariableClearing = "False"
/*
if WinExist("Alarm Acknowledger") { ;if the windows is already open...
	WinGetPos, acknowledgeX, acknowledgeY,,,Alarm Acknowledger ;get its position
}
*/
Gui, AA: Destroy
Gui, AA: Color, 232F3E,White
Gui, AA: +alwaysontop +ToolWindow -Border -Theme
Gui, AA: Font, w800 s9, Calibri
Gui, AA: Add, Picture, x0 y0 h199 w160,  %A_WorkingDir%\%BackgroundImmage%
Gui, AA: Add, Text,x126 y7 BackgroundTrans, V3.01
Gui, AA: Add, Text,x10 y7 BackgroundTrans, Responder
Gui, AA: Add, DropDownList, W137 vResponder, Alarm Responder||Fixed Post|Security Manager|IT Representative|ACS Operator|Other
Gui, AA: Add, Text, BackgroundTrans, Alarm Cause
Gui, AA: Add, DropDownList, W137 vCause, Select...||Undetermined|Human Error|Human Error by IT|Human Error by Security|Emergency Event|Breach/Forced Entry|Key Override|Unattended Escort|Technical Issue|Device Issue|Programming Issue|Un-Notified Work|Pre-Notified Work|Audit|Testing
Gui, AA: Add, Checkbox, Color  yp+30 w13 h13  vPriority, Priority Alarm
Gui, AA: Add, Text, BackgroundTrans yp x27, Priority Alarm
Gui, AA: Add, Checkbox, Color x10 yp+20 w13 h13 vDay0, Day 0
Gui, AA: Add, Text, BackgroundTrans yp x27, Day 0
Gui, AA: Add, Checkbox, Color x10 yp+20 w13 h13 vSLA, SLA
Gui, AA: Add, Text, BackgroundTrans yp x27, SLA
Gui, AA: Add, Button, -Background x10 yp+20 Default gContinue, Acknowledge
Gui, AA: Add, Button, yp x100 gCancel, Cancel
GuiControl, AA: focus, Cause

Gui, AA: Margin , x0, Y0
Gui, AA: Show, x%acknowledgeX% y%acknowledgeY%, Alarm Acknowledger
;gui, AA:show, % ((acknowledgeX && acknowledgeY) ? "x" acknowledgeX "y" acknowledgeY : ""),Alarm Acknowledger ;use gui location variables if they exist, otherwise use the default location.
WinGetPos, acknowledgeX, acknowledgeY,,, Alarm Acknowledger

return

;---------------------------------------------------------------------------------------- Launch Toolkit
#If ;this hotkey is always available (unless loading)
^Down::
Gui, Toolkit: Show, x%acstkX% y%acstkY% w250 h325, ACS Toolkit

/*
if WinExist("ACS Toolkit") { ;if the windows is already open...
	WinGetPos, acstkX, acstkY,,,ACS Toolkit ;get its position
}
gui, Toolkit:show, % ((acstkX && acstkY) ? "x" acstkX "y" acstkY : "") . w250 h325,ACS Toolkit
*/

ControlClick, Static1, ACS Toolkit
return

/*
#IfWinExist, ACS Toolkit
ToolkitGuiEscape: ; allows the user to press escape to close the gui
WinGetPos, acstkX, acstkY,,, ACS Toolkit
gosub, exit
return
*/

;---------------------------------------------------------------------------------------- Toolkit Tab-Switching Commands

Tab1:
WinGetPos, acstkX, acstkY,,,ACS Toolkit
GuiControl, Toolkit: Move, Exit, x200 y0

GuiControl, Toolkit: Show, Tab1Clicked
GuiControl, Toolkit: Hide, Tab4Clicked
GuiControl, Toolkit: Hide, Tab3Clicked
GuiControl, Toolkit: Hide, Tab2Clicked

GuiControl, Toolkit: Show, QuestionsText
GuiControl, Toolkit: Show, QuestionsDDL
GuiControl, Toolkit: Show, QuestionsCopy
GuiControl, Toolkit: Show, Questions
GuiControl, Toolkit: Show, PowerDMS
GuiControl, Toolkit: Show, CopyQuestions
GuiControl, Toolkit: Show, Region

GoSub, HideTime
GoSub, HideARCI
GoSub, HideDispatchMessages

Gui, Toolkit: Show, x%acstkX% y%acstkY% w250 h325, ACS Toolkit
return

Tab2:
WinGetPos, acstkX, acstkY,,,ACS Toolkit
GuiControl, Toolkit: Move, Exit, x470 y0

GuiControl, Toolkit: Hide, Tab1Clicked
GuiControl, Toolkit: Hide, Tab4Clicked
GuiControl, Toolkit: Hide, Tab3Clicked
GuiControl, Toolkit: Show, Tab2Clicked

GuiControl, Toolkit: Show, ARCIText
GuiControl, Toolkit: Show, ARCILocationDDL
GuiControl, Toolkit: Show, ARCILocationText

GuiControl, Toolkit: Show, ARCIAlarmDescriptionText
GuiControl, Toolkit: Show, ARCIAlarmDescriptionDDL
GuiControl, Toolkit: Show, ARCITroubleshootingText
GuiControl, Toolkit: Show, ARCIIdentifiedIssueText
GuiControl, Toolkit: Show, ARCIRootCause
GuiControl, Toolkit: Show, ARCIDefinition
GuiControl, Toolkit: Show, ARCITroubleshooting
GuiControl, Toolkit: Show, ARCICopyTroubleshootingQuestions
GuiControl, Toolkit: Show, ARCIIdentifiedIssueDDL

GuiControl, Toolkit: Show, ExtendoBar

GoSub, HidePowerDMS
GoSub, HideTime
GoSub, HideDispatchMessages

Gui, Toolkit: Show, x%acstkX% y%acstkY% w520 h420, ACS Toolkit
GoSub, ARCIIdentifiedIssueDDL

return

Tab3:
WinGetPos, acstkX, acstkY,,,ACS Toolkit
GuiControl, Toolkit: Move, Exit, x200 y0

GuiControl, Toolkit: Show, WC1
GuiControl, Toolkit: Show, WC2
GuiControl, Toolkit: Show, WC3
GuiControl, Toolkit: Show, WC4
GuiControl, Toolkit: Show, WC5
GuiControl, Toolkit: Show, WC6
GuiControl, Toolkit: Show, WC7
GuiControl, Toolkit: Show, WC8
GuiControl, Toolkit: Show, WC9
GuiControl, Toolkit: Show, WC10
GuiControl, Toolkit: Show, WC11
GuiControl, Toolkit: Show, WC12
GuiControl, Toolkit: Show, indt
GuiControl, Toolkit: Show, lndt
GuiControl, Toolkit: Show, sydt
GuiControl, Toolkit: Show, bert
GuiControl, Toolkit: Show, bejt
GuiControl, Toolkit: Show, tokt
GuiControl, Toolkit: Show, TimeString
GuiControl, Toolkit: Show, TimeString2
GuiControl, Toolkit: Show, ACSCST
GuiControl, Toolkit: Show, ACSMST
GuiControl, Toolkit: Show, ACSPST

GuiControl, Toolkit: Show, MonthDayText

GuiControl, Toolkit: Show, Tab3Clicked
GuiControl, Toolkit: Hide, Tab4Clicked
GuiControl, Toolkit: Hide, Tab2Clicked
GuiControl, Toolkit: Hide, Tab1Clicked

GoSub, HidePowerDMS
GoSub, HideARCI
GoSub, HideDispatchMessages

Gui, Toolkit: Show, x%acstkX% y%acstkY% w250 h325, ACS Toolkit
return

Tab4:
WinGetPos, acstkX, acstkY,,,ACS Toolkit
GuiControl, Toolkit: Move, Exit, x200 y0

GuiControl, Toolkit: Show, DispatchText
GuiControl, Toolkit: Show, DispatchMessage
GuiControl, Toolkit: Show, CopyDispatchMessage
GuiControl, Toolkit: Show, EditDispatchMessage
GuiControl, Toolkit: Show, DispatchEditBox
GuiControl, Toolkit: Show, WhiteBox

GuiControl, Toolkit: Show, Tab4Clicked
GuiControl, Toolkit: Hide, Tab3Clicked
GuiControl, Toolkit: Hide, Tab2Clicked
GuiControl, Toolkit: Hide, Tab1Clicked

GoSub, HidePowerDMS
GoSub, HideTime
GoSub, HideARCI

GoSub, DispatchMessage

Gui, Toolkit: Show, x%acstkX% y%acstkY% w250 h325, ACS Toolkit
return

;---------------------------------------------------------------------------------------- Toolkit Tab-Switching Subroutines

HideTime:
GuiControl, Toolkit: Hide, WC1
GuiControl, Toolkit: Hide, WC2
GuiControl, Toolkit: Hide, WC3
GuiControl, Toolkit: Hide, WC4
GuiControl, Toolkit: Hide, WC5
GuiControl, Toolkit: Hide, WC6
GuiControl, Toolkit: Hide, WC7
GuiControl, Toolkit: Hide, WC8
GuiControl, Toolkit: Hide, WC9
GuiControl, Toolkit: Hide, WC10
GuiControl, Toolkit: Hide, WC11
GuiControl, Toolkit: Hide, WC12
GuiControl, Toolkit: Hide, indt
GuiControl, Toolkit: Hide, lndt
GuiControl, Toolkit: Hide, sydt
GuiControl, Toolkit: Hide, bert
GuiControl, Toolkit: Hide, bejt
GuiControl, Toolkit: Hide, tokt
GuiControl, Toolkit: Hide, TimeString
GuiControl, Toolkit: Hide, ACSCST
GuiControl, Toolkit: Hide, ACSMST
GuiControl, Toolkit: Hide, ACSPST
GuiControl, Toolkit: Hide, MonthDayText
return

HideARCI:
GuiControl, Toolkit: Hide, ARCIText
GuiControl, Toolkit: Hide, ARCILocationDDL
GuiControl, Toolkit: Hide, ARCILocationText
GuiControl, Toolkit: Hide, ARCIAlarmDescriptionText
GuiControl, Toolkit: Hide, ARCIAlarmDescriptionDDL
GuiControl, Toolkit: Hide, ARCITroubleshootingText
GuiControl, Toolkit: Hide, ARCIIdentifiedIssueText
GuiControl, Toolkit: Hide, ARCIRootCauseText
GuiControl, Toolkit: Hide, ARCIDefinitionText
GuiControl, Toolkit: Hide, ARCIRootCause
GuiControl, Toolkit: Hide, ARCIDefinition
GuiControl, Toolkit: Hide, ARCITroubleshooting
GuiControl, Toolkit: Hide, ARCICopyTroubleshootingQuestions
GuiControl, Toolkit: Hide, ARCIIdentifiedIssueDDL
GuiControl, Toolkit: Hide, ARCISimT
return

HidePowerDMS:
GuiControl, Toolkit: Hide, QuestionsText
GuiControl, Toolkit: Hide, QuestionsDDL
GuiControl, Toolkit: Hide, QuestionsCopy
GuiControl, Toolkit: Hide, Questions
GuiControl, Toolkit: Hide, PowerDMS
GuiControl, Toolkit: Hide, CopyQuestions
GuiControl, Toolkit: Hide, Region
return

HideDispatchMessages:
GuiControl, Toolkit: Hide, DispatchText
GuiControl, Toolkit: Hide, DispatchMessage
GuiControl, Toolkit: Hide, CopyDispatchMessage
GuiControl, Toolkit: Hide, EditDispatchMessage
GuiControl, Toolkit: Hide, DispatchEditBox
return

;---------------------------------------------------------------------------------------- Toolkit Dispatch Message Commands

DispatchMessage:
Gui, Toolkit: Submit, NoHide

If (DispatchMessage = "MDF")
{
	GuiControl, Toolkit: Text, DispatchEditBox, %MDFPlaceholder%
}
If (DispatchMessage = "IDF")
{
	GuiControl, Toolkit: Text, DispatchEditBox, %IDFPlaceholder%
}
Gui, Toolkit: Submit, NoHide
return

CopyDispatchMessage:
Clipboard = %DispatchEditBox%
return

;---------------------------------------------------------------------------------------- SOP Calls/Logic (Absolute Chonker)

Region:
Gui, Toolkit: Submit, NoHide

GuiControl, Toolkit: Enable, QuestionsDDL
GuiControl, Toolkit: Enable, PowerDMS
GuiControl, Toolkit: Enable, CopyQuestions
GuiControl, Toolkit: Enable, Questions

Questions1 =

GuiControl, Toolkit: Text, Questions, %Questions1%

If (Region = "ACS BAC")
{
	GuiControl, Toolkit:, QuestionsDDL, |Select an Incident...|911 Call Notification|Armed Aggressor|BOLO Sighting|Bomb Threat|Death or Critical Injury|Elevator Issue or Entrapment|Emergency Responders On Campus|Executive Suite Alarm|Extortion|Facility Support|Fire Response|GPS Alarm Response|Innapropriate Behavior|Intrusion or Forced Entry|Kidnapping & Ransom|Las Vegas Alarm Response|Legal Process|Lock or Unlock Request|Lone Worker Emergency Alert|Lost High Value Asset or Prototype|Medical Incident|Missing Person|Odor Investigation|Panel Offline|Protest or Demonstration|Security Assistance Request (SAR)|SCIF|Server Room Overheating|Suicidal Caller|Suspicious Activity|Suspicious Package or Substance|Theft|Traveler Assistance|Utility Outage|Vehicle Collision|Workplace Security Support|Workplace Violence Response
	GuiControl, Toolkit: Choose, QuestionsDDL, 1
}
If (Region = "ACS India")
{
	GuiControl, Toolkit:, QuestionsDDL, |Select an Incident...|BOLO Sighting|Bomb Threat|Elevator Issue or Entrapment|Emergency Talk-A-Phone Response|Fire Response|GPS Alarm Response|Intrusion or Forced Entry|Legal Process|Lost High Value Asset or Prototype|Medical Incident|Odor Investigation|Panel Offline|Security Assistance Request (SAR)|Server Room Overheating|Suspicious Activity|Theft|Utility Outage|Vehicle Collision|Workplace Security Support
	GuiControl, Toolkit: Choose, QuestionsDDL, 1
}
If (Region = "ACS LATAM")
{
	GuiControl, Toolkit:, QuestionsDDL, |Select an Incident...|Armed Aggressor|BOLO Sighting|Bomb Threat|Death or Critical Injury|Elevator Issue or Entrapment|Emergency Responders On Campus|Extortion|Facility Support|Fire Response|Innapropriate Behavior|Intrusion or Forced Entry|Kidnapping & Ransom|Legal Process|Lock or Unlock Request|Lost High Value Asset or Prototype|Medical Incident|Missing Person|Odor Investigation|Panel Offline|Protest or Demonstration|Security Assistance Request (SAR)|Server Room Emergency|Suicidal Caller|Suspicious Activity|Suspicious Package or Substance|Theft|Utility Outage|Vehicle Collision|Workplace Security Support|Workplace Violence Response
	GuiControl, Toolkit: Choose, QuestionsDDL, 1
}
If (Region = "Select your region...")
{
	GuiControl, Toolkit: Disable, QuestionsDDL
	GuiControl, Toolkit: Disable, PowerDMS
	GuiControl, Toolkit: Disable, CopyQuestions
}
return

QuestionsDDL:
Gui, Toolkit: Submit, NoHide
If (QuestionsDDL = "Select an Incident...")
{
	PowerDMSLink =
	Questions1 =
}
If (QuestionsDDL = "911 Call Notification")
{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\911_Call_Notification.txt
	PowerDMSLink = https://powerdms.com/docs/1570544
}
If (QuestionsDDL = "Armed Aggressor")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Armed_Aggressor.txt
	PowerDMSLink = https://powerdms.com/docs/1570549
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Armed_Aggressor.txt
	PowerDMSLink = https://powerdms.com/docs/2424640
	}
}
If (QuestionsDDL = "BOLO Sighting")
{
	If (Region = "ACS BAC")
	{
		FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\BOLO_Sighting.txt
		PowerDMSLink = https://powerdms.com/docs/1570550
	}
	If (Region = "ACS India")
	{
		FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\BOLO_Sighting.txt
		PowerDMSLink = https://powerdms.com/docs/2331038
	}
	If (Region = "ACS LATAM")
	{
		FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\BOLO_Sighting.txt
		PowerDMSLink = https://powerdms.com/docs/2424641
	}
}
If (QuestionsDDL = "Bomb Threat")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Bomb_Threat.txt
	PowerDMSLink = https://powerdms.com/docs/1570551
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Bomb_Threat.txt
	PowerDMSLink = https://powerdms.com/docs/2298689
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Bomb_Threat.txt
	PowerDMSLink = https://powerdms.com/docs/2424642
	}
}
If (QuestionsDDL = "Death or Critical Injury")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Death_or_Critical_Injury.txt
	PowerDMSLink = https://powerdms.com/docs/1570552
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Death_or_Critical_Injury.txt
	PowerDMSLink = https://powerdms.com/docs/2424643
	}
}
If (QuestionsDDL = "Elevator Issue or Entrapment")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Elevator_Issue_or_Entrapment.txt
	PowerDMSLink = https://powerdms.com/docs/1570553
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Elevator_Issue_or_Entrapment.txt
	PowerDMSLink = https://powerdms.com/docs/2244011
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Elevator_Issue_or_Entrapment.txt
	PowerDMSLink = https://powerdms.com/docs/2424644
	}
}
If (QuestionsDDL = "Emergency Responders On Campus")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Emergency_Responders_On_Campus.txt
	PowerDMSLink = https://powerdms.com/docs/1570554
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Emergency_Responders_On_Campus.txt
	PowerDMSLink = https://powerdms.com/docs/2424646
	}
}
If (QuestionsDDL = "Emergency Talk-A-Phone Response")
{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Emergency_Talk_A_Phone_Response.txt
	PowerDMSLink = https://powerdms.com/docs/1935631
}
If (QuestionsDDL = "Executive Suite Alarm")
{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Executive_Suite_Alarm.txt
	PowerDMSLink = https://powerdms.com/docs/1571862
}
If (QuestionsDDL = "Extortion")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Extortion.txt
	PowerDMSLink = https://powerdms.com/docs/2287595
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Extortion.txt
	PowerDMSLink = https://powerdms.com/docs/2479205
	}
}
If (QuestionsDDL = "Facility Support")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Facility_Support.txt
	PowerDMSLink = https://powerdms.com/docs/1571868
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Facility_Support.txt
	PowerDMSLink = https://powerdms.com/docs/2424647
	}
}
If (QuestionsDDL = "Fire Response")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Fire_Response.txt
	PowerDMSLink = https://powerdms.com/docs/1571872
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Fire_Response.txt
	PowerDMSLink = https://powerdms.com/docs/2065735
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Fire_Response.txt
	PowerDMSLink = https://powerdms.com/docs/2424648
	}
}
If (QuestionsDDL = "GPS Alarm Response")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\GPS_Alarm_Response.txt
	PowerDMSLink = https://powerdms.com/docs/1571876
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\GPS_Alarm_Response.txt
	PowerDMSLink = https://powerdms.com/docs/2164609
	}
}
If (QuestionsDDL = "Innapropriate Behavior")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Innapropriate_Behavior.txt
	PowerDMSLink = https://powerdms.com/docs/1571943
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Innapropriate_Behavior.txt
	PowerDMSLink = https://powerdms.com/docs/2424649
	}
}
If (QuestionsDDL = "Intrusion or Forced Entry")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Intrusion_or_Forced_Entry.txt
	PowerDMSLink = https://powerdms.com/docs/1571955
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Intrusion_or_Forced_Entry.txt
	PowerDMSLink = https://powerdms.com/docs/2064402
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Intrusion_or_Forced_Entry.txt
	PowerDMSLink = https://powerdms.com/docs/2424650
	}
}
If (QuestionsDDL = "Kidnapping & Ransom")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Kidnapping_&_Ransom.txt
	PowerDMSLink = https://powerdms.com/docs/1571973
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Kidnapping_&_Ransom.txt
	PowerDMSLink = https://powerdms.com/docs/2424655
	}
}
If (QuestionsDDL = "Las Vegas Alarm Response")
{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Las_Vegas_Alarm_Response.txt
	PowerDMSLink = https://powerdms.com/docs/1571975
}
If (QuestionsDDL = "Legal Process")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Legal_Process.txt
	PowerDMSLink = https://powerdms.com/docs/1571976
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Legal_Process.txt
	PowerDMSLink = https://powerdms.com/docs/2368622
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Legal_Process.txt
	PowerDMSLink = https://powerdms.com/docs/2424659
	}
}
If (QuestionsDDL = "Lock or Unlock Request")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Lock_or_Unlock_Request.txt
	PowerDMSLink = https://powerdms.com/docs/1571988
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Lock_or_Unlock_Request.txt
	PowerDMSLink = https://powerdms.com/docs/2424661
	}
}
If (QuestionsDDL = "Lone Worker Emergency Alert")
{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Lone_Worker_Emergency_Alert.txt
	PowerDMSLink = https://powerdms.com/docs/1572000
}
If (QuestionsDDL = "Lost High Value Asset or Prototype")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Lost_High_Value_Asset_or_Prototype.txt
	PowerDMSLink = https://powerdms.com/docs/1572012
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Lost_High_Value_Asset_or_Prototype.txt
	PowerDMSLink = https://powerdms.com/docs/2185918
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Lost_High_Value_Asset_or_Prototype.txt
	PowerDMSLink = https://powerdms.com/docs/2424662
	}
}
If (QuestionsDDL = "Medical Incident")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Medical_Incident.txt
	PowerDMSLink = https://powerdms.com/docs/1572022
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Medical_Incident.txt
	PowerDMSLink = https://powerdms.com/docs/2184448
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Medical_Incident.txt
	PowerDMSLink = https://powerdms.com/docs/2424665
	}
}
If (QuestionsDDL = "Missing Person")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Missing_Person.txt
	PowerDMSLink = https://powerdms.com/docs/1572024
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Missing_Person.txt
	PowerDMSLink = https://powerdms.com/docs/2434298
	}
}
If (QuestionsDDL = "Odor Investigation")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Odor_Investigation.txt
	PowerDMSLink = https://powerdms.com/docs/1572026
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Odor_Investigation.txt
	PowerDMSLink = https://powerdms.com/docs/2249405
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Odor_Investigation.txt
	PowerDMSLink = https://powerdms.com/docs/2434299
	}
}
If (QuestionsDDL = "Panel Offline")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Panel_Offline.txt
	PowerDMSLink = https://powerdms.com/docs/1572028
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Panel_Offline.txt
	PowerDMSLink = https://powerdms.com/docs/1981081
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Panel_Offline.txt
	PowerDMSLink = https://powerdms.com/docs/2479207
	}
}
If (QuestionsDDL = "Protest or Demonstration")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Protest_or_Demonstration.txt
	PowerDMSLink = https://powerdms.com/docs/1572029
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Protest_or_Demonstration.txt
	PowerDMSLink = https://powerdms.com/docs/2424667
	}
}
If (QuestionsDDL = "Security Assistance Request (SAR)")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Security_Assistance_Request.txt
	PowerDMSLink = https://powerdms.com/docs/1572030
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Security_Assistance_Request.txt
	PowerDMSLink = https://powerdms.com/docs/2106432
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Security_Assistance_Request.txt
	PowerDMSLink = https://powerdms.com/docs/2434300
	}
}
If (QuestionsDDL = "SCIF")
{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\SCIF.txt
	PowerDMSLink = https://powerdms.com/docs/1572032
}
If (QuestionsDDL = "Server Room Emergency")
{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Server_Room_Emergency.txt
	PowerDMSLink = https://powerdms.com/docs/2434301
}
If (QuestionsDDL = "Server Room Overheating")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Server_Room_Overheating.txt
	PowerDMSLink = https://powerdms.com/docs/1572035
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Server_Room_Overheating.txt
	PowerDMSLink = https://powerdms.com/docs/2037295
	}
}
If (QuestionsDDL = "Suicidal Caller")
{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Suicidal_Caller.txt
	PowerDMSLink = https://powerdms.com/docs/2507275
}
If (QuestionsDDL = "Suspicious Activity")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Suspicious_Activity.txt
	PowerDMSLink = https://powerdms.com/docs/1572036
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Suspicious_Activity.txt
	PowerDMSLink = https://powerdms.com/docs/2343317
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Suspicious_Activity.txt
	PowerDMSLink = https://powerdms.com/docs/2434302
	}
}
If (QuestionsDDL = "Suspicious Package or Substance")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Suspicious_Package_or_Substance.txt
	PowerDMSLink = https://powerdms.com/docs/1572038
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Suspicious_Package_or_Substance.txt
	PowerDMSLink = https://powerdms.com/docs/2434303
	}
}
If (QuestionsDDL = "Theft")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Theft.txt
	PowerDMSLink = https://powerdms.com/docs/1572039
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Theft.txt
	PowerDMSLink = https://powerdms.com/docs/2184449
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Theft.txt
	PowerDMSLink = https://powerdms.com/docs/2424668
	}
}
If (QuestionsDDL = "Traveler Assistance")
{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Traveler_Assistance.txt
	PowerDMSLink = https://powerdms.com/docs/1572904
}
If (QuestionsDDL = "Utility Outage")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Utility_Outage.txt
	PowerDMSLink = https://powerdms.com/docs/1572906
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Utility_Outage.txt
	PowerDMSLink = https://powerdms.com/docs/2184450
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Utility_Outage.txt
	PowerDMSLink = https://powerdms.com/docs/2439659
	}
}
If (QuestionsDDL = "Vehicle Collision")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Vehicle_Collision.txt
	PowerDMSLink = https://powerdms.com/docs/1572907
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Vehicle_Collision.txt
	PowerDMSLink = https://powerdms.com/docs/2185920
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Vehicle_Collision.txt
	PowerDMSLink = https://powerdms.com/docs/2439666
	}
}
If (QuestionsDDL = "Workplace Security Support")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Workplace_Security_Support.txt
	PowerDMSLink = https://powerdms.com/docs/1572926
	}
	If (Region = "ACS India")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS India\Workplace_Security_Support.txt
	PowerDMSLink = https://powerdms.com/docs/2340600
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Workplace_Security_Support.txt
	PowerDMSLink = https://powerdms.com/docs/2439670
	}
}
If (QuestionsDDL = "Workplace Violence Response")
{
	If (Region = "ACS BAC")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS BAC\Workplace_Violence_Response.txt
	PowerDMSLink = https://powerdms.com/docs/1572930
	}
	If (Region = "ACS LATAM")
	{
	FileRead, Questions1, \\ant\DEPT\ACS-back-up\SOP-Back-Up\Toolkit SOPs\ACS LATAM\Workplace_Violence_Response.txt
	PowerDMSLink = https://powerdms.com/docs/2539601
	}
}

GuiControl, Toolkit: Text, Questions, %Questions1%
Gui, Toolkit: Submit, NoHide
return

PowerDMS:
Run, %PowerDMSLink%
return

CopyQuestions:
If (Questions1 = "Please reference the SOP via PowerDMS.")
	Return
Else
Clipboard = %Questions1%
return

;---------------------------------------------------------------------------------------- Alarm Root Cause Identifer Commands

ARCILocationDDL:
Gui, Toolkit: Submit, NoHide

If (ARCILocationDDL = "Door")
{
	GuiControl, Toolkit:, ARCIAlarmDescriptionDDL, |Select a Description...|Anti-Passback|DC In Use|Door Forced Open|Door Held Open|Emergency Door Release|Emergency Exit|Power Fail|Reader Auxiliary Input|Runaway Device
	GuiControl, Toolkit: Enable, ARCIAlarmDescriptionDDL
}
If (ARCILocationDDL = "Turnstile")
{
	GuiControl, Toolkit:, ARCIAlarmDescriptionDDL, |Select a Description...|Anti-Passback|Beam or Photobeam|Climb or Crawl Over|Power Fail|Reader Auxiliary Input|Runaway Device|Tailgate or Piggyback
	GuiControl, Toolkit: Enable, ARCIAlarmDescriptionDDL
}
If (ARCILocationDDL = "Room")
{
	GuiControl, Toolkit:, ARCIAlarmDescriptionDDL, |Select a Description...|Motion Detector
	GuiControl, Toolkit: Enable, ARCIAlarmDescriptionDDL
}
If (ARCILocationDDL = "Panel")
{
	GuiControl, Toolkit:, ARCIAlarmDescriptionDDL, |Select a Description...|Cabinet Tamper|Power Fail
	GuiControl, Toolkit: Enable, ARCIAlarmDescriptionDDL
}
If (ARCILocationDDL = "Select a Location...")
{
	GuiControl, Toolkit: Disable, ARCIAlarmDescriptionDDL
	GuiControl, Toolkit: Disable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Disable, ARCITroubleshooting
	GuiControl, Toolkit: Disable, ARCICopyTroubleshootingQuestions
}

GuiControl, Toolkit: Text, ARCITroubleshooting,
GuiControl, Toolkit: Disable, ARCIIdentifiedIssueDDL
GuiControl, Toolkit: Disable, ARCITroubleshooting
GuiControl, Toolkit: Disable, ARCICopyTroubleshootingQuestions
GuiControl, Toolkit: Choose, ARCIIdentifiedIssueDDL, 1
GuiControl, Toolkit: Choose, ARCIAlarmDescriptionDDL, 1
GuiControl, Toolkit: Hide, ARCIRootCause
GuiControl, Toolkit: Hide, ARCIDefinition
return

ARCIAlarmDescriptionDDL:
Gui, Toolkit: Submit, NoHide

GuiControl, Toolkit: Hide, ARCIRootCause
GuiControl, Toolkit: Hide, ARCIDefinition

If (ARCIAlarmDescriptionDDL = "Door Forced Open")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Hardware or facilities related issue preventing the door or turnstile from securing|Locking mechanism not re-engaging in 5 seconds after badge scan|Masking and unlock schedule is currently in place, however device is still alarming|Active Lenel impairment resulting in use of alternative methods of access|Badge scans do not register on the device|Hard key used to open a door with a malfunctioning reader|Hard key (or other remote access method) used by individual without proper access|Individual used a tool to force entry into a space|Alarm activates when door is not opened, but is budged or handle is moved|Alarm caused by testing related to new device commissioning or repair|Alarm is related to functionality or operational response of fully commissioned device|Hard key used by associate with proper access to open a door with a functioning reader|Hard key used by IT with proper access to open a door with a functioning reader|Hard key used by security with proper access to open a door with a functioning reader|Alarm caused by an associate not scanning on out reader|Alarm caused by IT personnel not scanning on out reader|Alarm caused by security personnel not scanning on out reader
	GuiControl, Toolkit: Text, ARCITroubleshooting, %DoorForcedOpenTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Door Held Open")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Hardware or facilities related issue preventing the door or turnstile from securing|Masking and unlock schedule is currently in place, however device is still alarming|Alarm is related to functionality or operational response of fully commissioned device|Alarm caused by testing related to new device commissioning or repair|Alarm caused by an associate holding open a door or turnstile|Alarm caused by IT personnel holding open a door or turnstile|Alarm caused by security personnel holding open a door or turnstile
	GuiControl, Toolkit: Text, ARCITroubleshooting, %DoorHeldOpenTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Emergency Door Release")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Hardware or facilities related issue preventing the door or turnstile from securing|Locking mechanism not re-engaging in 5 seconds after badge scan|Alarm activates when door is not opened, but is budged or handle is moved
	GuiControl, Toolkit: Text, ARCITroubleshooting, %EmergencyDoorReleaseTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Emergency Exit")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Hardware or facilities related issue preventing the door or turnstile from securing|Alarm activates when door is not opened, but is budged or handle is moved
	GuiControl, Toolkit: Text, ARCITroubleshooting, %EmergencyExitTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Anti-Passback")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Active Lenel impairment resulting in use of alternative methods of access|Associate exited an MDF without scanning out|IT personnel exited an MDF room without scanning out|Security personnel exited an MDF room without scanning out
	GuiControl, Toolkit: Text, ARCITroubleshooting, %AntiPassbackTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "DC In Use")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|DC In Use is generated
	GuiControl, Toolkit: Text, ARCITroubleshooting, %DCInUseTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Power Fail")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Badge reader associated to the alarm is not functioning appropriately|Ad-hoc work being completed to a panel or device|Planned work being completed with mitigating controls in place|Alarm generates when no work is being done to the panels
	GuiControl, Toolkit: Text, ARCITroubleshooting, %PowerFailTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Tailgate or Piggyback") OR (ARCIAlarmDescriptionDDL = "Beam or Photobeam")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Alarm activates after a single person enters or exits|Alarm activates when no one is entering or exiting|Alarm activates on valid entry or exit scans
	GuiControl, Toolkit: Text, ARCITroubleshooting, %TGorPBorBorPB%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Climb or Crawl Over")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Alarm activates when no one is entering or exiting|Alarm activates when no weight is placed on the turnstile|Alarm activates on valid entry or exit scans
	GuiControl, Toolkit: Text, ARCITroubleshooting, %ClimbOrCrawlOverTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Motion Detector")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Alarm activates when standing or moving outside of the MDF area|Loose items present within the room, tripping MD|Improper badge access into room with multiple associates|Improper badge access into room with multiple associates involving IT|Improper badge access into room with multiple associates involving Security|Improper badge access into room by an associate|Improper badge access into room by IT personnel|Improper badge access into room by security personnel
	GuiControl, Toolkit: Text, ARCITroubleshooting, %MotionDetectorTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Cabinet Tamper")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Alarm generates when no work is being done to the panels|Badge reader associated to the alarm is not functioning appropriately|Ad-hoc work being completed to a panel or device|Planned work being completed with mitigating controls in place
	GuiControl, Toolkit: Text, ARCITroubleshooting, %CabinetTamperTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Reader Auxiliary Input")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Alarm Input/Output or Device is Reader Auxiliary Input
	GuiControl, Toolkit: Text, ARCITroubleshooting, %ReaderAuxiliaryInputTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Runaway Device")
{
	GuiControl, Toolkit:, ARCIIdentifiedIssueDDL, |Select the Identified Issue...|Alarm description is 'Runaway Device'
	GuiControl, Toolkit: Text, ARCITroubleshooting, %RunawayDeviceTroubleshooting%
	GuiControl, Toolkit: Enable, ARCIIdentifiedIssueDDL
	GuiControl, Toolkit: Enable, ARCITroubleshooting
	GuiControl, Toolkit: Enable, ARCICopyTroubleshootingQuestions
}
If (ARCIAlarmDescriptionDDL = "Select a Description...")
{
GuiControl, Toolkit: Disable, ARCIIdentifiedIssueDDL
GuiControl, Toolkit: Disable, ARCITroubleshooting
GuiControl, Toolkit: Disable, ARCICopyTroubleshootingQuestions
GuiControl, Toolkit: Text, ARCITroubleshooting,
}

GuiControl, Toolkit: Choose, ARCIIdentifiedIssueDDL, 1
return

ARCICopyTroubleshootingQuestions:
Gui, Toolkit: Submit, NoHide
If (ARCIAlarmDescriptionDDL = "Select a Description...")
	Return
Else
Clipboard = %ARCITroubleshooting%
return

ARCIIdentifiedIssueDDL:
Gui, Toolkit: Submit, NoHide

If (ARCIIdentifiedIssueDDL = "Masking and unlock schedule is currently in place, however device is still alarming") OR (ARCIIdentifiedIssueDDL = "Locking mechanism not re-engaging in 5 seconds after badge scan") OR (ARCIIdentifiedIssueDDL = "DC In Use is generated") OR (ARCIIdentifiedIssueDDL = "Alarm Input/Output is Reader Auxiliary Input")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Programming Issue
GuiControl, Toolkit: Text, ARCIDefinition, Issue with the Lenel Programming of the alarms causing false, faulty, or excessive alarms at a single device/space.
}
If (ARCIIdentifiedIssueDDL = "Active Lenel impairment resulting in use of alternative methods of access")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Technical Issue
GuiControl, Toolkit: Text, ARCIDefinition, Issue with the Lenel System causing false, faulty, or excessive alarms at a large scale (entire site/region.)
}
If (ARCIIdentifiedIssueDDL = "Improper badge access into room") OR (ARCIIdentifiedIssueDDL = "Improper badge access into room with multiple people") OR (ARCIIdentifiedIssueDDL = "Associate exited an MDF without scanning out") OR (ARCIIdentifiedIssueDDL = "Hard key used by associate with proper access to open a door with a functioning reader") OR (ARCIIdentifiedIssueDDL = "Improper badge access into room with multiple associates") OR (ARCIIdentifiedIssueDDL = "Improper badge access into room by an associate") OR (ARCIIdentifiedIssueDDL = "Alarm caused by an associate not scanning on out reader") OR (ARCIIdentifiedIssueDDL = "Alarm caused by an associate holding open a door or turnstile")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Human Error
GuiControl, Toolkit: Text, ARCIDefinition, Alarm cause by Authorized User who used security feature incorrectly.
}
If (ARCIIdentifiedIssueDDL = "IT personnel exited an MDF room without scanning out") OR (ARCIIdentifiedIssueDDL = "Hard key used by IT with proper access to open a door with a functioning reader") OR (ARCIIdentifiedIssueDDL = "Improper badge access into room with multiple associates involving IT") OR (ARCIIdentifiedIssueDDL = "Improper badge access into room by IT personnel") OR (ARCIIdentifiedIssueDDL = "Alarm caused by IT personnel not scanning on out reader") OR (ARCIIdentifiedIssueDDL = "Alarm caused by IT personnel holding open a door or turnstile")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Human Error by IT
GuiControl, Toolkit: Text, ARCIDefinition, Alarm caused by Authorized IT User who used security feature incorrectly.
}
If (ARCIIdentifiedIssueDDL = "Security personnel exited an MDF room without scanning out") OR (ARCIIdentifiedIssueDDL = "Hard key used by security with proper access to open a door with a functioning reader") OR (ARCIIdentifiedIssueDDL = "Improper badge access into room with multiple associates involving Security") OR (ARCIIdentifiedIssueDDL = "Improper badge access into room by security personnel") OR (ARCIIdentifiedIssueDDL = "Alarm caused by security personnel not scanning on out reader") OR (ARCIIdentifiedIssueDDL = "Alarm caused by security personnel holding open a door or turnstile")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Human Error by Security
GuiControl, Toolkit: Text, ARCIDefinition, Alarm caused by Authorized Security User who used security feature incorrectly.
}
If (ARCIIdentifiedIssueDDL = "Hard key (or other remote access method) used by individual without proper access")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Key Override
GuiControl, Toolkit: Text, ARCIDefinition, Unauthorized access into space, via hard key entry or unauthorized remote access (e.g. door pulse).
}
If (ARCIIdentifiedIssueDDL = "Individual used a tool to force entry into a space")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Breach/Forced Entry
GuiControl, Toolkit: Text, ARCIDefinition, Access (or attempted access) into space through forced entry.
}
If (ARCIIdentifiedIssueDDL = "Alarm caused by testing related to new device commissioning or repair")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Testing
GuiControl, Toolkit: Text, ARCIDefinition, Testing being conducted to verify initial function of a new device or repair status of a broken device.
}
If (ARCIIdentifiedIssueDDL = "Alarm is related to functionality or operational response of fully commissioned device")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Audit
GuiControl, Toolkit: Text, ARCIDefinition, Audit being conducted to verify functionally and/or operational response of fully commissioned and operational system/device.
}
If (ARCIIdentifiedIssueDDL = "Alarm activates on valid entry or exit scans") OR (ARCIIdentifiedIssueDDL = "Alarm activates when no one is entering or exiting") OR (ARCIIdentifiedIssueDDL = "Alarm activates after a single person enters or exits") OR (ARCIIdentifiedIssueDDL = "Badge reader associated to the alarm is not functioning appropriately") OR (ARCIIdentifiedIssueDDL = "Alarm activates when door is not opened, but is budged or handle is moved") OR (ARCIIdentifiedIssueDDL = "Hard key used to open a door with a malfunctioning reader") OR (ARCIIdentifiedIssueDDL = "Badge scans do not register on the device") OR (ARCIIdentifiedIssueDDL = "Hardware or facilities related issue preventing the door or turnstile from securing") OR (ARCIIdentifiedIssueDDL = "Alarm activates when no weight is placed on the turnstile") OR (ARCIIdentifiedIssueDDL = "Alarm activates when standing or moving outside of the MDF area") OR (ARCIIdentifiedIssueDDL = "Loose items present within the room, tripping MD") OR (ARCIIdentifiedIssueDDL = "Alarm generates when no work is being done to the panels") OR (ARCIIdentifiedIssueDDL = "Alarm description is 'Runaway Device'")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w350
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w350
GuiControl, Toolkit: Show, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Device Issue
GuiControl, Toolkit: Text, ARCIDefinition, Issue with a Lenel device or facilities hardware causing false, faulty, or excessive alarms at a single device/space.
}
If (ARCIIdentifiedIssueDDL = "Planned work being completed with mitigating controls in place")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Pre-Notified Work
GuiControl, Toolkit: Text, ARCIDefinition, Planned work in the space that will cause an unavoidable alarm to trigger. Mitigation could be considered or planned ahead of time.
}
If (ARCIIdentifiedIssueDDL = "Ad-hoc work being completed to a panel or device")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause, Un-Notified Work
GuiControl, Toolkit: Text, ARCIDefinition, Unplanned work in the space that will cause an unavoidable alarm to trigger. Mitigation could not be considered or planned ahead of time.
}
If (ARCIIdentifiedIssueDDL = "Select the Identified Issue...")
{
GuiControl, Toolkit: Move, ARCIRootCause, x10 y317 w500
GuiControl, Toolkit: Move, ARCIDefinition, x10 y352 w500
GuiControl, Toolkit: Hide, ARCISimT
GuiControl, Toolkit: Text, ARCIRootCause,
GuiControl, Toolkit: Text, ARCIDefinition,
}


GuiControl, Toolkit: Show, ARCIRootCauseText
GuiControl, Toolkit: Show, ARCIRootCause
GuiControl, Toolkit: Show, ARCIDefinitionText
GuiControl, Toolkit: Show, ARCIDefinition
return

ARCISimT:
Run, https://t.corp.amazon.com/create/templates/67cd5847-8fb3-4bf7-9fd6-8b631def7aef
return

;---------------------------------------------------------------------------------------- World Clock Controls

ACSTime:
TimeString =  %A_NowUTC%
TimeString += -4, Hours
FormatTime, TimeString, %TimeString%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, TimeString, %TimeString%

ACSPST =  %A_NowUTC%
ACSPST += -7, Hours
FormatTime, ACSPST, %ACSPST%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, ACSPST, %ACSPST%

ACSCST =  %A_NowUTC%
ACSCST += -5, Hours
FormatTime, ACSCST, %ACSCST%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, ACSCST, %ACSCST%

ACSMST =  %A_NowUTC%
ACSMST += -6, Hours
FormatTime, ACSMST, %ACSMST%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, ACSMST, %ACSMST%

indt =  %A_NowUTC%
indt += 5, Hours
indt += 30, Minutes
FormatTime, indt, %indt%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, indt, %indt%

lndt =  %A_NowUTC%
lndt += 1, Hours
FormatTime, lndt, %lndt%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, lndt, %lndt%

sydt =  %A_NowUTC%
sydt += 10, Hours
FormatTime, sydt, %sydt%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, sydt, %sydt%

bert =  %A_NowUTC%
bert += 2, Hours
FormatTime, bert, %bert%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, bert, %bert%

bejt =  %A_NowUTC%
bejt += 8, Hours
FormatTime, bejt, %bejt%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, bejt, %bejt%

tokt =  %A_NowUTC%
tokt += 9, Hours
FormatTime, tokt, %tokt%, HH:mm:ss     MM/dd
GuiControl, Toolkit: Text, tokt, %tokt%
return

;---------------------------------------------------------------------------------------- SLA GUI

Continue:

if WinExist("Alarm Acknowledger") {
	WinGetPos, acknowledgeX, acknowledgeY,,,Alarm Acknowledger
}

Gui, AA: submit
Gui, AA: destroy

If (Cause = "Select...")
{
Cause = 0
MsgBox,48,Error,Missing Information
Gosub, ReloadCauseInformation
return
}

ReloadSLAInformation:

If (SLA = 1)
{
Gui, AA: Color, Black,White
Gui, AA: +alwaysontop +ToolWindow -Border -Theme
Gui, AA: Font, w800 s9, Calibri
Gui, AA: Add, Picture, x0 y0 h280 w397,  %A_WorkingDir%\resources\%BackgroundImmage%

Gui, AA: Add, Text, BackgroundTrans x80 y7, BAC
Gui, AA: Add, Text, BackgroundTrans x280 yp, System
Gui, AA: Add, Text, BackgroundTrans x80 y127, Guard
Gui, AA: Add, Text, BackgroundTrans x280 yp, Facility

Gui, AA: Add, GroupBox, Color x10 y20 w175 h100
Gui, AA: Add, GroupBox, Color x210 y20 w175 h100
Gui, AA: Add, GroupBox, Color x10 y140 w175 h100
Gui, AA: Add, GroupBox, Color x210 y140 w175 h100

Gui, AA: Add, Checkbox, color w13 h13 x20 y37 vOversightSLA, Oversight
Gui, AA: Add, Text, BackgroundTrans x37 yp, Operator oversight
Gui, AA: Add, Checkbox, color w13 h13 x20 yp+20 vTriageSLA, Event triage
Gui, AA: Add, Text, BackgroundTrans x37 yp, Event triage


Gui, AA: Add, Checkbox, color w13 h13 x220 y37 vCameraSLA, Camera
Gui, AA: Add, Text, BackgroundTrans x237 yp, Camera outage
Gui, AA: Add, Checkbox, color w13 h13 x220 yp+20  vAlarmLatencySLA, Latency
Gui, AA: Add, Text, BackgroundTrans x237 yp, Alarm latency
Gui, AA: Add, Checkbox, color w13 h13 x220 yp+20  vLenelOutageSLA, Outage
Gui, AA: Add, Text, BackgroundTrans x237 yp, Lenel outage

Gui, AA: Add, Checkbox, color w13 h13 x20 y157  vLocationSLA, Location
Gui, AA: Add, Text, BackgroundTrans x37 yp, Couldn't reach location
Gui, AA: Add, Checkbox, color w13 h13 x20 yp+20  vBadgeSLA, Badge
Gui, AA: Add, Text, BackgroundTrans x37 yp, Did not scan badge
Gui, AA: Add, Checkbox, color w13 h13 x20 yp+20  vCallbackSLA, Callback
Gui, AA: Add, Text, BackgroundTrans x37 yp, Did not callback
Gui, AA: Add, Checkbox, color w13 h13 x20 yp+20  vLateSLA, Late
Gui, AA: Add, Text, BackgroundTrans x37 yp, Late / No show

Gui, AA: Add, Checkbox, color w13 h13 x220 y157  vPWorkSLA, PWork
Gui, AA: Add, Text, BackgroundTrans x237 yp, Planned work
Gui, AA: Add, Checkbox, color w13 h13 x220 yp+20  vUPWorkSLA, UWork
Gui, AA: Add, Text, BackgroundTrans x237 yp, Unplanned work
Gui, AA: Add, Checkbox, color w13 h13 x220 yp+20  vPWorkMSLA, PWorkM
Gui, AA: Add, Text, BackgroundTrans x237 yp, Planned work (mitigated)
Gui, AA: Add, Checkbox, color w13 h13 x220 yp+20  vUPWorkMSLA, UPWorkM
Gui, AA: Add, Text, BackgroundTrans x237 yp, Unlanned work (mitigated)

Gui, AA: Add, Button, x10 yp+30 Default gContinue2, Acknowledge
Gui, AA: Add, Button, yp x100 gCancel, Cancel
Gui, AA: Margin , x0, Y0
Gui, AA: Show, x%acknowledgeX% y%acknowledgeY%, SLA Information
;gui, AA:show, % ((acknowledgeX && acknowledgeY) ? "x" acknowledgeX "y" acknowledgeY : ""),SLA Information ;use gui location variables if they exist, otherwise use the default location.
WinGetPos, acknowledgeX, acknowledgeY,,, SLA Information
GuiControl, AA: focus, Acknowledge

Return
}

Continue2:

If (SLA = 1)
{
WinGetPos, acknowledgeX, acknowledgeY,,,SLA Information
}

Gui, AA: submit
Gui, AA: destroy

;---------------------------------------------------------------------------------------- SLA Failure Required Boxes

If (SLA = 1 and LocationSLA = 0 and OversightSLA = 0 and TriageSLA = 0 and CameraSLA = 0 and AlarmLatencySLA = 0 and LenelOutageSLA = 0 and LocationSLA = 0 and BadgeSLA = 0 and CallbackSLA = 0 and LateSLA = 0 and PWorkSLA = 0 and UPWorkSLA = 0 and PWorkMSLA = 0 and UPWorkMSLA = 0)
{
MsgBox,48,Error,Missing Information
Gosub, ReloadSLAInformation
return
}

;---------------------------------------------------------------------------------------- Variable Clearing GUI

ReloadVariableClearingGUI:

If ((Responder = "Other") or (Cause = "Device Issue")  or (Cause = "Breach/Forced Entry") or (Cause = "Emergency Event") or (Cause = "Pre-Notified Work") or (TriageSLA= 1 and SLA = 1) or (CameraSLA= 1 and SLA = 1) or (AlarmLatencySLA= 1 and SLA = 1) or (LenelOutageSLA= 1 and SLA = 1) or (LocationSLA= 1 and SLA = 1))
{

VariableClearing = True
Gosub VariableClearingGUISize
Gui, AA: Color, Black, White
Gui, AA: +alwaysontop +ToolWindow -Border -Theme
Gui, AA: Font, w800 s9, Calibri
Gui, AA: Add, Picture, icon x0 y0 h%Height% w%Width%, %A_WorkingDir%\resources\%BackgroundImmage%
Gui, AA: Add, Edit, h0 w0 x10 y0, GUIControllPosition

;---------------------------------------------------------------------------------------- Main Variables

If (Responder = "Other")
{
Gui, AA: Add, Text, BackgroundTrans, Responder:
Gui, AA: Add, Edit, w130 vResponder
}

If (Cause = "Device Issue")
{
Gui, AA: Add, Text, BackgroundTrans, SIM T#:
Gui, AA: Add, Edit, w130 vDeviceTT
GuiControl, AA: focus, DeviceIssueTT
}

If (Cause = "Pre-Notified Work")
{
Gui, AA: Add, Text, BackgroundTrans, SIM T#:
Gui, AA: Add, Edit, w130 vDeviceTT
GuiControl, AA: focus, PreNotifiedWorkTT
}

If (Cause = "Breach/Forced Entry")
{
Gui, AA: Add, Text,BackgroundTrans, Case #:
Gui, AA: Add, Edit, w130 vDeviceTT
GuiControl, AA: focus, BreachedForcedEntryTT
}

If (Cause = "Emergency Event")
{
Gui, AA: Add, Text,BackgroundTrans, Case #:
Gui, AA: Add, Edit, w130 vDeviceTT
GuiControl, AA: focus, EmergencyEventTT
}

;---------------------------------------------------------------------------------------- SLA System


If (CameraSLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Camera:
Gui, AA: Add, DropDownList, vCameraSLAType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vCameraSLATT
GuiControl, AA: focus, CameraSLATT
}

If (LenelOutageSLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Lenel Outage:
Gui, AA: Add, DropDownList, vLenelOutageType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vLenelOutageTT
GuiControl, AA: focus, LenelOutageTT
}

If (AlarmLatencySLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Alarm Latency:
Gui, AA: Add, DropDownList, vAlarmLatencyType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vAlarmLatencyTT
GuiControl, AA: focus, AlarmLatencyTT
}

;---------------------------------------------------------------------------------------- SLA ACS

If (TriageSLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Triage:
Gui, AA: Add, DropDownList, vTriageType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vTriageTT
GuiControl, AA: focus, TriageTT
}

;---------------------------------------------------------------------------------------- SLA Guard

If (LocationSLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Access Request:
Gui, AA: Add, DropDownList, vLocationType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vLocationTT
GuiControl, AA: focus, LocationTT
}

;---------------------------------------------------------------------------------------- SLA end

Gui, AA: Add, Button, Default gContinue3, Acknowledge
Gui, AA: Add, Button, yp x95 gCancel, Cancel

Gui, AA: Margin , x0, Y0
Gui, AA: Show, x%acknowledgeX% y%acknowledgeY%, Information
;gui, AA:show, % ((acknowledgeX && acknowledgeY) ? "x" acknowledgeX "y" acknowledgeY : ""),Information

return

;---------------------------------------------------------------------------------------- Variabel Clearing Size/Picture

VariableClearingGUISize:

Gui, AA: Color, Black, White
Gui, AA: +alwaysontop +ToolWindow -Border -Theme
Gui, AA: Font, w800 s9, Calibri
Gui, AA: Add, Edit, h0 w0 x10 y0, GUIControllPosition

;---------------------------------------------------------------------------------------- Main Variables

If (Responder = "Other")
{
Gui, AA: Add, Text, BackgroundTrans, Responder:
Gui, AA: Add, Edit, w130 vResponder
}

If (Cause = "Device Issue")
{
Gui, AA: Add, Text, BackgroundTrans, SIM T:
Gui, AA: Add, Edit, w130 vDeviceTT
GuiControl, AA: focus, DeviceIssueTT
}

If (Cause = "Pre-Notified Work")
{
Gui, AA: Add, Text, BackgroundTrans, SIM T:
Gui, AA: Add, Edit, w130 vDeviceTT
GuiControl, AA: focus, PreNotifiedWorkTT
}

If (Cause = "Breach/Forced Entry")
{
Gui, AA: Add, Text,BackgroundTrans, Case:
Gui, AA: Add, Edit, w130 vDeviceTT
GuiControl, AA: focus, BreachedForcedEntryTT
}

If (Cause = "Emergency Event")
{
Gui, AA: Add, Text,BackgroundTrans, Case:
Gui, AA: Add, Edit, w130 vDeviceTT
GuiControl, AA: focus, EmergencyEventTT
}

;---------------------------------------------------------------------------------------- SLA System

If (CameraSLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Camera:
Gui, AA: Add, DropDownList, vCameraSLAType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vCameraSLATT
GuiControl, AA: focus, CameraSLATT
}

If (LenelOutageSLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Lenel Outage:
Gui, AA: Add, DropDownList, vLenelOutageType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vLenelOutageTT
GuiControl, AA: focus, LenelOutageTT
}

If (AlarmLatencySLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Alarm Latency:
Gui, AA: Add, DropDownList, vAlarmLatencyType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vAlarmLatencyTT
GuiControl, AA: focus, AlarmLatencyTT
}

;---------------------------------------------------------------------------------------- SLA Guard

If (TriageSLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Triage:
Gui, AA: Add, DropDownList, vTriageType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vTriageTT
GuiControl, AA: focus, TriageTT
}

;---------------------------------------------------------------------------------------- SLA Guard

If (LocationSLA= 1 and SLA = 1)
{
Gui, AA: Add, Text,BackgroundTrans, Guard Access Request:
Gui, AA: Add, DropDownList, vLocationType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vLocationTT
GuiControl, AA: focus, LocationTT
}

;---------------------------------------------------------------------------------------- SLA end

Gui, AA: Add, Button, Default, Acknowledge
Gui, AA: Add, Button, yp+4 x99 gCancel, Cancel

Gui, AA: Margin , x0, Y0

Gui, AA: Show, x%acknowledgeX% y%acknowledgeY%, InformationSize
;gui, AA:show, % ((acknowledgeX && acknowledgeY) ? "x" acknowledgeX "y" acknowledgeY : ""),InformationSize

WinGetPos,,, Width, Height, InformationSize
WinGetPos, acknowledgeX, acknowledgeY,,, InformationSize

Gui, AA: destroy

return
}

;---------------------------------------------------------------------------------------- SLA end end

Continue3:

If (VariableClearing = "True")
{
WinGetPos, acknowledgeX, acknowledgeY,,, Information
}

Gui, AA: submit
Gui, AA: destroy

;---------------------------------------------------------------------------------------- Variable Clearing GUI Required Boxes

If (Responder = "")
{
MsgBox,48,Error,Missing Information
Responder = Other
Gosub, ReloadVariableClearingGUI
return
}

If ((SLA = 1 and TriageSLA = 1 and TriageTT = "") or (SLA = 1 and CameraSLA = 1 and CameraSLATT = "") or (SLA = 1 and AlarmLatencySLA = 1 and AlarmLatencyTT = "") (SLA = 1 and LenelOutageSLA = 1 and LenelOutageTT = "") or (SLA = 1 and LocationSLA = 1 and LocationTT = ""))
{
MsgBox,48,Error,Missing Information
Gosub, ReloadVariableClearingGUI
return
}

;---------------------------------------------------------------------------------------- ROS Logic

If (Responder = "ACS Operator")
{
Responder =%A_UserName%
ROS =CCTV Review;
}
Else
{
ROS =ROS;
}

;---------------------------------------------------------------------------------------- Day0 Logic

If (Day0 = 1)
{
Day0 =; Day 0
}
Else
{
Day0 =
}

;---------------------------------------------------------------------------------------- Priority Logic

If (Priority = 1)
{
PriorityText =; Responder has inspected the device; The responder stated they scanned their badge at the security device
}
else
{
PriorityText =
}

;---------------------------------------------------------------------------------------- Cause Logic

If (Cause = "Device Issue")
{
DTTTText =; SIM T%DeviceMalfuncitonType%:%DeviceTT%
}
else
{
DTTTText =
}

If (Cause = "Pre-Notified Work")
{
DTTText =; SIM T%DeviceMalfuncitonType%:%DeviceTT%
}
else
{
DTTText =
}

If (Cause = "Breach/Forced Entry")
{
IncidentText =; Case:%DeviceTT%
}
Else
{
IncidentText =
}

If (Cause = "Emergency Event")
{
IncidentText =; Case:%DeviceTT%
}
Else
{
EventText =
}


;---------------------------------------------------------------------------------------- Variable Clearing GUI non-Required Boxes

If ((Cause = "Breach/Forced Entry" and DeviceTT = "") or (Cause = "Device Issue" and DeviceTT = "") or (Cause = "Pre-notified Work" and DeviceTT = "") or (Cause = "Emergency Event" and DeviceTT = ""))
{
IncidentText =
DTTText =
DTTTText =
EventText =
}

;---------------------------------------------------------------------------------------- SLA Logic

If (SLA = 1)
{
	SLAText=; SLA
	Ownership =; Ownership
	Type =; Type
}
else
{
	SLAText =
	Ownership =
	Type =
	ACSOwnership =
	SystemOwnership =
	GuardOwnership =
	FacilityOwnership =
	SLAType1 =
	SLAType2 =
	SLAType4 =
	SLAType5 =
	SLAType6 =
	SLAType7 =
	SLAType8 =
	SLAType9 =
	SLAType10 =
	SLAType11 =
	SLAType12 =
	SLAType13 =
	SLAType14 =
	CameraSLAText =
	LenelOutageText =
	AlarmLatencyText =
	TriageText =
	LocationText =
	OversightSLA = 0
	TriageSLA = 0
	AlarmLatencySLA = 0
	CallbackSLA = 0
	LateSLA = 0
	LateSLA = 0
	BadgeSLA = 0
	PWorkSLA = 0
	UPWorkSLA = 0
	LenelOutageSLA = 0
	CameraSLA = 0
	LocationSLA = 0
	PWorkMSLA = 0
	UPWorkMSLA = 0
}

;---------------------------------------------------------------------------------------- TRUE / FALSE Logic

If (OversightSLA = 1 or TriageSLA = 1 or AlarmLatencySLA = 1 or CallbackSLA = 1 or LateSLA = 1 or BadgeSLA = 1 or PWorkSLA = 1 or UPWorkSLA = 1 or LenelOutageSLA = 1)
{
	TF =; True
}
else if (CameraSLA = 1  or LocationSLA = 1 or PWorkMSLA = 1 or UPWorkMSLA = 1)
{
	TF =; False
}
else
{
TF =
}

;---------------------------------------------------------------------------------------- SLA Ownership Logic

If (OversightSLA = 1 or TriageSLA = 1)
{
	ACSOwnership =/ACS
}
Else
{
	ACSOwnership =
}

If (DeviceSLA = 1 or CameraSLA = 1 or AlarmLatencySLA = 1 or LenelOutageSLA = 1)
{
	SystemOwnership =/System
}
Else
{
	SystemOwnership =
}

If (LocationSLA = 1 or BadgeSLA = 1 or CallbackSLA = 1 or LateSLA = 1)
{
	GuardOwnership =/Guard
}
Else
{
	GuardOwnership =
}

If (PWorkSLA = 1 or UPWorkSLA = 1 or PWorkMSLA = 1 or UPWorkMSLA = 1)
{
	FacilityOwnership =/Facility
}
Else
{
	FacilityOwnership =
}

;---------------------------------------------------------------------------------------- SLA Type Logic

If (OversightSLA = 1)
{
	SLAType1 =/Oversight
}
else
{
	SLAType1 =
}
If (TriageSLA = 1)
{
	SLAType2 =/Triage
}
else
{
	SLAType2 =
}
If (CameraSLA = 1)
{
	SLAType4 =/Camera
}
else
{
	SLAType4 =
}
If (AlarmLatencySLA = 1)
{
	SLAType5 =/Latency
}
else
{
	SLAType5 =
}
If (LenelOutageSLA = 1)
{
	SLAType6 =/Outage
}
else
{
	SLAType6 =
}
If (LocationSLA = 1)
{
	SLAType7 =/Location
}
else
{
	SLAType7 =
}
If (BadgeSLA = 1)
{
	SLAType8 =/Badge
}
else
{
	SLAType8 =
}
If (CallbackSLA = 1)
{
	SLAType9 =/Call
}
else
{
	SLAType9 =
}
If (LateSLA = 1)
{
	SLAType10 =/Late
}
else
{
	SLAType10 =
}
If (PWorkSLA = 1)
{
	SLAType11 =/Planned Work
}
else
{
	SLAType11 =
}
If (UPWorkSLA = 1)
{
	SLAType12 =/Unplanned Work
}
else
{
	SLAType12 =
}
If (PWorkMSLA = 1)
{
	SLAType13 =/Planned Work Mitigated
}
else
{
	SLAType13 =
}
If (UPWorkMSLA = 1)
{
	SLAType14 =/Unplanned Work Mitigated
}
else
{
	SLAType14 =
}

;---------------------------------------------------------------------------------------- SLA Reference Logic

If (CameraSLA = 1)
{
	CameraSLAText =; Camera %CameraSLAType%:%CameraSLATT%
}
Else
{
	CameraSLAText =
}

If (LenelOutageSLA = 1)
{
	LenelOutageText =; Lenel %LenelOutageType%:%LenelOutageTT%
}
Else
{
	LenelOutageText =
}

If (AlarmLatencySLA = 1)
{
	AlarmLatencyText =; Alarm %AlarmLatencyType%:%AlarmLatencyTT%
}
Else
{
	AlarmLatencyText =
}

If (TriageSLA = 1)
{
	TriageText =; Triage %TriageType%:%TriageTT%
}
Else
{
	TriageText =
}

If (LocationSLA = 1)
{
	LocationText =; Location %LocationType%:%LocationTT%
}
Else
{
	LocationText =
}



;---------------------------------------------------------------------------------------- Clipboard String

Clipboard =
(
AA3.01; %ROS% %Responder%; %Cause%%Day0%%DTTText%%DTTTText%%IncidentText%%EventText%%CameraSLAText%%LenelOutageText%%AlarmLatencyText%%TriageText%%LocationText%%SLAText%%TF%%Ownership%%ACSOwnership%%SystemOwnership%%GuardOwnership%%FacilityOwnership%%Type%%SLAType1%%SLAType2%%SLAType4%%SLAType5%%SLAType6%%SLAType7%%SLAType8%%SLAType9%%SLAType10%%SLAType11%%SLAType12%%SLAType13%%SLAType14%%PriorityText%
)

;---------------------------------------------------------------------------------------- Lenel Interaction

WinActivate, ahk_id %lenelWinId%

Send,^{F12}

WinWait, ahk_group FastGroup,,1
if ErrorLevel
{
MsgBox,48,Error,Lenel Not Found.`nClear Results have been copied to your clipboard.
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
Reload
return
}

Send,a

WinWait, ahk_group Acknowledgeselectedalarms,,1
if ErrorLevel
{
MsgBox,48,Error,Acknowledge Box Not Found.`nClear Results have been copied to your clipboard.
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
Reload
return
}

SendInput,^v

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;---------------------------------------------------------------------------------------- Quck Clear Gui
#IfWinActive, Remote Desktop
^1::
^Numpad1::
#IfWinActive, Alarm Acknowledgment
^1::
^Numpad1::
#IfWinActive, Alarm Monitoring
^1::
^Numpad1::
WinGet, lenelWinId, ID, A

Gui, AA: Destroy
Gui, AA: Color, Black,White
Gui, AA: +alwaysontop +ToolWindow -Border -Theme
Gui, AA: Font, w800 s9, Calibri
Gui, AA: Add, Picture, x0 y0 h138 w105, %A_WorkingDir%\resources\%BackgroundImmage%
Gui, AA: Add, Button, Default gConstruction W85 x10 y10, Construction
Gui, AA: Add, Button, gNVR W85, NVR
Gui, AA: Add, Button, gUCTCGUI W85, UCTC
Gui, AA: Add, Button, W85 gCancel, Cancel
Gui, AA: Margin , x0, Y0
Gui, AA: Show, x%acknowledgeX% y%acknowledgeY%, Quick Clear
;gui, AA:show, % ((acknowledgeX && acknowledgeY) ? "x" acknowledgeX "y" acknowledgeY : ""),Quick Clear

Return

;--------------------------------------------------------------------------------------- UC Logic

Construction:

WinGetPos, acknowledgeX, acknowledgeY,,,Quick Clear

Gui, AA: Submit
Gui, AA: Destroy

Clipboard =
(
Under Construction
)

;--------------------------------------------------------------------------------------- UC Lenel Interaction

IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

Send,^{F12}

WinWait, ahk_group FastGroup,,1
if (ErrorLevel) {
	MsgBox,48,Error,Lenel Not Found.`nClear Results have been copied to your clipboard.
	Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
	return
}

Send,a

WinWait, ahk_group Acknowledgeselectedalarms,,1
if ErrorLevel
{
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
Reload
return
}
Send,^v
Send,{Enter}
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
return

;--------------------------------------------------------------------------------------- Auto SHM TT Logic

NVR:

WinGetPos, acknowledgeX, acknowledgeY,,,Quick Clear

Gui, AA: Submit
Gui, AA: Destroy

Clipboard =
(
Auto System Health Ticket Generated
)

WinActivate, ahk_id %lenelWinId%

Send,^{F12}

if (ErrorLevel) {
	MsgBox,48,Error,Lenel Not Found.`nClear Results have been copied to your clipboard.
	Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
	return
}

Send,a

WinWait, ahk_group Acknowledgeselectedalarms,,1
if (ErrorLevel) {
	Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
	return
}

Send,^v

Send,{Enter}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;---------------------------------------------------------------------------------------- UCTC Logic

UCTCGUI:

WinGetPos, acknowledgeX, acknowledgeY,,,Quick Clear

UCTCGUIReturn:

Gui, AA: Submit
Gui, AA: Destroy

Gui, AA: Color, Black,White
Gui, AA: +alwaysontop +ToolWindow -Border -Theme
Gui, AA: Font, w800 s9, Calibri
Gui, AA: Add, Picture, x0 y0 h100 w152,  %A_WorkingDir%\resources\%BackgroundImmage%

Gui, AA: Add, DropDownList, x10 y10 vUCTCWorkType W55, SIM T||MCM|SIM|Case #
Gui, AA: Add, Edit, w130 vUCTCReference
Gui, AA: Add, Button, Default gUCTCLogic, Acknowledge
Gui, AA: Add, Button, yp x95 gCancel, Cancel
GuiControl, AA: Focus, UCTCReference
Gui, AA: Margin , x0, Y0

gui, AA:show, % ((acknowledgeX && acknowledgeY) ? "x" acknowledgeX "y" acknowledgeY : ""),Update

Return

UCTCLogic:

Gui, AA: Show, x%acknowledgeX% y%acknowledgeY%, Update
;WinGetPos, acknowledgeX, acknowledgeY,,,Update

Gui, AA: Submit
Gui, AA: Destroy

If (UCTCReference = "")
{
MsgBox,48,Missing Information,-  UCTC %UCTCReference%
Gosub, UCTCGUIReturn
return
}

Clipboard =
(
UCTC; %UCTCWorkType%:%UCTCReference%; %Date%; %Time%
)

WinActivate, ahk_id %lenelWinId%

Send,^{F12}

if ErrorLevel
{
MsgBox,48,Error,Lenel Not Found.`nClear Results have been copied to your clipboard.
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
Reload
return
}

Send,a

WinWait, ahk_group Acknowledgeselectedalarms,,1
if ErrorLevel
{
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
Reload
return
}

Send,^v

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return


;---------------------------------------------------------------------------------------- In Progress
#IfWinActive, Remote Desktop
^Up::
^6::
#IfWinActive, Alarm Acknowledgment
^Up::
^6::
#IfWinActive, Alarm Monitoring
^Up::
^6::
WinGet, lenelWinId, ID, A

WinActivate, ahk_Id %lenelWinID%
Send,^{F12}

Send,i

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;--------------------------------------------------------------------------------------- Delete
#IfWinActive, Remote Desktop
^Delete::
#IfWinActive, Alarm Acknowledgment
^Delete::
#IfWinActive, Alarm Monitoring
^Delete::
WinGet, lenelWinId, ID, A

Gui, AA: Destroy

WinActivate, ahk_id %lenelWinId%

Send,^{F11}
Send,^{Delete}
Send,{Enter 2}
Send,{Down}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;--------------------------------------------------------------------------------------- Cancel button

Cancel:

WinGetPos, acknowledgeX, acknowledgeY

Gui, AA: Destroy

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;--------------------------------------------------------------------------------------- Emergency exit

#if

^!Esc::
Gui, AA: Destroy

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

ExitApp

;--------------------------------------------------------------------------------------- Restart Script

#if

~Esc::

Gui, AA: Destroy

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

Exit:
WinGetPos, acstkX, acstkY,,,ACS Toolkit
Gui, Toolkit: Hide

;---------------------------------------------------------------------------------------- Loading Spinner

UpdateThing:
Set += 1

If Set=1
{
GuiControl, AA:, LoadingThing,◜
}
If Set=2
{
GuiControl, AA:, LoadingThing,◝
}
If Set=3
{
GuiControl, AA:, LoadingThing,◞
}
If Set=4
{
GuiControl, AA:, LoadingThing,◟
Set =0
}