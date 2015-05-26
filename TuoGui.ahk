#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance off
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

BGEffects := "none|Bloodlust X|Counterflux|Evolve X Leech Refresh|Enfeeble all X|Heal all X|Protect all X|Rally all X|Siege all X|Strike all X|Weaken all X|Enhance all Armor X|Enhance all Berserk X|Enhance all Corrosive X|Enhance all Counter X|Enhance all Enfeeble X|Enhance all Evade X|Enhance all Heal X|Enhance all Inhibit X|Enhance all Leech X|Enhance all Legion X|Enhance all Pierce X|Enhance all Poison X|Enhance all Protect X|Enhance all Rally X|Enhance all Siege X|Enhance all Strike X|Enhance all Weaken X|Metamorphosis|Reaping X"
MySieges := "none|Mortar Tower|Lightning Cannon|Death Factory|Corrosive Spore|Sky Fortress|Inspiring Altar"
EnemySieges := "none|Tesla Coil|Minefield|Foreboding Archway|Forcefield|Illuminary Blockade"
BGEffectsX := "1|2|3"

IniFileName := "data\SimpleTUOptimizeStarter.ini"
IniSection := "onLoad"

IniRead, IniMyDeck, %IniFileName%, %IniSection%, MyDeck, Cyrus, Medic, Revolver, Imperial APC, Medic, Imperial APC
IniRead, IniMySiege1, %IniFileName%, %IniSection%, MySiege1, none
IniRead, IniMySiege2, %IniFileName%, %IniSection%, MySiege2, none
IniRead, IniEnemiesDeck, %IniFileName%, %IniSection%, EnemiesDeck, Mission #94
IniRead, IniEnemySiege1, %IniFileName%, %IniSection%, EnemySiege1, none
IniRead, IniEnemySiege2, %IniFileName%, %IniSection%, EnemySiege2, none
IniRead, IniVIP, %IniFileName%, %IniSection%, VIP, %A_Space%
IniRead, IniIterations, %IniFileName%, %IniSection%, Iterations, 10000
IniRead, IniThreads, %IniFileName%, %IniSection%, Threads, 4
IniRead, IniSimOptions, %IniFileName%, %IniSection%, SimOptions, %A_Space%
IniRead, IniEffect, %IniFileName%, %IniSection%, Effect, none
IniRead, IniEffectX, %IniFileName%, %IniSection%, EffectX, 1
IniRead, IniMode, %IniFileName%, %IniSection%, Mode, 1
IniRead, IniCustomDeckFile, %IniFileName%, %IniSection%, CustomDeckFile, 1
IniRead, IniOrder, %IniFileName%, %IniSection%, Order, 1
IniRead, IniOperation, %IniFileName%, %IniSection%, Operation, 1
IniRead, IniEndgame, %IniFileName%, %IniSection%, Endgame, 1
IniRead, IniFund, %IniFileName%, %IniSection%, Fund, 1
IniRead, IniLog, %IniFileName%, %IniSection%, Log, 2

Menu, MyMenu, Add, ownedcards.txt, MenuOwnedcards
Menu, MyMenu, Add, customdecks.txt, MenuCustomdecks
Menu, MyMenu, Add, cardabbrs.txt, MenuCardabbrs
Menu, MyMenu, Add, Update XMLs, MenuUpdate
Menu, MyMenu, Add, Help, MenuHelp
Menu, MyMenu, Add, Web, MenuWeb
Gui, Menu, MyMenu

Gui, Add, Text, r5, My Deck:
Gui, Add, Text, r1, My Fortresses:
Gui, Add, Text, r5, Enemy Deck(s):
Gui, Add, Text, r1, Enemy Fortress:
Gui, Add, Text, r1, VIP Units:
Gui, Add, Text, r1, Effect:
Gui, Add, Text, r1, Mode:
Gui, Add, Text, r1, Operation:
Gui, Add, Text, r1, Flags:
Gui, Add, Text, r1, Custom Deck File:
Gui, Add, Text, r1, Log:

