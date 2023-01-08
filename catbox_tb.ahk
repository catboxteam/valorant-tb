init:
#NoEnv
#SingleInstance, Force
#Persistent
#InstallKeybdHook
#UseHook
#KeyHistory, 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127

if (FileExist("cfg.ini")) 
{
}
Else
{
IniWrite, 0xA5A528, cfg.ini, main, EMCol
IniWrite, 20, cfg.ini, main, ColVn
}

IniRead, EMCol, cfg.ini, main, EMCol
IniRead, ColVn, cfg.ini, main, ColVn


toggle = 1
toggle2 = 1


AntiShakeX := (A_ScreenHeight // 160)
AntiShakeY := (A_ScreenHeight // 128)
ZeroX := (A_ScreenWidth // 2)
ZeroY := (A_ScreenHeight // 2) 
CFovX := (A_ScreenWidth // 40)  ;configure for FOV up = smaller lower= bigger current boxes right fov
CFovY := (A_ScreenHeight // 64)
ScanL := ZeroX - CFovX
ScanT := ZeroY
ScanR := ZeroX + CFovX
ScanB := ZeroY + CFovY
NearAimScanL := ZeroX - AntiShakeX
NearAimScanT := ZeroY - AntiShakeY
NearAimScanR := ZeroX + AntiShakeX
NearAimScanB := ZeroY + AntiShakeY


Gui Add, Text, cRed, - READ -
Gui Add, Text, cBlack, In the case of your account being banned, we will not be held liable.
Gui Add, Text, cBlack, You acknowledge and agree that we are not liable for your account being banned.
Gui Add, Text, cRed, - HOW 2 USE -
Gui Add, Text, cBlack, Before using, set the Display Mode to Fullscreen.
Gui Add, Text, cBlack, You can also change the colour of each enemy, but it will work better based on yellow (Protanopia)
Gui Add, Text, cBlack, F2, to activate, hold MOUSE4 to shoot. (Side buttons)
Gui Add, Text, cRed, catbox.pw | for educational purposes.
Gui show

~F2::
SoundBeep, 523, 500

SetKeyDelay,-1, 1
SetControlDelay, -1
SetMouseDelay, -1
SendMode, InputThenPlay
SetBatchLines,-1
SetWinDelay,-1
ListLines, Off
CoordMode, Pixel, Screen, RGB
CoordMode, Mouse, Screen
PID := DllCall("GetCurrentProcessId")
Process, Priority, %PID%, High

Loop{

PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB	

		if GetKeyState("XButton2"){
		if (ErrorLevel=0) {
		PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB
		loop , 1{
		send {Lbutton down}
		sleep, 1
		send {lbutton up}
						}
					}
				}
						
		if GetKeyState("Xbutton1") {
		if (!ErrorLevel=0) {
		loop, 10 {
			PixelSearch, AimPixelX, AimPixelY, ScanL, ScanT, ScanR, ScanB, EMCol, ColVn, Fast RGB
			AimX := AimPixelX - ZeroX
			AimY := AimPixelY - ZeroY
			DirX := -1
			DirY := -1
			If ( AimX > 0 ) {
				DirX := 1
			}
			If ( AimY > 0 ) {
				DirY := 1
			}
			AimOffsetX := AimX * DirX
			AimOffsetY := AimY * DirY
			MoveX := Floor(( AimOffsetX ** ( 1 / 2 ))) * DirX
			MoveY := Floor(( AimOffsetY ** ( 1 / 2 ))) * DirY
			DllCall("mouse_event", uint, 1, int, MoveX * 2, int, MoveY, uint, 0, int, 0) ;turing mouse to color were it says * is the speed of the aimbot turn up for unhuman reactions lower for human
				}
			}
		}
	}


return:
goto, init

Home::
if toggle2 = 0
{
	toggle2 = 1
	Gui Hide
}
Else
{
	toggle2 = 0
	Gui Show
}


action1:
if toggle = 0
{
	toggle = 1
	Gui 2: Hide
}
Else
{
	toggle = 0
	Gui 2: Show
}
return

end::
exitapp
return

Quitter:
ExitApp

GuiClose:
ExitApp