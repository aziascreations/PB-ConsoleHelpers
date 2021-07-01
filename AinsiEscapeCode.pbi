;{- Code Header
; ==- Basic Info -================================
;         Name: AinsiEscapeCode.pbi
;      Version: N/A
;       Author: Herwin Bozet
;
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.70 (x86/x64)
;  Operating system: Windows 10 21H1 (Previous versions untested)
; 
; ==- Links & License -===========================
;  License: Unlicense
;}

;- Module Declaration

DeclareModule AinsiEscapeCode
	;-> Documentation
	;  * https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
	;  * https://invisible-island.net/xterm/ctlseqs/ctlseqs.html
	;  * https://en.wikipedia.org/wiki/ANSI_escape_code
	
	
	;-> Constants
	
	;-> > Control characters
	#BEL$ = #BEL$
	#BS$ = #BS$
	#HT$ = #TAB$
	#LF$ = #LF$
	#FF$ = #FF$
	#CR$ = #CR$
	#ESC$ = #ESC$
	
	;-> > Operators
	#CSI$ = "["
	#OSC$ = "]"
	
	;-> > Cursor
	#CUU$ = "A" ; Cursor Up by n
	#CUD$ = "B"	; Cursor Down by n
	#CUF$ = "C"	; Cursor Forward (Right) by n
	#CUB$ = "D"	; Cursor Backward (Left) by n
	
	#CNL$ = "E" ; Cursor Next Line by n
	#CPL$ = "F"	; Cursor Previous Line by n
	
	
	;-> Buffer ?
	#ED$ = "J" ; Erase in Display
	#ED_0 = 0  ; 0 from cursor to end of screen
	#ED_1 = 1  ; 1 from cursor to beginning of the screen
	#ED_2 = 2  ; 2 clear entire screen (May move to 0:0)
	#ED_3 = 3  ; 3 clear entire screen and lines saved in the scrollback buffer. (Does not work on Windows as of 21H1 in Windows Terminal)
	
	
	;-> Queries
	#DECXCPR$ = "6n" ; Emit the cursor position as: ESC [ <r> ; <c> R Where <r> = cursor row and <c> = cursor column
	
	#DECSC$ = "7" ; Save Cursor Position in Memory**
	#DECSR$ = "8" ; Restore Cursor Position from Memory**
	
	#RI$  = "M" ; Reverse Index – Performs the reverse operation of \n, moves cursor up one line, maintains horizontal position, scrolls buffer if necessary*
	
	
	; https://invisible-island.net/xterm/ctlseqs/ctlseqs.html
	
	; https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#cursor-positioning
	#CHA$ = "G" ; Cursor Horizontal Absolute	Cursor moves to <n>th position horizontally in the current line
	#VPA$ = "d"	; Vertical Line Position Absolute	Cursor moves to the <n>th position vertically in the current column
	#CUP$ = "H"	; Cursor Position	*Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
	#HVP$ = "f"	; Horizontal Vertical Position	*Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
	#ANSISYSSC_DECSC$ = "s" ; Save Cursor – Ansi.sys emulation	**With no parameters, performs a save cursor operation like DECSC
	#ANSISYSSC_DECRC$ = "u"	; Restore Cursor – Ansi.sys emulation	**With no parameters, performs a restore cursor operation like DECRC
	
EndDeclareModule


;- Module Definition

Module AinsiEscapeCode
	; Nothing...
EndModule
