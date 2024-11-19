#SingleInstance force
DetectHiddenWindows, On

PID:=DllCall("GetCurrentProcessId") 
for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where name = 'Autohotkey.exe' and processID  <> " PID )
   process, close, % process.ProcessId

Thing  =◟

SetTimer, UpdateThing, 75

Gui, +AlwaysOnTop +Disabled -SysMenu +Owner -Border
Gui, Font, bold
Gui, Add, Text, x30 y18, LOADING
Gui, Add, Text, VLoadingThing x55 y30, % Thing
Gui, Show, H50 W120,

FileCreateDir, C:\ProgramData\AlarmAcknowledger
SetWorkingDir, C:\ProgramData\AlarmAcknowledger

FileRemoveDir, Resources, 1

FileInstall, Resources.zip, %A_WorkingDir%\Resources.zip, 1

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

FileSetAttrib, +RAHS, C:\ProgramData\AlarmAcknowledger
FileSetAttrib, +RAHS, C:\ProgramData\AlarmAcknowledger\*.*
FileSetAttrib, +RAHS, C:\ProgramData\AlarmAcknowledger\Resources
FileSetAttrib, +RAHS, C:\ProgramData\AlarmAcknowledger\Resources\*.*

ifnotexist %programfiles%\AutoHotkey\AutoHotkey.exe
{
MsgBox, Please Install Auto Hot Keys (AHK).
exitApp
}

GUI, Destroy

Run, %A_WorkingDir%\Resources\AA.ahk

exitApp

UpdateThing:
Set += 1

If Set=1
{
GuiControl,, LoadingThing,◜
}
If Set=2
{
GuiControl,, LoadingThing,◝
}
If Set=3
{
GuiControl,, LoadingThing,◞
}
If Set=4
{
GuiControl,, LoadingThing,◟
Set =0
}
