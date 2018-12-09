/*
Filename:      shellcode.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          x86 code but compiled on x64
Disassembler:  msfvenom -p linux/x86/exec CMD=/bin/ls -a x86 --platform linux -f c
Compiler:      gcc -m32 -ggdb -fno-stack-protector -z execstack shellcode.c -o shellcode
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x6a\x0b\x58\x99\x52\x66\x68\x2d\x63\x89\xe7\x68\x2f\x73\x68"
"\x00\x68\x2f\x62\x69\x6e\x89\xe3\x52\xe8\x08\x00\x00\x00\x2f"
"\x62\x69\x6e\x2f\x6c\x73\x00\x57\x53\x89\xe1\xcd\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