Gui, Add, Edit, vMyDeck ym w600 r5, %IniMyDeck%
Gui, Add, DDL, vMySiege1 section, %MySieges%
GuiControl, ChooseString, MySiege1, %IniMySiege1%
Gui, Add, DDL, vMySiege2 ys, %MySieges%
GuiControl, ChooseString, MySiege2, %IniMySiege2%
Gui, Add, Edit, vEnemiesDeck w600 r5 xs, %IniEnemiesDeck%
Gui, Add, DDL, vEnemySiege1 section, %EnemySieges%
GuiControl, ChooseString, EnemySiege1, %IniEnemySiege1%
Gui, Add, DDL, vEnemySiege2 ys, %EnemySieges%
GuiControl, ChooseString, EnemySiege2, %IniEnemySiege2%
Gui, Add, Edit, vVIP w600 r1 xs, %IniVIP%
Gui, Add, DDL, vEffect section, %BGEffects%
GuiControl, ChooseString, Effect, %IniEffect%
Gui, Add, Text, ys, Select X:
Gui, Add, DDL, altsubmit vEffectX ys w40 Group Choose%IniEffectX%, 1|2|3
Gui, Add, Text, ys, Endgame:
Gui, Add, DDL, altsubmit vEndgame ys Choose%IniEndgame%, none|0 - Maxed Units|1 - Maxed Fused|2 - Maxed Quads
Gui, Add, Text, ys, Fund:
Gui, Add, Edit, vFund r1 ys w50, %IniFund%
Gui, Add, DDL, altsubmit vMode Choose%IniMode% xs section, PVP|PVP (defense)|Guildwar|Guildwar (defense)|Brawl|Raid|Campaign
Gui, Add, Text, ys r1, Order:
Gui, Add, DDL, altsubmit vOrder ys Group Choose%IniOrder%, Random|Ordered
Gui, Add, DDL, altsubmit vOperation Group Choose%IniOperation% xs section, Climb|Sim|Reorder
Gui, Add, Text, r1 ys, Iterations:
Gui, Add, Edit, vIterations w100 r1 ys, %IniIterations%
Gui, Add, Text, r1 ys, 
Gui, Add, Text, ys, Threads:
Gui, Add, DDL, altsubmit vThreads ys w40 Group Choose%IniThreads%, 1|2|3|4
Gui, Add, Edit, vSimOptions r1 xs w600, %IniSimOptions%
Gui, Add, Button, r1 w50 section, ...
Gui, Add, Edit, vCustomDeckFile r1 ys w350 ReadOnly, %IniCustomDeckFile%
Gui, Add, Button, r1 ys w50, Edit
Gui, Add, Button, r1 ys w50, Clear
Gui, Add, DDL, altsubmit vLog Group Choose%IniLog% xs w60 section, Yes|No
Gui, Add, Checkbox, vx86 r1 ys x+40, x86 (32-bit)
Gui, Add, Button, default r2 w100 x100 y+15 section, Simulate
Gui, Add, Button, r2 w100 ys x+100, Exit
Gui, Add, Button, r1 w50 ys+5 x+150, Reset
Gui, Show,, Tyrant Unleashed Optimize GUI (for v2.9.1)
return  

Button...:
Gui, Submit
FileSelectFile, SelectedFile, 3, %A_WorkingDir%\data\ , Open a Owned Card text file, Text Documents (*.txt;)
if SelectedFile !=
	GuiControl,, CustomDeckFile, %SelectedFile%
Gui, Show
return

ButtonClear:
GuiControl,, CustomDeckFile, 
Gui, Show
return

ButtonEdit:
Gui, Submit
Run, Notepad.exe %CustomDeckFile%
Gui, Show
return

