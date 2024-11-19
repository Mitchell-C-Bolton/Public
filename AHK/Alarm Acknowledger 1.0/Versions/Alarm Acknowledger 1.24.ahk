
#SingleInstance force
DetectHiddenWindows, On
#NoEnv

;---------------------------------------------------------------------------------------- Presets

SetKeyDelay, 50

;---------------------------------------------------------------------------------------- NumLock On

SetNumLockState, AlwaysOn

;---------------------------------------------------------------------------------------- Groups

GroupAdd, Lenel, ahk_class RAIL_WINDOW
GroupAdd, Lenel, ahk_class TscShellContainerClass

GroupAdd, AlarmAcknowledgment, Alarm Acknowledgment (BAC-RDS.CORP.AMAZON.COM)
GroupAdd, FastGroup, Fast/Group Acknowledge (BAC-RDS.CORP.AMAZON.COM)
GroupAdd, Acknowledgeselectedalarms, Acknowledge selected alarms (BAC-RDS.CORP.AMAZON.COM)

GroupAdd, AlarmAcknowledgment, Alarm Acknowledgment (GS-TS-BR-NA.CORP.AMAZON.COM)
GroupAdd, FastGroup, Fast/Group Acknowledge (GS-TS-BR-NA.CORP.AMAZON.COM)
GroupAdd, Acknowledgeselectedalarms, Acknowledge selected alarms (GS-TS-BR-NA.CORP.AMAZON.COM)

GroupAdd, AlarmAcknowledgment, Alarm Acknowledgment (gs-app-ue1d022p.ant.amazon.com)
GroupAdd, FastGroup, Fast/Group Acknowledge (gs-app-ue1d022p.ant.amazon.com)
GroupAdd, Acknowledgeselectedalarms, Acknowledge selected alarms (gs-app-ue1d022p.ant.amazon.com)

GroupAdd, AlarmAcknowledgment, ahk_class TscShellContainerClass
GroupAdd, FastGroup, ahk_class TscShellContainerClass
GroupAdd, Acknowledgeselectedalarms, ahk_class TscShellContainerClass

GroupAdd, AnnoyingBoxes, Alarm Monitoring (BAC-RDS.CORP.AMAZON.COM)
GroupAdd, AnnoyingBoxes, Alarm Monitoring (GS-TS-BR-NA.CORP.AMAZON.COM)
GroupAdd, AnnoyingBoxes, Alarm Monitoring (gs-app-ue1d022p.ant.amazon.com)

;---------------------------------------------------------------------------------------- Annoying boxes

Loop
{
IfWinExist, ahk_group AnnoyingBoxes
{
WinActivate, ahk_group AnnoyingBoxes
WinKill,
Send {tab 2}{BS}{esc}{enter}
}
}

;---------------------------------------------------------------------------------------- Acknowledge GUI

^0::
^Numpad0::

Gui, Destroy

Gui, +alwaysontop
Gui, -SysMenu
Gui, Add, Text,x10 y10, Responder Type
Gui, Add, DropDownList, W130 vResponderType, Alarm Responder||Fixed Post|Security Manager|IT Representative|ACS Operator|Other
Gui, Add, Text,, Alarm Cause
Gui, Add, DropDownList, W130 vCause, Improper Device Use||Policy Violation|Evacuation|Device Malfunction|Planned Work
Gui, Add, Checkbox, vCCTV, CCTV Clear
Gui, Add, Checkbox, vTier, Zone 5 / Priority SLA
Gui, Add, Button, Default, Acknowledge
Gui, Add, Button,, Cancel
Gui, Add, Button,x110 y170, !
Gui, Add, Button,x130 y170, ?
Gui, Show,, Alarm Acknowledger

return

;---------------------------------------------------------------------------------------- Acknowledge Button

ButtonAcknowledge:

GUI, Submit

If ResponderType = Other
{
InputBox,ResponderType, Responder Type,,,170,100
if ErrorLevel = 1
{
return
}
}

If Tier = 1
{
Tier = SLA Defect TT #
InputBox,TTNum, SLA TT Number,,,170,100
if ErrorLevel = 1
{
return
}
TTNum = %TTNum%;
}

else if Tier = 0
{
Tier =
TTNum =
}

if CCTV = 0
	CCTV = In-Person Response
else
	CCTV = CCTV Review

Clipboard =
(
%ResponderType%; %CCTV%; %Cause%; %Tier%%TTNum%
)

IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

WinWait, ahk_group Lenel,,1.5
if ErrorLevel
{
	return
}

Send ^{F12}
WinWait, ahk_group FastGroup,,1.5
if ErrorLevel
{
	return
}

Send a

WinWait, ahk_group AlarmAcknowledgment,,1.5
if ErrorLevel
{
	return
}

Send ^v
Send {Enter}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return


;---------------------------------------------------------------------------------------- Update Alarms GUI

^Numpad1::
^1::

Gui, Destroy

Gui, +alwaysontop
Gui, -SysMenu
Gui, Add, Tab3,, General|Custom
Gui, Add, GroupBox, w100 h75, Site Contacts
Gui, Add, Button, X30 Y50 W25, &1
Gui, Add, Button, X60 Y50 W25, &2
Gui, Add, Button, X90 Y50 W25, &3
Gui, Add, Button, X30 Y77 W25, &4
Gui, Add, Button, X60 Y77 W25, &5
Gui, Add, Button, X90 Y77 W25, &6
Gui, Add, Button, X21 Y115 W102, &Dispatched
Gui, Add, Button, W102, &VRC
Gui, Add, Button, W102, &SSS
Gui, Add, Button, W102, Cancel
Gui, Tab, Custom
Gui, Add, Edit, R7.70 W100 vCustomUpdate
Gui, Add, Button,, Update
Gui, Add, Button,, Cancel
Gui, Show,, Update

return

;--------------------------------------------------------------------------------------- Updates

Button1:
Clipboard = SITE INFORMATION CONTACT 1
gosub Continue
return
Button2:
Clipboard = SITE INFORMATION CONTACT 2
gosub Continue
return
Button3:
Clipboard = SITE INFORMATION CONTACT 3
gosub Continue
return
Button4:
Clipboard = SITE INFORMATION CONTACT 4
gosub Continue
return
Button5:
Clipboard = SITE INFORMATION CONTACT 5
gosub Continue
return
Button6:
Clipboard = SITE INFORMATION CONTACT 6
gosub Continue
return
ButtonDispatched:
Clipboard = Alarm has been dispatched
gosub Continue
return
ButtonVRC:
Clipboard = VRC
gosub Continue
return
ButtonSSS:
Clipboard = Site safe and secure
gosub Continue
return
ButtonUpdate:
Gui, Submit
Clipboard = %CustomUpdate%
gosub Continue
return

Continue:

Gui, Submit
Gui, Destroy

IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

Send !e
Send a

WinWait, ahk_group AlarmAcknowledgment,,1.5
if ErrorLevel
{
	return
}

Send ^v
Send {tab 4}{Enter}
Send {esc}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return


;---------------------------------------------------------------------------------------- In Progress

^Up::
^6::

IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

Gui, Destroy

Send ^{F12}
WinWait, ahk_group FastGroup,,1.5
if ErrorLevel
{
	return
}

Send i

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;--------------------------------------------------------------------------------------- UC

^/::
^NumpadDiv::

Clipboard =
(
Under Construction
)

IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

WinWait, ahk_group Lenel,,1.5
if ErrorLevel
{
	return
}

Send ^{F12}
WinWait, ahk_group FastGroup,,1.5
if ErrorLevel
{
	return
}

Send a

WinWait, ahk_group AlarmAcknowledgment,,1.5
if ErrorLevel
{
	return
}

Send ^v
Send {Enter}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;--------------------------------------------------------------------------------------- Auto SHM TT

^8::
^NumpadMult::

Clipboard =
(
Auto System Health Ticket Generated
)

IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

WinWait, ahk_group Lenel,,1.5
if ErrorLevel
{
	return
}

Send ^{F12}
WinWait, ahk_group FastGroup,,1.5
if ErrorLevel
{
	return
}

Send a

WinWait, ahk_group AlarmAcknowledgment,,1.5
if ErrorLevel
{
	return
}

Send ^v
Send {Enter}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return
;--------------------------------------------------------------------------------------- IssueReporting Gui

Button!:
Gui, Destroy

Gui, +alwaysontop
Gui, -SysMenu

Gui, Add, Text,, Name: (First, Last)
Gui, Add, Edit, vName W100

Gui, Add, Text,, Describe the issue you're experiencing:
Gui, Add, Edit, vIssue R7.70 W300 H300

Gui, Add, Button,, Submit
Gui, Add, Button,, Cancel

