;{- Code Header
; ==- Basic Info -================================
;         Name: VirtualTerminal.pbi
;      Version: N/A
;       Author: Herwin Bozet
; 
; ==- Links & License -===========================
;  License: Unlicense
;  GitHub: https://github.com/aziascreations/PB-ConsoleHelpers
;}

;- Compiler directives

XIncludeFile "./Console.pbi"
XIncludeFile "./AinsiEscapeCode.pbi"


;- Module declaration

DeclareModule VirtualTerminal
	;-> Macros
	
	;-> > Console.pbi macros
	
	;Macro CursorPosition : Console::CursorPosition : EndMacro
	
	Macro IsConsoleApp() : Console::#IsConsoleApp : EndMacro
	
	Macro GetOutputHandle() : Console::GetOutputHandle() : EndMacro
	Macro GetInputHandle() : Console::GetInputHandle() : EndMacro
	Macro GetErrorHandle() : Console::GetErrorHandle() : EndMacro
	
	;-> > Platform-dependant Macros
	
	CompilerIf #PB_Compiler_OS = #PB_OS_Windows
		Macro EnableVirtualTerminalProcessing() : Console::EnableVirtualTerminalProcessing() : EndMacro
		Macro DisableVirtualTerminalProcessing() : Console::DisableVirtualTerminalProcessing() : EndMacro
	CompilerElse
		Declare.b EnableVirtualTerminalProcessing()
		Declare.b DisableVirtualTerminalProcessing()
	CompilerEndIf
	
	;-> > Generic Macros
	
	Macro WriteOutput(Message) : Print(Message) : EndMacro
	Macro WriteOutputN(Message) : PrintN(Message) : EndMacro
	Macro WriteErrorN(Message) : ConsoleError(Message) : EndMacro
	
	;-> > Ainsi Escape Code Macros
	
	;-> > > Cursor
	Macro CursorUp() : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CUU$) : EndMacro
	Macro CursorDown() : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CUD$) : EndMacro
	Macro CursorRight() : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CUF$) : EndMacro
	Macro CursorLeft() : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CUB$) : EndMacro
	Macro CursorNextLine(Amount) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CNL$) : EndMacro
	Macro CursorPreviousLine(Amount) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CPL$) : EndMacro
	
	Macro CursorUpBy(Amount) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Amount) + AinsiEscapeCode::#CUU$) : EndMacro
	Macro CursorDownBy(Amount) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Amount) + AinsiEscapeCode::#CUD$) : EndMacro
	Macro CursorRightBy(Amount) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Amount) + AinsiEscapeCode::#CUF$) : EndMacro
	Macro CursorLeftBy(Amount) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Amount) + AinsiEscapeCode::#CUB$) : EndMacro
	Macro CursorLineDownBy(Amount) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Amount) + AinsiEscapeCode::#CNL$) : EndMacro
	Macro CursorLineUpBy(Amount) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Amount) + AinsiEscapeCode::#CPL$) : EndMacro
	
	Macro CursorToColumn(ColumnNumber) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(ColumnNumber) + AinsiEscapeCode::#CHA$) : EndMacro
	Macro CursorToLine(LineNumber) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(LineNumber) + AinsiEscapeCode::#VPA$) : EndMacro
	Macro CursorTo(X, Y) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Y) + ";" + Str(X) + AinsiEscapeCode::#CUP$) : EndMacro	
	
	Macro CursorSave() : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#DECSC$) : EndMacro
	Macro CursorRestore() : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#DECSR$) : EndMacro
	
	; Does not appear to work properly in cmd.exe
	Macro CursorFlip() : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#RI$) : EndMacro
	
	;-> > > Screen Buffer
	Macro ScrollUpBy(Amount = 1) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Amount) + AinsiEscapeCode::#SU$) : EndMacro
	Macro ScrollDownBy(Amount = 1) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Amount) + AinsiEscapeCode::#SD$) : EndMacro
	Macro ScrollUp() : VirtualTerminal::ScrollUpBy() : EndMacro
	Macro ScrollDown() : VirtualTerminal::ScrollDownBy() : EndMacro
	
	;-> > > Others ?
	Macro ClearDisplay(Mode = AinsiEscapeCode::#ED_0) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Mode) + AinsiEscapeCode::#ED$) : EndMacro
	Macro ClearDisplayToEnd() : VirtualTerminal::ClearDisplay(AinsiEscapeCode::#ED_0) : EndMacro
	Macro ClearDisplayToStart() : VirtualTerminal::ClearDisplay(AinsiEscapeCode::#ED_1) : EndMacro
	Macro ClearDisplayFull() : VirtualTerminal::ClearDisplay(AinsiEscapeCode::#ED_2) : EndMacro
	Macro ClearDisplayAbsolute() : VirtualTerminal::ClearDisplay(AinsiEscapeCode::#ED_3) : EndMacro
	
	Macro ClearLineDisplay(Mode = AinsiEscapeCode::#EL_0) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + Str(Mode) + AinsiEscapeCode::#EL$) : EndMacro
	Macro ClearLineToEnd() : VirtualTerminal::ClearLineDisplay(AinsiEscapeCode::#EL_0) : EndMacro
	Macro ClearLineToStart() : VirtualTerminal::ClearLineDisplay(AinsiEscapeCode::#EL_1) : EndMacro
	Macro ClearLineFull() : VirtualTerminal::ClearLineDisplay(AinsiEscapeCode::#EL_2) : EndMacro
	
	;-> > > Window
	Macro SetWindowTitleAndIcon(Title) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#OSC$ + "0;" + Left(Title, 255) + AinsiEscapeCode::#BEL$) : EndMacro
	Macro SetWindowTitle(Title) : VirtualTerminal::WriteOutput(#ESC$ + AinsiEscapeCode::#OSC$ + "2;" + Left(Title, 255) + AinsiEscapeCode::#BEL$) : EndMacro
	
	
	;-> Procedure Declaration (See the "Platform-dependant Macros" section)
	
	Declare.b GetCursorPosition(*CursorPosition.Console::CursorPosition, TimeoutMs.i = 1)
	
	; May mess up some terminals (ConEmu with cmd doesn't like it at all...)
	Declare.i GetTerminalWidth(RestorePosition.b = #True)
	Declare.i GetTerminalHeight(RestorePosition.b = #True)
EndDeclareModule


;- Module Definition

Module VirtualTerminal
	;-> Compiler Directives
	
	EnableExplicit
	
	
	;-> Procedure Definition
	
	CompilerIf Not #PB_Compiler_OS = #PB_OS_Windows
		; FIXME: May not work if piped, not sure !
		Procedure.b EnableVirtualTerminalProcessing() : ProcedureReturn #True : EndIf
		Procedure.b DisableVirtualTerminalProcessing() : ProcedureReturn #True : EndIf
	CompilerEndIf
	
	Procedure.b GetCursorPosition(*CursorPosition.Console::CursorPosition, TimeoutMs.i = 1)
		Protected StartTime.q
		Protected Input$ = #Null$
		
		If *CursorPosition
			WriteOutput(#ESC$ + AinsiEscapeCode::#CSI$ + AinsiEscapeCode::#DECXCPR$)
			
			; Waiting for stuff to come in...
			StartTime = ElapsedMilliseconds()
			Repeat
				Input$ = Inkey()
			Until Input$ <> #Null$ Or ((TimeoutMs <> -1 And (ElapsedMilliseconds() - StartTime > TimeoutMs)) Or (TimeoutMs = -1))
			
			Repeat
				Protected NewChar$ = Inkey()
				If NewChar$ <> #Null$
					Input$ = Input$ + NewChar$
				Else
					Break
				EndIf
			ForEver
			
			Protected.i ResponseCodeStart = FindString(Input$, "[") + 1
			Input$ = Mid(Input$, ResponseCodeStart, FindString(Input$, "R", ResponseCodeStart) - ResponseCodeStart)
			
			If FindString(Input$, ";") >= 2
				*CursorPosition\Y = Val(StringField(Input$, 1, ";"))
				*CursorPosition\X = Val(StringField(Input$, 2, ";"))
				ProcedureReturn #True
			EndIf
		EndIf
		
		ProcedureReturn #False
	EndProcedure
	
	Procedure.i GetTerminalWidth(RestorePosition.b = #True)
		Define OriginalCursorPosition.Console::CursorPosition
		Define MeasuringCursorPosition.Console::CursorPosition
		
		If RestorePosition
			VirtualTerminal::GetCursorPosition(@OriginalCursorPosition)
		EndIf
		
		VirtualTerminal::CursorTo(32767, 0)
		VirtualTerminal::GetCursorPosition(@MeasuringCursorPosition)
		
		If RestorePosition
			VirtualTerminal::CursorTo(OriginalCursorPosition\X, OriginalCursorPosition\Y)
		EndIf
		
		ProcedureReturn MeasuringCursorPosition\X
	EndProcedure
	
	Procedure.i GetTerminalHeight(RestorePosition.b = #True)
		Define OriginalCursorPosition.Console::CursorPosition
		Define MeasuringCursorPosition.Console::CursorPosition
		
		If RestorePosition
			VirtualTerminal::GetCursorPosition(@OriginalCursorPosition)
		EndIf
		
		VirtualTerminal::CursorTo(0, 32767)
		VirtualTerminal::GetCursorPosition(@MeasuringCursorPosition)
		
		If RestorePosition
			VirtualTerminal::CursorTo(OriginalCursorPosition\X, OriginalCursorPosition\Y)
		EndIf
		
		ProcedureReturn MeasuringCursorPosition\Y
	EndProcedure
EndModule


;- Tests

CompilerIf #PB_Compiler_IsMainFile
	EnableExplicit
	
	If OpenConsole("Console.pbi")
		If Not VirtualTerminal::EnableVirtualTerminalProcessing()
			VirtualTerminal::WriteErrorN("Unable to activate virtual terminal processing, output is likely piped !")
			CloseConsole()
			End 2
		EndIf
	Else
		Debug "Can't open console !"
		End 1
	EndIf
	
	Define TerminalWidth.i = VirtualTerminal::GetTerminalWidth(#False)
	Define TerminalHeight.i = VirtualTerminal::GetTerminalHeight(#False)
	
	VirtualTerminal::ClearDisplay(AinsiEscapeCode::#ED_2)
	VirtualTerminal::CursorTo(0, 0)
	
	VirtualTerminal::WriteOutput(RSet("", TerminalWidth, "#"))
	VirtualTerminal::WriteOutput(LSet("# Application Title", TerminalWidth-1) + "#")
	VirtualTerminal::WriteOutput(RSet("", TerminalWidth, "#"))
	
	VirtualTerminal::CursorTo(0, TerminalHeight - 2)
	
	VirtualTerminal::WriteOutput(RSet("", TerminalWidth, "#"))
	VirtualTerminal::WriteOutput(LSet("# Footer text", TerminalWidth-1) + "#")
	VirtualTerminal::WriteOutput(RSet("", TerminalWidth, "#"))
	VirtualTerminal::CursorTo(0, 4)
	
	
	
	Print("Press enter key to exit...")
	Input()
	
	VirtualTerminal::DisableVirtualTerminalProcessing()
	CloseConsole()
	End 0
CompilerEndIf
