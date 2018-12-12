#coding:utf-8
"""
Filename:      decrypter.py
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  12.12.2018
Note:          Python3 Shellcode Decrypter with blowfish symmetric algorithm

"""
import blowfish

shellcode_crypted = b"\x42\xf4\xbf\xc1\x5f\xfc\xeb\x84\xa3\x77\xf2\x25\xb0\x1f\x68\x6a\x66\x0c\xfb\x3b\xf6\xea\x32\xaa\x62\x4e\x67\xe0\x33\x73\xc6\x72"
shellcode_decrypted = b""

key = input("Please enter a key between 4 and 56 caracters long:")
if len(key) < 4 or len(key) > 56:
    print("The size of the key is not correct, try harder!!!")
    exit()

cipher = blowfish.Cipher(key.encode())

# Cast bytes to bytearray
shellcode_crypted_array = bytearray(shellcode_crypted)

# decrypt the shellcode with Blowfish algorithm by block of 8 bytes
l = ((len(shellcode_crypted_array)) / 8) + 1
i = 1
p = 0
while i < l :
    block = shellcode_crypted_array[p:8*i]
    shellcode_decrypted += cipher.decrypt_block(block)
    i += 1
    p += 8

# Console ouptut print
crypted = ""
for x in bytearray(shellcode_crypted_array):
    crypted += '\\x'
    crypted += '%02x' % x

decrypted = ""
for x in bytearray(shellcode_decrypted):
    decrypted += '\\x'
    decrypted += '%02x' % x

print("-" * 90)
print("Crypted shellcode:")
print("-" * 90)
print(crypted)
print("-" * 90)
print("Decryption key:")
print("-" * 90)
print(key)
print("-" * 90)
print("Decrypted shellcode:")
print("-" * 90)
print(decrypted)
print("-" * 90)

print("Shellcode Length with padding:", len(bytearray(shellcode_crypted)))
