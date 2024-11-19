#SingleInstance force

;---------------------------------------------------------------------------------------- Presets

SetKeyDelay, 50

;---------------------------------------------------------------------------------------- NumLock On

SetNumLockState, AlwaysOn

;---------------------------------------------------------------------------------------- Groups

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

;---------------------------------------------------------------------------------------- Acknowledge GUI

acknowledgeX = 816
acknowledgeY = 437

^0::
^Numpad0::

Gui, Destroy

Gui, +alwaysontop -SysMenu
Gui, Add, Text,x10 y10, Responder Type
Gui, Add, DropDownList, W130 vResponderType, Alarm Responder||Fixed Post|Security Manager|IT Representative|ACS Operator|Other
Gui, Add, Text,, Alarm Cause
Gui, Add, DropDownList, W130 vCause, Improper Device Use||Policy Violation|Evacuation|Device Malfunction|Planned Work
Gui, Add, Checkbox, vCCTV, CCTV Clear
Gui, Add, Checkbox, vConfirmed, Device Confirmed
Gui, Add, Checkbox, vScanned, Badge Scanned
Gui, Add, Checkbox, vTier, Zone 5 / Priority SLA
Gui, Add, Button, Default, Acknowledge
Gui, Add, Button,, Cancel
Gui, Add, Button,x110 y208, !
Gui, Add, Button,x130 y208, ?
Gui, Show, x%acknowledgeX% y%acknowledgeY%, Alarm Acknowledger

return

;---------------------------------------------------------------------------------------- Responder Type / TT's GUI

ButtonAcknowledge:

WinGetPos, acknowledgeX, acknowledgeY,,,Alarm Acknowledger

Gui, submit
Gui, destroy

If (ResponderType = "Other" or Tier = 1 or Cause = "Device Malfunction")
{

Gui, +alwaysontop -SysMenu

If ResponderType = Other
{
Gui, Add, Text,, Responder Type
Gui, Add, Edit, vResponderType
}

If Tier = 1
{
Gui, Add, Text,, SLA TT #
Gui, Add, Edit, vSLATT
STTText=; SLA TT #:
}
else
{
vSLATT=
}

If Cause = Device Malfunction
{
Gui, Add, Text,, Device TT #
Gui, Add, Edit, vDeviceTT
DTTText=; Device TT #:
}
else
{
DeviceTT=
DTTText=
}

Gui, Add, Button, Default gAcknowledge, Acknowledge
Gui, Add, Button,, Cancel
Gui, Show,, Information

return
}
else
{
DTTText=
DeviceTT=
STTText=
SLATT=
}

Acknowledge:

Gui, submit
Gui, destroy

if CCTV = 0
	CCTV = In-Person Response
else
	CCTV = CCTV Review

If Confirmed = 1
  Confirmed =; Responder has inspected the device
else
Confirmed =

If Scanned = 1
	Scanned =; The responder stated they scanned their badge at the security device
else
Scanned =

If ResponderType = ACS Operator
ResponderType = %A_UserName%

Clipboard =
(
ROS; %ResponderType%; %CCTV%; %Cause%%Confirmed%%DTTText%%DeviceTT%%STTText%%SLATT%%Scanned%
)

IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

WinWait, ahk_group Lenel,,1.5
if ErrorLevel
{
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
    return
}

Send,^{F12}
WinWait, ahk_group FastGroup,,1.5
if ErrorLevel
{
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
    return
}
Send, {Enter}
WinWait, ahk_group Acknowledgeselectedalarms,,1.5
if ErrorLevel
{
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
    return
}

SendInput, {RAW}%Clipboard%

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;---------------------------------------------------------------------------------------- Update Alarms GUI

^Numpad1::
^1::

Gui, Destroy

Gui, +alwaysontop -SysMenu
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
Gui, Add, Button, W102, Requested &Scan
Gui, Add, Button, W102, &ROS
Gui, Add, Button, W102, Cancel
Gui, Tab, Custom
Gui, Add, Edit, R7.70 W100 vCustomUpdate
Gui, Add, Button,, Update
Gui, Add, Button,, Cancel
Gui, Show, x%acknowledgeX% y%acknowledgeY%, Update

return

;--------------------------------------------------------------------------------------- Updates

Button1:
Clipboard = SIP contact 1
gosub Continue
return
Button2:
Clipboard = SIP contact 2
gosub Continue
return
Button3:
Clipboard = SIP contact 3
gosub Continue
return
Button4:
Clipboard = SIP contact 4
gosub Continue
return
Button5:
Clipboard = SIP contact 5
gosub Continue
return
Button6:
Clipboard = SIP contact 6
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
ButtonRequestedScan:
Clipboard = The responder was directed to scan their badge at the security device
gosub Continue
return
ButtonROS:
Clipboard = ROS
gosub Continue
return
ButtonUpdate:
Gui, Submit, NoHide
Clipboard = %CustomUpdate%
gosub Continue
return

Continue:

