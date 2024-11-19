#SingleInstance force

;---------------------------------------------------------------------------------------- Presets

SetKeyDelay, 50
FormatTime, Date,, MM/dd/yyyy
FormatTime, Time,, HHmm
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
Gui, Add, Text,x10 y7, Responder
Gui, Add, DropDownList, W137 vResponder, Alarm Responder||Fixed Post|Security Manager|IT Representative|ACS Operator|Other
Gui, Add, Text,, Alarm Cause
Gui, Add, DropDownList, W137 vCause, Improper Device Use||Device Malfunction|Planned Work|Unplanned Work|Policy Violation|Triage|Other
Gui, Add, Checkbox,  yp+30 w13 h13  vPriority, Priority Alarm
Gui, Add, Text, yp x27, Priority Alarm
Gui, Add, Checkbox, x10 yp+20 w13 h13 vDay0, Day 0
Gui, Add, Text, yp x27, Day 0
Gui, Add, Checkbox, x10 yp+20 w13 h13 vSLA, SLA
Gui, Add, Text, yp x27, SLA
Gui, Add, Button, x10 yp+20 Default gContinue, Acknowledge
Gui, Add, Button, yp x100, Cancel
GuiControl, focus, Acknowledge
Gui, Show, x%acknowledgeX% y%acknowledgeY% , Alarm Acknowledger
WinGetPos, acknowledgeX, acknowledgeY,,,Alarm Acknowledger

return

;---------------------------------------------------------------------------------------- SLA GUI

Continue:

WinGetPos, acknowledgeX, acknowledgeY,,,Alarm Acknowledger

ReloadSLAInformation:

Gui, submit
Gui, destroy

If (SLA = 1)
{
Gui, +alwaysontop -SysMenu
Gui, Add, Text, x10 y10, Ownership
Gui, Add, GroupBox, x10 y20 w85 h100, 
Gui, Add, Checkbox, w13 h13 xp+10 yp+17 vOwnershipBAC, BAC
Gui, Add, Text, yp x37, BAC
Gui, Add, Checkbox, x20 yp+20 w13 h13 vOwnershipSystem, System
Gui, Add, Text, yp x37, System
Gui, Add, Checkbox, x20 yp+20 w13 h13 vOwnershipSite, Site
Gui, Add, Text, yp x37, Site
Gui, Add, Text, x100 y10, Type
Gui, Add, GroupBox, x100 y20 w85 h100, 
Gui, Add, Checkbox, w13 h13 xp+10 yp+17 vInProgressSLA, In-Prog
Gui, Add, Text, yp xp+17, In-Prog
Gui, Add, Checkbox, w13 h13 yp+20 xp-17 vVRCSLA, VRC
Gui, Add, Text, yp xp+17, VRC
Gui, Add, Checkbox, w13 h13 yp+20 xp-17 vOversightSLA, Oversight
Gui, Add, Text, yp xp+17, Oversight
Gui, Add, Checkbox, w13 h13 yp+20 xp-17 vResponseSLA, Response
Gui, Add, Text, yp xp+17, Response
Gui, Add, Button, x10 y130 Default gContinue2, Acknowledge
Gui, Add, Button, yp x95, Cancel
GuiControl, focus, Acknowledge
Gui, Show, x%acknowledgeX% y%acknowledgeY%, SLA Information
WinGetPos, acknowledgeX, acknowledgeY,,,SLA Information
Return
}

Continue2:

Gui, submit
Gui, destroy

;---------------------------------------------------------------------------------------- SLA Failure Required Boxes

