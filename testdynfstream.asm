; f/OneStream for f/One DOS Extender DPMI FASM Runtime (c) ACP 2014
; testdynfstream.asm: demonstrate how Win32 application can use f/OneStream  using LoadLibrary

format PE GUI
entry start

include 'win32ax.inc'

section '.text' code readable executable

start:
	invoke LoadLibrary,'FONESTRM.DLL'
	mov [hLib],eax
	test eax,eax
	jnz @f
	invoke MessageBox, NULL, 'Can not load FSTREAM.DLL library', 'fOneStream', MB_ICONERROR+MB_OK
exit:
	invoke ExitProcess, 0
@@:
	invoke GetProcAddress, [hLib], 'GetFStreamVersion'
	mov [hProc],eax
	test eax,eax
	jnz @f
	invoke MessageBox, NULL, 'FSTREAM.DLL library is broken.', 'fOneStream', MB_ICONERROR+MB_OK
	jmp exit
@@:
	call [hProc]
	mov [ver],eax

	cinvoke wsprintf, output_buf, hello_msg, [ver]

	invoke MessageBox, HWND_DESKTOP, output_buf, 'fOneStream', MB_ICONINFORMATION+MB_OK
	jmp exit

section '.data' data readable writeable

hLib		dd 0
hProc		dd 0
ver		dd 0
output_buf	rb (hello_msg_end - hello_msg) + 2	;just in case the formating string takes more than versio number right now
hello_msg	db 'FSTREAM.DLL library version %02d is available.'
hello_msg_end:

section '.idata' import readable writeable
	library kernel,'KERNEL32.DLL',\
		user, 'USER32.DLL'

	import kernel,\
	       LoadLibrary,'LoadLibraryA',\
	       FormatMessage,'FormatMessageA',\
	       GetProcAddress,'GetProcAddress',\
	       ExitProcess,'ExitProcess'

	import user,\
	       MessageBox,'MessageBoxA',\
	       wsprintf,'wsprintfA'