WinGetPos, acknowledgeX, acknowledgeY,,,Update

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
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
    return
}

SendInput, {Raw}%Clipboard%

Send, {Tab 4}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;---------------------------------------------------------------------------------------- In Progress

^Up::
^6::

IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

Send ^{F12}

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

Send ^{F12}

WinWait, ahk_group FastGroup,,1.5
if ErrorLevel
{
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
    return
}

Send a

WinWait, ahk_group Acknowledgeselectedalarms,,1.5
if ErrorLevel
{
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
    return
}

SendInput, {Raw}%Clipboard%

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

Send ^{F12}

WinWait, ahk_group FastGroup,,1.5
if ErrorLevel
{
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
    return
}

Send a

WinWait, ahk_group Acknowledgeselectedalarms,,1.5
if ErrorLevel
{
Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}
	Reload
    return
}

SendInput, {Raw}%Clipboard%

Send {Enter}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return
;--------------------------------------------------------------------------------------- Issue Reporting Gui

Button!:
Gui, Destroy

Gui, +alwaysontop
Gui, -SysMenu

Gui, Add, Text,, Describe the issue you're experiencing:
Gui, Add, Edit, vIssue R7.70 W300 H300

Gui, Add, Button,, Send
Gui, Add, Button,, Cancel

Gui, Show, x%acknowledgeX% y%acknowledgeY%, Issue Reporting

Return

;--------------------------------------------------------------------------------------- Issue Reporting Logic

ButtonSend:

Gui, Submit

FinalLogin = Login: %A_UserName%
FinalIssue = Issue: %Issue%

guivlist := [Issue]

for i,a in guivlist
{
    If (!a)
    {
        MsgBox, 262144,,  Do not leave any fields empty!
        return
    }
}

Gui, Destroy

Recipient := "boltm@amazon.com"
RecipientCC := "bryj@amazon.com; bsteenro@amazon.com"
Subject :=  "Alarm Acknowledger Issue"
Body =
(Join
<a> %FinalLogin% </a><br>
<a> %FinalIssue% </a><br>
)

olApp := ComObjCreate("Outlook.Application")
olEmail := olApp.CreateItem(0)	; olMailItem := 0
olNameSpace := olApp.GetNamespace("MAPI")
olEmail.SendUsingAccount := olNameSpace.Accounts.Item("%A_UserName%@amazon.com")
olEmail.BodyFormat := 2	; olFormatHTML := 2
olEmail.Subject := Subject
olEmail.HTMLBody := Body
olRecipient := olEmail.Recipients.Add(Recipient)
olRecipient.Type := 1 ; To: olCC: = 2 BCC: = 3
olRecipient := olEmail.Recipients.Add(RecipientCC)
olRecipient.Type := 2 ; To: olCC: = 2 BCC: = 3

olEmail.Display

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
Gui, Add, Text,X30 Y190,- CTRL + 0: Acknowledge Selected Alarm(s)
Gui, Add, Text,X30 Y205,- CTRL + 1: Update Selected Alarm
Gui, Add, Text,X30 Y220,- CTRL + /: Clear Under Construction (UC) Alarm(s)
Gui, Add, Text,X30 Y235,- CTRL + * or 8: Clear NVR Coms Loss Alarm(s)
Gui, Add, Text,X30 Y250,- CTRL + (Del): Delete Cleared alarm(s)

Gui, Font, underline
Gui, Add, Text,X10 Y280,Notes:

Gui, Font, norm
Gui, Add, Text,X30 Y295,- Alarm Acknowledger can be utilized on a desktop PC utilizing the numpad and a laptop utilizing the standard keyboard.
Gui, Add, Text,X30 Y310,- If Alarm Acknowledger is used outside of Lenel it will automatically re-select your previously selected Lenel segment.
Gui, Add, Text,X30 Y325,- If you check "Zone 5 / Priority SLA" you will be required to enter a trouble ticket number.
Gui, Add, Text,X30 Y340,- If you select "Responder Type" "Other" you will be required to fill out the responder type.
Gui, Add, Text,X30 Y355,- If you are experiencing issues with Alarm Acknowledger click the "!" button to submit your issue.

Gui, Font, underline
Gui, Add, Text,X10 Y390,Known Issues:

Gui, Font, norm
Gui, Add, Text,X30 Y405,- Occasionally Lenel will freeze on the "Acknowledge Selected Alarms" screen. This issue has been fixed.
Gui, Add, Text,X30 Y420,- Occasionally Alarm Acknowledger won't let you deselect a Lenel window. This is a known issue with Lenel and unrelated to the script.
Gui, Add, Text,X30 Y435,- Alarm Acknowledger does not work when Lenel is full screen.
Gui, Add, Text,X30 Y450,- If you press CTRL + 0 and 1 on the exact same frame the GUI's will combine together.
Gui, Add, Text,X30 Y465,

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
Send {Down}
Send {Up}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;--------------------------------------------------------------------------------------- Cancel button

ButtonCancel:

WinGetPos, acknowledgeX, acknowledgeY

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