If (OwnershipBAC = 0 and OwnershipSystem = 0 and OwnershipSite = 0 and VRCSLA = 0 and OversightSLA = 0 and ResponseSLA = 0 and InProgressSLA = 0)
{
MsgBox,48,Missing Information,-  Ownership `n-  Type
Gosub ReloadSLAInformation
return
}
Else If (OwnershipBAC = 0 and OwnershipSystem = 0 and OwnershipSite = 0)
{
MsgBox,48,Missing Information,-  Ownership
Gosub ReloadSLAInformation
return
}
Else If (VRCSLA = 0 and OversightSLA = 0 and ResponseSLA = 0 and InProgressSLA = 0)
{
MsgBox,48,Missing Information,-  Type
Gosub ReloadSLAInformation
return
}

;---------------------------------------------------------------------------------------- Variable Clearing GUI


ReloadVariableClearingGUI:

If (Responder = "Other" or Cause = "Other" or Cause = "Device Malfunction" or (Cause = "Planned Work" and SLA = 1) or Cause = "Unplanned Work" or Cause = "Triage")
{
Gui, +alwaysontop -SysMenu
Gui, Add, Edit, h0 w0 x10 y0, GUIControllPosition

If (Responder = "Other")
{
Gui, Add, Text, BackgroundTrans, Responder:
Gui, Add, Edit, w130 vResponder
}

If (Cause = "Other")
{
Gui, Add, Text, BackgroundTrans, Cause:
Gui, Add, Edit, w130 vCause
GuiControl, focus, Cause
}

If (Cause = "Device Malfunction")
{
Gui, Add, Text,BackgroundTrans, Device Reference#:
Gui, Add, DropDownList, vDeviceMalfuncitonType W55, TT||MCM|SIM|D3
Gui, Add, Edit, w130 vDeviceTT
GuiControl, focus, DeviceTT
}

If (Cause = "Planned Work" and SLA = 1)
{
Gui, Add, Text,BackgroundTrans, Work Reference#:
Gui, Add, DropDownList, vPWorkType W55, TT||MCM|SIM|D3
Gui, Add, Edit, w130 vPWorkTT
GuiControl, focus, PWorkTT
}

If (Cause = "Unplanned Work")
{
Gui, Add, Text,BackgroundTrans, Work Reference#:
Gui, Add, DropDownList, vUPWorkType W55, TT||MCM|SIM|D3
Gui, Add, Edit, w130 vUPWorkTT
GuiControl, focus, UPWorkTT
}

If (Cause = "Triage")
{
Gui, Add, Text,BackgroundTrans, D3#:
Gui, Add, Edit, w130 vTriageD3Number
GuiControl, focus, TriageD3Number
}

Gui, Add, Button, Default gContinue3, Acknowledge
Gui, Add, Button, yp x95, Cancel

Gui, Show, x%acknowledgeX% y%acknowledgeY%, Information

If (Responder = "Other")
{
GuiControl, focus, Responder
}

return
}

Continue3:

WinGetPos, acknowledgeX, acknowledgeY,,, Information

Gui, submit
Gui, destroy

;---------------------------------------------------------------------------------------- Variable Clearing GUI Required Boxes

If (Responder = "" and Cause = "")
{
MsgBox,48,Missing Information,-  Responder Type`n-  Cause
Sleep, 50
Responder = Other
Cause = Other
Gosub, ReloadVariableClearingGUI
return
}

If (Responder = "")
{
MsgBox,48,Missing Information,-  Responder Type
Responder = Other
Gosub, ReloadVariableClearingGUI
return
}

If (Cause = "")
{
MsgBox,48,Missing Information,-  Cause
Cause = Other
Gosub, ReloadVariableClearingGUI
return
}

If (Cause = "Device Malfunction" and DeviceTT = "")
{
MsgBox,48,Missing Information,-  Device %DeviceMalfuncitonType%#
Gosub, ReloadVariableClearingGUI
return
}

If (Cause = "Planned Work" and PWorkTT = "")
{
MsgBox,48,Missing Information,-  Work %PWorkType%#
Gosub, ReloadVariableClearingGUI
return
}

If (Cause = "Unplanned Work" and UPWorkTT = "")
{
MsgBox,48,Missing Information,-  Work %UPWorkType%#
Gosub, ReloadVariableClearingGUI
return
}

If (Cause = "Triage" and TriageD3Number = "")
{
MsgBox,48,Missing Information,-  Triage D3#
Gosub, ReloadVariableClearingGUI
return
}

;---------------------------------------------------------------------------------------- Clearing Logic

If (Responder = ACS Operator)
{
Responder =%A_UserName%
ROS =CCTV Review;
}
Else
{
ROS =ROS;
}

If (Day0 = 1)
{
Day0 =; Day 0
}
Else
{
Day0 =
}

If (Priority = 1)
{
PriorityText =; Responder has inspected the device; The responder stated they scanned their badge at the security device
}
else
{
PriorityText =
}

If (Cause = "Device Malfunction")
{
DTTText =; Device
DTTColon =;
}
else
{
DTTText =
DTTColon =
}

If (Cause = "Planned Work" and SLA = 1)
{
PWTTText =; Reference
PWColon =:
}
else
{
PWTTText =
PWColon =
PWTTText =
PWorkType =
PWorkTT =
PWSemiColon =
}

If (Cause = "Unplanned Work")
{
UPWTTText =; Reference
UPWColon =:
}
else
{
UPWTTText =
UPWColon =
UPWTTText =
UPWorkType =
UPWorkTT =
}

If (Cause = "Triage")
{
TriageText =; D3:
}
Else
{
TriageText =
TriageD3Number =
}