ButtonSimulate:
Gui, Submit
selTUO := (x86 ? "tuo-x86" : "tuo")
selMode := (Mode == 1 ? "pvp" : Mode == 2 ? "pvp-defense" : Mode == 3 ? "gw" : Mode == 4 ? "gw-defense" :Mode == 5 ? "brawl" : Mode == 6 ? "raid" : "campaign")
selOrder := (Order == 1 ? "random" : "ordered")
selOperation :=  (Operation == 1 ? "climb" : Operation == 2 ? "sim" : "reorder")
if (MySiege1 == "" || MySiege1 == "none")	{
	if (MySiege2 == "" || MySiege2 == "none")	{
		selMySiege := ""
	}	else	{
		selMySiege := "yf """ MySiege2 """ "
	}
}	else	{
	if (MySiege2 == "" || MySiege2 == "none")	{
		selMySiege := "yf """ MySiege1 """ "
	}	else	{
		selMySiege := (MySiege1 == Mysiege2 ? "yf """ MySiege1 " #2"" " : "yf """ MySiege1 ", " MySiege2 """ ")
	}
}
if (EnemySiege1 == "" || EnemySiege1 == "none")	{
	if (EnemySiege2 == "" || EnemySiege2 == "none")	{
		selEnemySiege := ""
	}	else	{
		selEnemySiege := "yf """ EnemySiege2 """ "
	}
}	else	{
	if (EnemySiege2 == "" || EnemySiege2 == "none")	{
		selEnemySiege := "yf """ EnemySiege1 """ "
	}	else	{
		selEnemySiege := (EnemySiege1 == EnemySiege2 ? "yf """ EnemySiege1 " #2"" " : "yf """ EnemySiege1 "," EnemySiege2 """ ")
	}
}
selVIP := ( VIP == "" ? "" : "vip """ VIP """ " )
selEffect := ( Effect == "" || Effect == "none" ? "" : "-e """ Effect """ ")
StringReplace, selEffect, selEffect, %A_Space%X,%A_Space%%EffectX%, All
selThreads := ( Threads == "4" ? "" : "-t " Threads " ")
selSimOptions := ( SimOptions == "" ? "" : SimOptions " ")
selCustomDeckFile := ( CustomDeckFile == "" ? "" : "-o=""" CustomDeckFile """ ")
FormatTime, TimeString,, yyyyMMdd_hhmmss
IfNotExist, log\
  FileCreateDir, log\
selLogFileName := ( A_WorkingDir "\log\Log_" TimeString "_" MyDeck "_" EnemiesDeck ".txt" )
selLogFirstLine := ( TimeString "_" MyDeck "_" EnemiesDeck "_" selMode "_" selOrder "_" selMySiege "_" selEnemySiege "_" selVIP "_" selEffect "_" selSimOptions "_" selOperation "_" Iterations  )
StringReplace, selLogFileName, selLogFileName, ",, All
StringReplace, selLogFileName, selLogFileName,  %A_Space%,_, All
if Log = 1
	selOutputLog := ( "| wtee -a " selLogFileName )

EndgameVal := Endgame -2
selEndgame := (Endgame <= 1 ? "" : "endgame " EndgameVal " ")
selFund := (Fund == "" || Fund == 0 ? "" : "fund " Fund " ")
execString = %selTUO% "%MyDeck%" "%EnemiesDeck%" %selMode% %selOrder% %selMySiege%%selEnemySiege%%selVIP%%selEffect%%selThreads%%selEndgame%%selFund%%selSimOptions%%selOperation% %Iterations% %selCustomDeckFile% %selOutputLog%
Run, cmd.exe /c title TUOptimizeOutput && echo %execString% && %execString% && pause
Gui, Show
return

ButtonReset:
GuiControl,, MyDeck, Cyrus, Medic, Revolver, Imperial APC, Medic, Imperial APC
GuiControl, ChooseString, MySiege1, none 
GuiControl, ChooseString, MySiege2, none 
GuiControl,, EnemiesDeck, Mission #118
GuiControl, ChooseString, EnemySiege1, none 
GuiControl, ChooseString, EnemySiege2, none 
GuiControl,, VIP, 
GuiControl, ChooseString, Effect, none
GuiControl, ChooseString, EffectX, 1
GuiControl, Choose, Endgame, 1
GuiControl,, Fund, 0
GuiControl, Choose, Mode, 1
GuiControl, Choose, Order, 1
GuiControl, Choose, Operation, 1
GuiControl,, Iterations, 1000
GuiControl, Choose, Threads, 4
GuiControl,, SimOptions, 
GuiControl,, CustomDeckFile, 
GuiControl, Choose, Log, 2
GuiControl,, x86, 0 
Gui, Show
return

MenuHelp:
Gui, Submit
selTUO := (x86 ? "tuo-x86" : "tuo")
Run, cmd.exe /c title TUOptimizeOutput && echo %selTUO% && %selTUO% && pause
Gui, Show
return

MenuWeb:
Gui, Submit
Run https://github.com/andor9/tyrant_optimize/releases
Gui, Show
return

MenuUpdate:
MsgBox, 0, Update started, Updating fusion_recipes_cj2.xml`, missions.xml`, cards.xml and raids.xml.`nPlease wait at least one minute. A new window should open soon.`nThis Window will auto close in 5 seconds. , 5
UrlDownloadToFile, http://mobile.tyrantonline.com/assets/fusion_recipes_cj2.xml, data\fusion_recipes_cj2.xml
had_error := false
if ErrorLevel
{
    MsgBox, Error downloading fusion_recipes_cj2.xml.
    had_error := true
}
UrlDownloadToFile, http://mobile.tyrantonline.com/assets/missions.xml, data\missions.xml
if ErrorLevel
{
    MsgBox, Error downloading missions.xml.
    had_error := true
}
UrlDownloadToFile, http://mobile.tyrantonline.com/assets/cards.xml, data\cards.xml
if ErrorLevel
{
    MsgBox, Error downloading cards.xml.
    had_error := true
}
UrlDownloadToFile, https://raw.githubusercontent.com/andor9/tyrant_optimize/unleashed/data/raids.xml, data\raids.xml
if ErrorLevel
{
    MsgBox, Error downloading raids.xml.
    had_error := true
}
if !had_error
    MsgBox, 0, Update finished, xml files successfully updated.`nThis Window will auto close in 2 seconds., 2
Gui, Show
return

MenuOwnedcards:
Gui, Submit
Run, Notepad.exe data\ownedcards.txt
Gui, Show
return

MenuCustomdecks:
Gui, Submit
Run, Notepad.exe data\customdecks.txt
Gui, Show
return

MenuCardabbrs:
Gui, Submit
Run, Notepad.exe data\cardabbrs.txt
Gui, Show
return

GuiClose:
ButtonExit:
Gui, Submit
IniWrite, %MyDeck%, %IniFileName%, %IniSection%, MyDeck
IniWrite, %MySiege1%, %IniFileName%, %IniSection%, MySiege1
IniWrite, %MySiege2%, %IniFileName%, %IniSection%, MySiege2
IniWrite, %EnemiesDeck%, %IniFileName%, %IniSection%, EnemiesDeck
IniWrite, %EnemySiege1%, %IniFileName%, %IniSection%, EnemySiege1
IniWrite, %EnemySiege2%, %IniFileName%, %IniSection%, EnemySiege2
IniWrite, %VIP%, %IniFileName%, %IniSection%, VIP
IniWrite, %Effect%, %IniFileName%, %IniSection%, Effect
IniWrite, %EffectX%, %IniFileName%, %IniSection%, EffectX
IniWrite, %Mode%, %IniFileName%, %IniSection%, Mode
IniWrite, %Order%, %IniFileName%, %IniSection%, Order
IniWrite, %Operation%, %IniFileName%, %IniSection%, Operation
IniWrite, %Iterations%, %IniFileName%, %IniSection%, Iterations
IniWrite, %Threads%, %IniFileName%, %IniSection%, Threads
IniWrite, %SimOptions%, %IniFileName%, %IniSection%, SimOptions
IniWrite, %CustomDeckFile%, %IniFileName%, %IniSection%, CustomDeckFile
IniWrite, %Log%, %IniFileName%, %IniSection%, Log
IniWrite, %Endgame%, %IniFileName%, %IniSection%, Endgame
IniWrite, %Fund%, %IniFileName%, %IniSection%, Fund

while true
{
  IfWinExist, TUOptimizeOutput
      WinClose ; use the window found above
  else
      break
}
ExitApp