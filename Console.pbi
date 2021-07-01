;{- Code Header
; ==- Basic Info -================================
;         Name: Console.pbi
;      Version: N/A
;       Author: Herwin Bozet
;
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.70 (x86/x64)
;  Operating system: Windows 10 21H1 (Previous versions untested)
; 
; ==- Links & License -===========================
;  License: Unlicense
;  MSDN: https://docs.microsoft.com/en-us/windows/console/console-functions
;}

;- Module declaration

DeclareModule Console
	;-> Structures
	
	Structure CursorPosition
		X.l
		Y.l
	EndStructure
	
	
	;-> Constants
	
	CompilerIf #PB_Compiler_Console
		#IsConsoleApp = #True
	CompilerElse
		#IsConsoleApp = #False
	CompilerEndIf
	
	; https://docs.microsoft.com/en-us/windows/console/setconsolemode
	; https://docs.microsoft.com/en-us/windows/console/getconsolemode
	; For input handles
	#ENABLE_PROCESSED_INPUT = $0001
	#ENABLE_LINE_INPUT = $0002
	#ENABLE_ECHO_INPUT = $0004
	#ENABLE_WINDOW_INPUT = $0008
	#ENABLE_MOUSE_INPUT = $0010
	#ENABLE_INSERT_MODE = $0020
	#ENABLE_QUICK_EDIT_MODE = $0040
	#ENABLE_VIRTUAL_TERMINAL_INPUT = $0200
	
	; For buffer/output? handles
	#ENABLE_PROCESSED_OUTPUT = $0001
	#ENABLE_WRAP_AT_EOL_OUTPUT = $0002
	#ENABLE_VIRTUAL_TERMINAL_PROCESSING = $0004
	#DISABLE_NEWLINE_AUTO_RETURN = $0008
	#ENABLE_LVB_GRID_WORLDWIDE = $0010
	
	
	;-> Typedefs Macros
	
	; DWORD and HANDLE types from MS libraries
	Macro DWORD : l : EndMacro
	Macro HANDLE : i : EndMacro
	
	
	;-> Procedure Declaration
	
	Declare.s GetConsoleTitle(MaxLength.i = 255)
	Macro SetConsoleTitle(Title) : ConsoleTitle(Title) : EndMacro
	
	Declare.b AddConsoleModeFlag(Flags.DWORD = #Null, ConsoleHandle.Console::HANDLE = #Null)
	Declare.b RemoveConsoleModeFlag(Flags.DWORD = #Null, ConsoleHandle.Console::HANDLE = #Null)
	
	; May fail on Windows if the program's output is piped.
	Macro EnableVirtualTerminalProcessing() : Console::AddConsoleModeFlag(Console::#ENABLE_VIRTUAL_TERMINAL_PROCESSING, #Null) : EndMacro
	Macro DisableVirtualTerminalProcessing() : Console::RemoveConsoleModeFlag(Console::#ENABLE_VIRTUAL_TERMINAL_PROCESSING, #Null) : EndMacro
	
	
	;-> Generic Macros
	
	; Macro for #IsConsoleApp
	Macro IsConsoleApp() : #IsConsoleApp : EndMacro
	
	; https://docs.microsoft.com/en-us/windows/console/getstdhandle
	Macro GetOutputHandle() : GetStdHandle_( #STD_OUTPUT_HANDLE ) : EndMacro
	Macro GetInputHandle() : GetStdHandle_( #STD_INPUT_HANDLE ) : EndMacro
	Macro GetErrorHandle() : GetStdHandle_( #STD_ERROR_HANDLE ) : EndMacro
EndDeclareModule


;- Module Definition

Module Console
	;-> Compiler Directives
	
	EnableExplicit
	
	
	;-> Procedure Definition
	
	Procedure.s GetConsoleTitle(MaxLength.i = 255)
		Protected *ConsoleTitleBuffer = AllocateMemory(MaxLength)
		Protected ConsoleTitle$ = #Null$
		
		If *ConsoleTitleBuffer
			Protected ConsoleTitleLength.l = GetConsoleTitle_(*ConsoleTitleBuffer, MaxLength)
			ConsoleTitle$ = PeekS(*ConsoleTitleBuffer, ConsoleTitleLength)
			FreeMemory(*ConsoleTitleBuffer)
		EndIf
		
		ProcedureReturn ConsoleTitle$
	EndProcedure
	
	Procedure.b AddConsoleModeFlag(Flags.DWORD = #Null, ConsoleHandle.Console::HANDLE = #Null)
		Protected ConsoleMode.DWORD = 0
		
		If ConsoleHandle = #Null
			ConsoleHandle = GetOutputHandle()
		EndIf
		
		If GetConsoleMode_(ConsoleHandle, @ConsoleMode)
			ConsoleMode = ConsoleMode | Flags
			
			If SetConsoleMode_(ConsoleHandle, ConsoleMode)
				ProcedureReturn #True
			EndIf
		EndIf
		
		Debug GetLastError_()
		ProcedureReturn #False
	EndProcedure
	
	Procedure.b RemoveConsoleModeFlag(Flags.DWORD = #Null, ConsoleHandle.Console::HANDLE = #Null)
		Protected ConsoleMode.DWORD = 0
		
		If ConsoleHandle = #Null
			ConsoleHandle = GetOutputHandle()
		EndIf
		
		If GetConsoleMode_(ConsoleHandle, @ConsoleMode)
			ConsoleMode = ConsoleMode & ~Flags
			
			If SetConsoleMode_(ConsoleHandle, ConsoleMode)
				ProcedureReturn #True
			EndIf
		EndIf
		
		Debug GetLastError_()
		ProcedureReturn #False
	EndProcedure
	
	; ???
EndModule


;- Tests

CompilerIf #PB_Compiler_IsMainFile
	EnableExplicit
	
	If Not OpenConsole("Console.pbi")
		Debug "Can't open console !"
		End 1
	EndIf
	
	;Debug "Console title: "+Console::GetConsoleTitle()
	
	If Console::EnableVirtualTerminalProcessing()
		PrintN("Virtual terminal processing activated !"+#CRLF$)
	Else
		PrintN("Virtual terminal processing couldn't be activated !"+#CRLF$)
	EndIf
	
	Console::CursorSave()
	PrintN("#####")
	PrintN("#####")
	PrintN("#####")
	Console::CursorUp()
	Print("A")
	Console::CursorRestore()
	Print("B")
	
	
	If Console::DisableVirtualTerminalProcessing()
		PrintN("Virtual terminal processing deactivated !"+#CRLF$)
	Else
		PrintN("Virtual terminal processing couldn't be deactivated !"+#CRLF$)
	EndIf
	
	Print("Press enter key to exit...")
	Input()
CompilerEndIf
