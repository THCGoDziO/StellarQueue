#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2

MsgBox, Activate queue GUI - F2`nReload Script - F7`nQuit Script - Shift-Esc`n`nUse carefully when not afk`n`nBot relies on being on the main screen a lot`nand does not currently detect certain open in-game menus`nLoading screens (if it fires during the lag), resource details and the chat window can break the macro)`n`nSupported Emulator Resolution 1280x720 only, and edit line 10`nemulator := "mEmu" to your emulator name`n`nPress OK to start

; VARS

emulator := "MEmu" ; your emulator
SetMouseDelay, 200
i := 0 ;
hours := 0
minutes := 0
seconds := 0
botbusy := 0
queue := []
buildqueue := []
resqueue := []

#include lib\Vis2.ahk

CoordMode, Mouse, Relative ; set coords relative to the emu window
CoordMode, Pixel, Relative

IfWinNotExist, %emulator% 
{
MsgBox, %emulator% not running, script will now exit.`n`nMake sure you edited line 10 of the script to reflect the emulator you are using.
exitapp
}
WinActivate, %emulator%
WinWait,, %emulator%



SetTimer, helpclan, 1600 ; help clan timer
SetTimer, checkforlogout, 60000
return

; SCRIPTS

;F3:: ; test building
;buildqueue.Insert("0")
;buildqueue.Insert("6")
;buildqueue.Insert("1")
;gosub buildqueued
;return

helpclan:
if (botbusy = 0)
{
IfWinActive, %emulator% 
{
PixelGetColor,Color,168,594
;ToolTip, %Color%
if Color=0xF9F9F9
{
  MouseGetPos, mousex, mousey
  BlockInput, MouseMove
  MouseMove, 128, 590
  Click
  Sleep 300 
  PixelGetColor,Color2,168,593
  ;ToolTip, %Color2%
  if Color2=0xF9F9F9
  {
    Sleep 100
	MouseMove, 128, 590
    Click
	Sleep 60
    MouseMove, 1230, 420
    Click
  }
  MouseMove, mousex, mousey
  BlockInput, MouseMoveOff
}
} 
else 
{
i++

if (i == 30) {
WinGetTitle, otherapp, A
WinActivate, %emulator%
gosub helpclan
;Sleep 50
WinActivate, %otherapp%
i=0
;MsgBox, %otherapp%
;ToolTip, Out of focus
}
;ToolTip, %i%
}
}
return


checkforlogout:

PixelGetColor,Color,150,630
ToolTip, %Color%
if Color=0x0C0A08
{
  botbusy=1
  GuiControl, Text, Building1Disp, login screen detected
  BlockInput, MouseMove
  Click, 680, 550  
  BlockInput, MouseMoveOff
  botbusy=0
}
return


checkformenu:
;F1::
PixelGetColor, Color, 1242, 90
if (Color != 0xBDD9F3) {
Loop {
  MouseMove, 70, 70
  Click
  Sleep 600
  PixelGetColor, Color, 1242, 90
  if (Color = 0xBDD9F3) {
  Sleep 100
  break
  }
}
}
;clipboard := Color
return


focusemulator:

WinActivate, %emulator%
Sleep 300
return


F2::

Choice_Functional := "0.Nexus||1.Research Institute|2.Shipyard|3.Elite Academy|4.Radar Station|5.Warehouse|6.Ship Design"
Choice_Population := "0.Residence||1.University|2.Art Complex|3.|4.|5."
Choice_Resource := "0.Organic Farm(Food)||1.Mining Station(Minerals)|2.Power Plant(Electricity)|3.Metal Station(Metal)|4.Resource Forge(Gas&Gel)|5.Element Forge(Tit&Hyp)"
Choice_Factory := "0.Cornerstone Foundry||1.Higgs Smelting Furnace|2.Production Facility|3.Civ Industry|4.Alloy Foundry|5.Chemical Refinery(Motes)|6.Supply Station|7.Metal Shaper"

Choice_Station := "0_SpaceStation||1_Population|2_FunctionalShip"
Choice_Resources := "0_Basic||1_Regional|2_ProductionLine"
Choice_Fleet := "0_Warship||1._Arms"
Choice_0_SpaceStation := "1-1.ReduceBuildCost||1-3.ReduceBuildTime|3-1.ReduceShipCost|3-3.ReduceShipTime"
Choice_1_Population := "1-1.LaborGrowth||1-4.LaborCap|1-6.LaborUpkeep|1-8.LaborTax|3-1.TechnicianGrowth||3-4.TechnicianCap|3-6.TechnicianUpkeep|3-8.TechnicianTax|5-1.ResearcherGrowth||5-4.ResearcherCap|5-6.ResearcherUpkeep|5-8.ResearcherTax|7-1.ExpertGrowth||7-4.ExpertCap|7-6.ExpertUpkeep|7-8.ExpertTax"
Choice_2_FunctionalShip := "1-1.FleetLeadership||3-1.FlagshipAttack|3-4.FlagshipAccuracy|3-6.FlagshipSpeed|3-9.FlagshipJump|5-4.FlagshipHP|5-6.FlagshipArmor|5-9.FlagshipShields"
Choice_0_Basic := "1-1.FoodUpkeep||1-3.FoodProduction|1-6.MineralUpkeep||1-9.MineralProduction|3-1.ElectricityUpkeep|3-3.ElectricityProduction|3-6.SuppliesUpkeep||3-9.SuppliesProduction|5-1.ProductUpkeep|5-3.ProductProduction|5-6.MetalUpkeep||5-9.MetalProduction|7-1.CStoneUpkeep|7-3.CStoneProduction|7-6.AlloyUpkeep||7-9.AlloyProduction"

Choice_0_Warship := "1-1.FleetUpkeep||3-1.CorvetteUpkeep|3-3.CorvetteHP|3-5.CorvetteArmor|3-7.CorvetteEvade|3-9.CorvetteShields|5-1.FrigateUpkeep|5-3.FrigateHP|5-5.FrigateArmor|5-7.FrigateEvade|5-9.FrigateShields"

Gui, 1:New
Gui, 1:Add, Text, x5 y5, BUILDINGS
Gui, 1:Add, Text, x5 y20 w200 vBuilding1Disp, Queue Empty
Gui, 1:Add, Text, x210 y20 w60 vBuilding1TimerDisp, 0
Gui, 1:Add, Text, x5 y40 w200 vBuilding2Disp,
Gui, 1:Add, Text, x5 y60 w200 vBuilding3Disp,
Gui, 1:Add, Text, x5 y80 w200 vBuilding4Disp,
Gui, 1:Add, Text, x5 y85, RESEARCH
Gui, 1:Add, Text, x5 y100 w200 vResearch1Disp, Queue Empty
Gui, 1:Add, Text, x210 y100 w60 vResearch1TimerDisp, 0
Gui, 1:Add, Text, x5 y120 w200 vResearch2Disp,
Gui, 1:Add, Text, x210 y120 w60 vResearch2TimerDisp,
Gui, 1:Add, DropDownList, x10 y200 vTypeChoice gTypeChange, Functional||Population|Resource|Factory
Gui, 1:Add, DropDownList, x10 y220 vSubtypeChoice, 0.Nexus||1.Research Institute|2.Shipyard|3.Elite Academy|4.Radar Station|5.Warehouse|6.Ship Design Center
Gui, 1:Add, DropDownList, x10 y240 vBldIndexChoice, 1||2|3|4|5
Gui, 1:Add, Button, vBuild w80 x10 y260, Build
Gui, 1:Add, DropDownList, x140 y200 vResTypeChoice gResearchTypeChange, Station||Resources|Fleet
Gui, 1:Add, DropDownList, x140 y220 vResSubtypeChoice gResearchSubtypeChange, 0_SpaceStation||1_Population|2_FunctionalShip
Gui, 1:Add, DropDownList, x140 y240 vResIndexChoice, 1-1.ReduceBuildCost||1-3.ReduceBuildTime|3-1.ReduceShipCost|3-4.ReduceShipTime
Gui, 1:Add, Button, vResearch w80 x140 y260, Research
Gui, 1:Show
return

;; BUILD QUEUE ;;


TypeChange:

GuiControlGet,TypeChoice
GuiControl,, SubtypeChoice, % "|" . Choice_%TypeChoice%
GuiControl, Choose, SubtypeChoice, 1
Return


ButtonBuild:

Gui, Submit, NoHide
if (TypeChoice == "Functional") {
  buildqueue.Insert("0")
} else if (TypeChoice == "Population") {
  buildqueue.Insert("1")
} else if (TypeChoice == "Resource") {
  buildqueue.Insert("2")
} else if (TypeChoice == "Factory") {
  buildqueue.Insert("3")
}
buildqueue.Insert(SubStr(SubtypeChoice, 1, 1))
buildqueue.Insert(SubStr(BldIndexChoice, 1, 1))
resI := SubStr(buildqueue.MaxIndex() / 3, 1, 1)
GuiControl, Text, Building%resI%Disp, % resI " " SubStr(SubtypeChoice,3)

if (buildqueue[4]="") {
gosub rechecktimer
}
return


rechecktimer:

gosub focusemulator
WinGetPos, xp, yp,,,A
xp += 830
yp += 130

botbusy = 1
BlockInput, MouseMove
gosub checkformenu
MouseMove, 1230, 390
Click
Sleep 700

text := OCR([xp, yp, 120, 24]) ; get current timer
;ToolTip, %text% X %xp% Y %yp%
GuiControl, Text, Building1TimerDisp, %text%

MouseMove, 435, 535
Click
BlockInput, MouseMoveOff
botbusy = 0

hours := SubStr(text,1,2)
minutes := SubStr(text,4,2)
seconds := SubStr(text,7,2)

;MsgBox, % hours "h" minutes "min" seconds "sec"

minutes += hours * 60
seconds += minutes * 60
seconds -= 303
;MsgBox, %seconds% sec

if (seconds / 2 > 30) {
SetTimer, rechecktimer, % seconds / 2 * -1000
} else if (seconds > 0) {
SetTimer, buildqueued, % seconds * -1000
} else {
Sleep 500
gosub buildqueued
}
return


buildqueued:

gosub focusemulator
botbusy = 1
type := buildqueue[1]
subtype := buildqueue[2]
bldindex := buildqueue[3]
buildqueue.Remove(3)
buildqueue.Remove(2)
buildqueue.Remove(1)
BlockInput, MouseMove
gosub checkformenu
Click, 48, 600 ; open structure menu
Sleep 800
PixelGetColor,Color,200,60
;ToolTip, %Color%
if Color!=0x2F2D1D
{
Click, 48, 600 ; open structure menu
Sleep 500
}
MouseMove, 180+(300*type), 140 ; open sub menuw
Click
Sleep 650

if (subtype>4) 
{
Loop {
MouseMove,145,680
SetMouseDelay, 25
SendMode, Event
MouseClickDrag, left, 145, 680, 145, 570, 13
SetMouseDelay, 200
SendMode, Input
Sleep 50
subtype -= 1
if (subtype = 4) {
break
}
}
}
MouseMove, 130, 260+(100*subtype) ; choose building
Click
Sleep 650
MouseMove, 180+(260*bldindex), 420 ; choose building instance
Click
Sleep 950
MouseMove, 900, 620 ; upgrade menu
Click
Sleep 950
MouseMove, 1040, 660
Click ; speed up
Sleep 2360
MouseMove, 900, 600 ; upgrade menu
Click 
Sleep 900
MouseMove, 1045, 660 ; build
Click
Sleep 1900
Click ; ask help
Sleep 1250
MouseMove, 70, 70
Click
Sleep 750
Click
Sleep 750
Click
Sleep 200
BlockInput, MouseMoveOff
if (buildqueue[1]!="") {
Sleep 800
gosub rechecktimer
} else {
;MsgBox, queue empty
}
botbusy = 0
return

;; RESEARCH QUEUE

ResearchTypeChange:

GuiControlGet,ResTypeChoice
GuiControl,, ResSubtypeChoice, % "|" . Choice_%ResTypeChoice%
GuiControl, Choose, ResSubtypeChoice, 1
GuiControlGet, ResSubtypeChoice
GuiControl,, ResIndexChoice, % "|" . Choice_%ResSubtypeChoice%
GuiControl, Choose, ResIndexChoice, 1
Return

ResearchSubtypeChange:

GuiControlGet,ResSubtypeChoice
GuiControl,, ResIndexChoice, % "|" . Choice_%ResSubtypeChoice%
GuiControl, Choose, ResIndexChoice, 1
Return

ButtonResearch:

Gui, Submit, NoHide
if (ResTypeChoice == "Station") {
  resqueue.Insert("0")
} else if (ResTypeChoice == "Resources") {
  resqueue.Insert("1")
} else if (ResTypeChoice == "Fleet") {
  resqueue.Insert("2")
}
resqueue.Insert(SubStr(ResSubtypeChoice, 1, 1))
resqueue.Insert(SubStr(ResIndexChoice, 1, 1))
resqueue.Insert(SubStr(ResIndexChoice, 3, 1))
resI := SubStr(resqueue.MaxIndex() / 4, 1, 1)
GuiControl, Text, Research%resI%Disp, % resI " " SubStr(ResIndexChoice,5) " (" SubStr(ResSubtypeChoice,3) ")"

if (resqueue[5]="") {
gosub checkresearchtimer
}
return


checkresearchtimer:

WinActivate, %emulator%
WinGetPos, xp, yp,,,A
xp += 830
yp += 280

botbusy = 1
gosub checkformenu
Click, 1230, 390
Sleep 800

text := OCR([xp, yp, 120, 24]) ; get current timer
GuiControl, Text, Research1TimerDisp, %text%
;Tooltip, %text% X %xp% Y %yp%
MouseMove, 435, 535
Click
botbusy = 0
reshours := SubStr(text,1,2)
resminutes := SubStr(text,4,2)
resseconds := SubStr(text,7,2)

;MsgBox, % hours "h" minutes "min" seconds "sec"

resminutes += reshours * 60
resseconds += resminutes * 60
resseconds -= 2
;Tooltip, %text% X %xp% Y %yp% %resseconds% sec
if (resseconds / 2 > 30) {
SetTimer, checkresearchtimer, % resseconds / 2 * -1000
;gosub researchqueued
} else if (resseconds > 3) {
SetTimer, researchqueued, % resseconds * -1000
} else {
Sleep 400
gosub researchqueued
}

; if seconds / 2 > 300
return

researchqueued:

gosub focusemulator
botbusy = 1
restype := resqueue[1]
ressubtype := resqueue[2]
resindex := resqueue[3]
resindex2 := resqueue[4]
resqueue.Remove(1)
resqueue.Remove(1)
resqueue.Remove(1)
resqueue.Remove(1)
BlockInput, MouseMove
gosub checkformenu
MouseMove, 1230, 400
Click
Sleep 950
MouseMove, 600, 285
Click
Sleep 750
MouseMove, 220+(420*restype), 400
Click
Sleep 650
MouseMove, 130+(220*ressubtype), 170 
Click
Sleep 500
ToolTip, Resindex %resindex%
if (resindex>3) 
{
MouseMove,370,745
SetMouseDelay, 25
SendMode, Event
MouseClickDrag, left, 360, 740, 370, 110, 13
SetMouseDelay, 200
SendMode, Input
Sleep 100
resindex -= 4
}
MouseMove, 150+(105*resindex2), 190+(160*resindex)
Click
Sleep 500 
MouseMove, 1000, 620
Click
Sleep 1300
Click ; ask for help
Sleep 500
MouseMove, 70, 70
Click
Sleep 600
Click
Sleep 600
Click
BlockInput, MouseMoveOff
if (resqueue[1]!="") {
Sleep 600
gosub checkresearchtimer
}
botbusy = 0
return


F7::Reload

+esc::exitapp
f11::listvars
f12::reload