IF (Priority = 1 and SLA = 1)
{
SLAType =; Priority SLA
Ownership =; Ownership:
Type =; Type:
}
Else If (Priority = 0 and SLA = 1)
{
SLAType =; SLA
Ownership =; Ownership:
Type =; Type:
}
Else
{
SLAType =
Ownership =
Type =
}

If (OwnershipBAC = 1)
{
OwnershipBAC = BAC
}
else
{
OwnershipBAC =
}

If (OwnershipSystem = 1)
{
OwnershipSystem = System
}
else
{
OwnershipSystem =
}

If (OwnershipSite = 1)
{
OwnershipSite = Site
}
else
{
OwnershipSite =
}

If  ((OwnershipBAC = "BAC" and OwnershipSystem = "System") or (OwnershipBAC = "BAC" and OwnershipSite = "Site"))
{
OwnershipBACSlash =/
}
Else
{
OwnershipBACSlash =
}

If (OwnershipSite = "Site" and OwnershipSystem = "System")
{
OwnershipSystemSlash =/
}
else
{
OwnershipSystemSlash =
}

If (InProgressSLA = 1)
{
InProgressSLA =In-Progress
}
else
{
InProgressSLA =
}

If (VRCSLA = 1)
{
VRCSLA =VRC
}
else
{
VRCSLA =
}

If (OversightSLA = 1)
{
OversightSLA =Oversight
}
else
{
OversightSLA =
}

If (ResponseSLA = 1)
{
ResponseSLA =Response
}
else
{
ResponseSLA =
}

If ((InProgressSLA = "In-Progress" and VRCSLA = "VRC") or (InProgressSLA = "In-Progress" and OversightSLA = "Oversight") or (InProgressSLA = "In-Progress" and ResponseSLA = "Response"))
{
InProgressSLASlash =/
}
Else
{
InProgressSLASlash =
}

If ((VRCSLA = "VRC" and OversightSLA = "Oversight") or (VRCSLA = "VRC" and ResponseSLA = "Response"))
{
VRCSLASlash =/
}
Else
{
VRCSLASlash =
}

If (OversightSLA = "Oversight" and ResponseSLA = "Response")
{
OversightSLASlash =/
}
Else
{
OversightSLASlash =
}

Clipboard =
(
%ROS% %Responder%; %Cause%%Day1%%DTTText%%DeviceMalfuncitonType%%DTTColon%%DeviceTT%%PWTTText%%PWorkType%%PWColon%%PWorkTT%%UPWTTText%%UPWorkType%%UPWColon%%UPWorkTT%%TriageText%%TriageD3Number%%SLAType%%Ownership%%OwnershipBAC%%OwnershipBACSlash%%OwnershipSystem%%OwnershipSystemSlash%%OwnershipSite%%Type%%InProgressSLA%%InProgressSLASlash%%VRCSLA%%VRCSLASlash%%OversightSLA%%OversightSLASlash%%ResponseSLA%%PriorityText%
)

;---------------------------------------------------------------------------------------- Lenel Interaction


IfWinNotActive, ahk_group Lenel
{
WinActivate, ahk_group Lenel
}

WinWait, ahk_group Lenel,,1.5
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

Send ^v

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;---------------------------------------------------------------------------------------- Quck Clear Gui

^1::
^Numpad1::

Gui, Destroy
Gui, +alwaysontop -SysMenu
Gui, Add, Button, Default W85 x10 y10, Construction
Gui, Add, Button, W85, NVR
Gui, Add, Button, gUCTCGUI W85, UCTC
Gui, Add, Button, W85, Cancel
Gui, Show, x%acknowledgeX% y%acknowledgeY%, Quick Clear

Return

;--------------------------------------------------------------------------------------- UC Logic

Construction:

Gui, Submit
Gui, Destroy

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

Send ^v

Send {Enter}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;--------------------------------------------------------------------------------------- Auto SHM TT Logic

NVR:

Gui, Submit
Gui, Destroy

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

Send ^v

Send {Enter}

Send,{LWin up}{RWin up}{Control up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}

return

;---------------------------------------------------------------------------------------- UCTC Logic

UCTCGUI:

Gui, Submit
Gui, Destroy
Gui, +alwaysontop -SysMenu
Gui, Add, DropDownList, x10 y10 vUCTCWorkType W55, TT||MCM|SIM|D3
Gui, Add, Edit, w130 vUCTCReference
Gui, Add, Button, Default gUCTCLogic, Acknowledge
Gui, Add, Button, yp x95, Cancel
GuiControl, Focus, UCTCReference
Gui, Show, x%acknowledgeX% y%acknowledgeY%, Update
Return

UCTCLogic:

Gui Submit

Clipboard =
(
UCTC; %UCTCWorkType%:%UCTCReference%; %Date%; %Time%
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

Send ^v

Send {Enter}

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
