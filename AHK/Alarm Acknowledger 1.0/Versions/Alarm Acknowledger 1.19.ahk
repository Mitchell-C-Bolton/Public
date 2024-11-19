

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


;---------------------------------------------------------------------------------------- Acknowledge GUI


^0::
^Numpad0::

Gui, Destroy

Gui, +alwaysontop
Gui, -SysMenu
Gui, Add, Tab3,, General|Notes
Gui, Add, Text,, Cause of Alarm?
Gui, Add, DropDownList, W130 vCause, Unknown||Employee Movement|Vendor Movement|Visitor Movement|Code4|Device Malfunction|Air Pressure|See Notes
Gui, Add, Text,, Alarm Responder?
Gui, Add, Edit, W130 vAR,
Gui, Add, Text,, Trouble Ticket?
Gui, Add, Edit, W130 vTT, N/A
Gui, Add, Checkbox, vOfficer, Officer Posted
Gui, Add, Checkbox, vSLA, SLA Failure
Gui, Add, Button, Default, Acknowledge
Gui, Add, Button,, Cancel
Gui, Tab, Notes
Gui, Add, Edit, R12.45 W130 vNotes
Gui, Tab, Notes
Gui, Add, Button,, Acknowledge
Gui, Add, Button,, Cancel
Gui, Show,, Alarm Acknowledger

return


;---------------------------------------------------------------------------------------- Acknowledge Button


ButtonAcknowledge:

Guiclose:
GUI, Submit

If Officer = 0
	Officer = No
Else
	Officer = Yes

If SLA = 0
	SLA = No
Else
	SLA = Yes

If AR =
	AR = Unknown

If Notes =
	Notes = N/A

Clipboard =
(
`r
SSS`r
Cause of Alarm: %Cause% `r
Alarm Responder: %AR% `r
Trouble Ticket: %TT% `r
SLA Failure? %SLA% `r
Officer Posted? %Officer% `r
Notes: %Notes%
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

return


;---------------------------------------------------------------------------------------- Update Alarms GUI


^Numpad1::
^1::

Gui, Destroy

Gui, +alwaysontop
Gui, -SysMenu
Gui, Add, Tab3,, General|Custom
Gui, Add, GroupBox, w100 h75, Site Contacts
Gui, Add, Button, X30 Y50 W25 +Default, &1
Gui, Add, Button, X60 Y50 W25, &2
Gui, Add, Button, X90 Y50 W25, &3
Gui, Add, Button, X30 Y77 W25, &4
Gui, Add, Button, X60 Y77 W25, &5
Gui, Add, Button, X90 Y77 W25, &6
Gui, Add, Button, X21 Y115 W102, &Dispatched
Gui, Add, Button, W102, &SSS
Gui, Add, Button, W102, Cancel
Gui, Tab, Custom
Gui, Add, Edit, R7.70 W100 vUpdate
Gui, Add, Button,, Update
Gui, Add, Button,, Cancel
Gui, Show,, Update

return


;--------------------------------------------------------------------------------------- Update 1


Button1:

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

Clipboard =
(
SIC1 (SITE INFORMATION CONTACT 1)
)

Send ^v
Send {tab 4}{Enter}
Send {esc}

return


;--------------------------------------------------------------------------------------- Update 2


Button2:

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

Clipboard =
(
SIC1 (SITE INFORMATION CONTACT 2)
)

Send ^v
Send {tab 4}{Enter}
Send {esc}

return


;--------------------------------------------------------------------------------------- Update 3


Button3:

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

Clipboard =
(
SIC1 (SITE INFORMATION CONTACT 3)
)

Send ^v
Send {tab 4}{Enter}
Send {esc}

return


;--------------------------------------------------------------------------------------- Update 4


Button4:

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

Clipboard =
(
SIC1 (SITE INFORMATION CONTACT 4)
)

Send ^v
Send {tab 4}{Enter}
Send {esc}

return


;--------------------------------------------------------------------------------------- Update 5


Button5:

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

Clipboard =
(
SIC1 (SITE INFORMATION CONTACT 5)
)

Send ^v
Send {tab 4}{Enter}
Send {esc}

return


;--------------------------------------------------------------------------------------- Update 6


Button6:

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

Clipboard =
(
SIC1 (SITE INFORMATION CONTACT 6)
)

Send ^v
Send {tab 4}{Enter}
Send {esc}

return


;--------------------------------------------------------------------------------------- Update Dispatched


ButtonDispatched:

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

Clipboard =
(
Alarm Has Been Dispatched
)

Send ^v
Send {tab 4}{Enter}
Send {esc}

return


;--------------------------------------------------------------------------------------- Update SSS


ButtonSSS:

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

Clipboard =
(
Site Safe and Secure
)

Send ^v
Send {tab 4}{Enter}
Send {esc}

return


;--------------------------------------------------------------------------------------- Update Custom


ButtonUpdate:

GUI, Submit
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

Clipboard =
(
%Update%
)

Send ^v
Send {tab 4}{Enter}
Send {esc}

return

;---------------------------------------------------------------------------------------- In Progress


^Up::



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

return


;---------------------------------------------------------------------------------------- In Progress All


^.::
^NumpadDot::



IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

Gui, Destroy

Send ^{F11}
Sleep,10
Send ^{F12}
WinWait, ahk_group FastGroup,,1.5
if ErrorLevel
{
	return
}

Send i

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

return


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

return


;--------------------------------------------------------------------------------------- Cancel button


ButtonCancel:
Gui, Destroy
return


;--------------------------------------------------------------------------------------- Emergency exit


^!Esc::
Gui, Destroy
ExitApp


;--------------------------------------------------------------------------------------- Restart Script


~Esc::
Gui, Destroy
return
