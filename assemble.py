from enum import Enum

# enum of all supported operations
class Operation (Enum):
    ADD = '0000'
    SUB = '0001'
    JUMP = '0010'
    BE = '0011'
    BNE = '0100'
    AND = '0101'
    NAND = '0110'
    OR = '0111'
    NOR = '1000'
    BGZ = '1001'
    BLZ = '1010'
    SR = '1011'
    SL = '1100'
    LW = '1101'
    SW = '1110'

# enum of all supported registers
class Register (Enum):
    A = '0000'
    B = '0001'
    C = '0010'
    D = '0011'
    E = '0100'
    F = '0101'
    I1 = '0110'
    I2 = '0111'
    I3 = '1000'
    I4 = '1001'

# switch(dictionary) get value for token
switch = {
    "ADD": Operation.ADD,
    "SUB": Operation.SUB,
    "JUMP": Operation.JUMP,
    "BE": Operation.BE,
    "BNE": Operation.BNE,
    "AND": Operation.AND,
    "NAND": Operation.NAND,
    "OR": Operation.OR,
    "NOR": Operation.NOR,
    "BGZ": Operation.BGZ,
    "BLZ": Operation.BLZ,
    "SR": Operation.SR,
    "SL": Operation.SL,
    "LW": Operation.LW,
    "SW": Operation.SW,
    "$A": Register.A,
    "$B": Register.B,
    "$C": Register.C,
    "$D": Register.D,
    "$E": Register.E,
    "$F": Register.F,
    "$I1": Register.I1,
    "$I2": Register.I2,
    "$I3": Register.I3,
    "$AI4": Register.I4,            
}

import re
import io

# open required files
file_path = input("File path: ")
file = open(file_path, 'r')
binary_out = open("binary_out.txt", 'w')
hex_out = open("hex_out.txt", 'w')

for line in file:
    # split on spaces and , only because that is all that is valid in our language
    split_line = re.split(r"[\ ,]", line)
    binary = ''
    for token in split_line:
        # do not search for tokens that have no length
        if(len(token) is 0):
            continue
        # use switch to get binary value for token
        token = switch.get(token.strip(), token)

        if (type(token) is Register):
            binary += token.value
        elif (type(token) is Operation):
            binary += token.value
        # if not register or operation, it must be a number
        else:
            # convert int to binary
            binary += '{0:08b}'.format(int(token.strip()))
    # fill to 25 places
    while (len(binary) is not 25):
        binary += '0'
        
    binary_out.write(binary + '\n')
    # convert to hex
    hex_string = str(hex(int(binary, 2)))
    # write and pad with zero to 8 places
    hex_out.write('0x' + hex_string[2:].zfill(8) + '\n')

file.close()
binary_out.close()
hex_out.close()