Gui, Show,, Issue Reporting

Return

;--------------------------------------------------------------------------------------- IssueReporting Logic

ButtonSubmit:

Gui, Submit, NoHide

guivlist := [Name, Issue]

for i,a in guivlist
{
    If (!a)
    {
        MsgBox, 262144,,  Do not leave any fields empty!
        return
    }
}

Gui, Destroy

FileAppend, Name: %Name%`nIssue: %Issue%`n-------------------------------------------------------`n, \\ant\DEPT\ACS-back-up\Second-Shift\Alarm Acknowledger\ErrorLog.txt

return

;--------------------------------------------------------------------------------------- Help

Button?:

Gui, Destroy

Gui, +alwaysontop

Gui, Font, underline
Gui, Add, Text,X10 Y10, Overview:

Gui, Font, norm
Gui, Add, Text,X10 Y25,Alarm Acknowledger is a tool aimed at increasing the efficiency and accuracy of Amazon Corporate Security ACS operators in regards to alarm clearance.
Gui, Add, Text,X10 Y40,The goal of this tool is to provide five attributes:
Gui, Add, Text,X30 Y70,- Create a universally accepted method for acknowledging, in-progressing and updating alarms.
Gui, Add, Text,X30 Y85,- Simplify training for both new and experienced operators.
Gui, Add, Text,X30 Y100,- Reduce the time required to properly acknowledge, in-progress and update alarms.
Gui, Add, Text,X30 Y115,- Increase the accuracy of the information entered to acknowledge, in-progress and update alarms.
Gui, Add, Text,X30 Y130,- Increase the overall efficiency of ACS alarm processing capabilities.

Gui, Font, underline
Gui, Add, Text,X10 Y160,Hot Keys:

Gui, Font, norm
Gui, Add, Text,X30 Y175,- CTRL + (Up Arrow): In-Progress Selected Alarm(s)
Gui, Add, Text,X30 Y190,- CTRL + 0: Acknowledge Alarm
Gui, Add, Text,X30 Y205,- CTRL + /: Clear Under Construction (UC) Alarm
Gui, Add, Text,X30 Y220,- CTRL + * or 8: Clear NVR Coms Loss
Gui, Add, Text,X30 Y235,- CTRL + (Del): Delete Cleared alarms

Gui, Font, underline
Gui, Add, Text,X10 Y265,Notes:

Gui, Font, norm
Gui, Add, Text,X30 Y280,- Alarm Acknowledger can be utilized on a desktop PC utilizing the numpad and a laptop utilizing the standard keyboard.
Gui, Add, Text,X30 Y295,- If Alarm Acknowledger is used outside of Lenel it will automatically re-select your previously selected Lenel segment.
Gui, Add, Text,X30 Y310,- If you check "Zone 5 / Priority SLA" you will be required to enter a trouble ticket number.
Gui, Add, Text,X30 Y325,- If you select "Responder Type" "Other" you will be required to fill out the responder type.
Gui, Add, Text,X30 Y340,- If you are experiencing issues with Alarm Acknowledger click the "!" button to submit your issue.

Gui, Font, underline
Gui, Add, Text,X10 Y375,Known Issues:

Gui, Font, norm
Gui, Add, Text,X30 Y390,- Occasionally Lenel will freeze on the "Acknowledge Selected Alarms" screen. This is a known issue with Lenel and unrelated to the script.
Gui, Add, Text,X30 Y405,- Occasionally Alarm Acknowledger won't let you deselect a Lenel window. This is a known issue with Lenel and unrelated to the script.
Gui, Add, Text,X30 Y420,- Alarm Acknowledger does not work when Lenel is full screen.
Gui, Add, Text,X30 Y435,- If you press CTRL + 0 and 1 on the exact same frame the GUI's will combine together.
Gui, Add, Text,X30 Y450,

Gui, Show,, Help
Return



;--------------------------------------------------------------------------------------- Delete

^Delete::

Gui, Destroy

IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

Send ^{F11}
Send ^{Delete}
Send {Enter}
Send {Enter}
Send {Down}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;--------------------------------------------------------------------------------------- Cancel button

ButtonCancel:
Gui, Destroy

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;--------------------------------------------------------------------------------------- Emergency exit

^!Esc::
Gui, Destroy

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

ExitApp
;--------------------------------------------------------------------------------------- Restart Script

~Esc::
Gui, Destroy

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return