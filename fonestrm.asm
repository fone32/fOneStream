; f/OneStream for f/One DOS Extender DPMI FASM Runtime (c) ACP
; fonestrm.asm: base DLL library to communicate with f/OneStream drivers

format PE GUI 4.0 DLL
entry DllMain

include 'win32a.inc'

VERSION = 00000001h

section '.text'  code readable executable

proc DllMain hInstDll, fdwReason, lpvReserved
     mov eax,TRUE
     ret
endp

proc GetFStreamVersion
     invoke GetLastError
     mov eax, VERSION
     ret
endp

section '.idata' import data readable writeable
	library kernel,'KERNEL32.DLL'

	import kernel,\
	       GetLastError,'GetLastError',\
	       SetLastError,'SetLastError',\
	       FormatMessage,'FormatMessageA',\
	       LocalFree,'LocalFree'

section '.edata' export data readable
	export 'FONESTRM.DLL',\
	       DllMain,'DllMain', \
	       GetFStreamVersion,'GetFStreamVersion'

section '.reloc' fixups data readable discardable


