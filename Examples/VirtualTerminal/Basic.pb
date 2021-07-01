;{- Code Header
; ==- Basic Info -================================
;         Name: VirtualTerminal/Basic.pb
;       Author: Herwin Bozet
; 
; ==- Links & License -===========================
;  License: Unlicense
;}

;- Compiler Directives

EnableExplicit

XIncludeFile "../../VirtualTerminal.pbi"

CompilerIf #PB_Compiler_ExecutableFormat <> #PB_Compiler_Console
	CompilerWarning "You should preferably compile the example as a console app !"
CompilerEndIf


;- Code

; Safely openning the console
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

; Clearing the console
VirtualTerminal::ClearDisplay(AinsiEscapeCode::#ED_2) ; 2 or +ClearDisplayFull() also works just fine
VirtualTerminal::CursorTo(0, 0)

; Intro
VirtualTerminal::WriteOutputN("-===- Welcome to the 'Basic' demo for 'VirtualTerminal' -===-")
VirtualTerminal::WriteOutputN("Press enter to start...")
Input()

; Basic info
VirtualTerminal::WriteOutputN("-=- Basic info -=-")
VirtualTerminal::WriteOutputN("Terminal size: "+Str(VirtualTerminal::GetTerminalWidth())+"x"+Str(VirtualTerminal::GetTerminalHeight()))
VirtualTerminal::WriteOutputN("Press enter to continue...")
Input()

; Title demo
VirtualTerminal::WriteOutputN("-=- Title -=-")
VirtualTerminal::WriteOutputN("Press enter to change the title...")
Input()
VirtualTerminal::SetWindowTitle("My new title")

; ???

; End
VirtualTerminal::WriteOutputN("-=- End of the demo -=-")
Print("Press enter to clear the terminal and exit...")
Input()
VirtualTerminal::ClearDisplayFull()
VirtualTerminal::CursorTo(0, 0)

; Quitting safely
VirtualTerminal::DisableVirtualTerminalProcessing()
CloseConsole()
End 0
