;{- Code Header
; ==- Basic Info -================================
;         Name: VirtualTerminal/Basic.pb
;       Author: Herwin Bozet
; 
; ==- Links & License -===========================
;  License: Unlicense
;  GitHub: https://github.com/aziascreations/PB-ConsoleHelpers
;}

;- Compiler Directives

EnableExplicit

XIncludeFile "../../VirtualTerminal.pbi"

CompilerIf #PB_Compiler_ExecutableFormat <> #PB_Compiler_Console
	CompilerWarning "You should preferably compile the example as a console app !"
CompilerEndIf


;- Code

;-> Safely openning the console
If OpenConsole("My first title")
	If Not VirtualTerminal::EnableVirtualTerminalProcessing()
		VirtualTerminal::WriteErrorN("Unable to activate virtual terminal processing, output is likely piped !")
		CloseConsole()
		End 2
	EndIf
Else
	Debug "Can't open console !"
	End 1
EndIf


;-> Clearing the console
VirtualTerminal::ClearDisplay(AinsiEscapeCode::#ED_2) ; 2 or +ClearDisplayFull() also works just fine
VirtualTerminal::CursorTo(0, 0)


;-> Intro
VirtualTerminal::WriteOutputN("-===- Welcome to the 'Basic' demo for 'VirtualTerminal' -===-")

VirtualTerminal::WriteOutputN("This program serves as a short demo of the 'VirtualTerminal' include for PureBasic.")
VirtualTerminal::WriteOutputN("This include and its module aim to bring the functionalities of the escape character sequences"+
                              " to PureBasic without using any OS-specific API.")
VirtualTerminal::WriteOutputN("")
VirtualTerminal::WriteOutputN("Some features may not work properly on some third-party consoles such as ConEmu.")
VirtualTerminal::WriteOutputN("The 'GetTerminalWidth()' and 'GetTerminalHeight()' procedure tend to scroll the viewport on them.")
VirtualTerminal::WriteOutputN("")
VirtualTerminal::WriteOutputN("Press enter to start...")
Input()


;-> Basic info
VirtualTerminal::WriteOutputN("-=- Basic info -=-")
Define TerminalWidth.i = VirtualTerminal::GetTerminalWidth()
Define TerminalHeight.i = VirtualTerminal::GetTerminalHeight()
VirtualTerminal::WriteOutputN("Terminal size: "+Str(TerminalWidth)+"x"+Str(TerminalHeight))
VirtualTerminal::WriteOutputN("Press enter to continue...")
Input()


;-> Title demo
VirtualTerminal::WriteOutputN("-=- Title -=-")
VirtualTerminal::WriteOutputN("Press enter to change the title...")
Input()
VirtualTerminal::SetWindowTitle("My new title")


;-> Dynamic UI demo
VirtualTerminal::WriteOutputN("-=- Dynamic UI -=-")
VirtualTerminal::WriteOutputN("Press enter to start...")
Input()

Define Percentage.i = 0

Repeat
	Define ProgressBarSize.i = Round((TerminalWidth) * (Percentage / 100), #PB_Round_Down)
	
	Define OriginalCursorPosition.Console::CursorPosition
	VirtualTerminal::GetCursorPosition(@OriginalCursorPosition)
	
	VirtualTerminal::WriteOutput("["+RSet("", ProgressBarSize, "#")+RSet("", TerminalWidth - ProgressBarSize - 2, " ")+"]")
	VirtualTerminal::CursorTo(0, OriginalCursorPosition\Y)
	
	Percentage = Percentage + 1
	Delay(15)
Until Percentage = 100

VirtualTerminal::CursorDownBy(2)


;-> ???


;-> Finishing
VirtualTerminal::WriteOutputN("-=- End of the demo -=-")
Print("Press enter to clear the terminal and exit...")
Input()
VirtualTerminal::ClearDisplayFull()
VirtualTerminal::CursorTo(0, 0)


;-> Quitting safely
VirtualTerminal::DisableVirtualTerminalProcessing()
CloseConsole()
End 0
