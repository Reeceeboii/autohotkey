#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; To enable this script across reboots, a shortcut to it needs to be placed inside the startup folder
; (win + r "shell:startup"). Place the original script file somewhere permanent such as home directory

; Show a Windows notification when script first loads
TrayTip, %A_ScriptName%, Script loaded successfully from:`n%A_ScriptDir%, ,

; Windows Key + numpad 0 reloads script - useful during development
#Numpad0::
Reload
return

; Check if PowerToys Run is set up and running on the machine.
; This function can be used before calling any PowerToys run keybinds.
PowerToysRunExists(){
  Process, Exist , PowerToys.PowerLauncher.exe
  return ErrorLevel
}

; Displays a message stating that PowerToys Run is NOT set up and running on the machine.
PowerToysNotRunningError(){
  MsgBox, PowerToys Run is not currently running on this machine
}

; Ctrl + Shift + T
;   Opens Windows Terminal.
;   If script is running as admin (it should be) - this boots as admin too.
^+t:: Run wt.exe

; Windows Key + / 
;   Opens PowerToys Run. This is a wrapper around the normal alt + space shortcut.
;   This shortcut could be set from inside PowerToys itself, but since I'm using AHC for
;   shortcuts, I am better off centralising it here.
#/::
if(PowerToysRunExists()){
  Send, !{space}
} else {
  PowerToysNotRunningError()
}
return

; Windows Key + Right Shift 
;   Search open instances via PowerToys Run.
;   Useful for switching Window focus without the mouse when tiling etc...
#RShift::
if(PowerToysRunExists()){
  Send, !{space}<{space}
} else {
  PowerToysNotRunningError()
}
return