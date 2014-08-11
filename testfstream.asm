; f/OneStream for f/One DOS Extender DPMI FASM Runtime (c) ACP
; testfstream.asm: demonstrate how Win32 application can use f/OneStream

format PE GUI 4.0
entry start

include 'win32a.inc'

section '.text' code readable executable

start:
	invoke GetFStreamVersion
	invoke ExitProcess,eax

section '.idata' import readable writeable
	library kernel,'KERNEL32.DLL',\
		user,'USE32.DLL',\
		fonestrm,'FONESTRM.DLL'

	import kernel,\
	       ExitProcess,'ExitProcess'

	import fonestrm,\
	       GetFStreamVersion,'GetFStreamVersion'