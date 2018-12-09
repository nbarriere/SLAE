; Filename:      egghunter-msg-stack.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  05.12.2018
; Note:          x86 code but assembled and linked on x64
; Assembler:     nasm -f elf32 egghunter-msg-stack.nasm -o egghunter-msg-stack.o
; Linker:        ld -m elf_i386 egghunter-msg-stack.o -o egghunter-msg-stack
; Assembly dump: objdump -d ./egghunter-msg-stack|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

;ssize_t write(int fd, const void *buf, size_t count);

	xor eax, eax       ; Clear edx register
	mov al, 0x4        ; sys_write

	xor ebx, ebx       ; Clear ebx register
	mov bl, 0x1        ; 1 = stdout

	xor edx, edx       ; Clear edx
	push edx           ; Push null byte in stack

	push 0x0a21646e    ; "\n!dn"
	push 0x756f6620    ; "uof "
	push 0x73676745    ; "sggE"

	mov ecx, esp       ; *buf = pointer to stack

	xor edx, edx       ; Clear edx register
	mov dl, 0xc        ; count = 0xc = 12 = string Length
	int 0x80           ; syscall

	;Exit the progam
	xor eax, eax       ; Clear register eax
	mov al, 01         ; sys_exit
	int 0x80           ; syscall
