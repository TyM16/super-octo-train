from enum import Enum

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

file_path = input("File path: ")
file = open(file_path, 'r')
outfile = open("out.txt", 'w')

for line in file:
    split_line = re.split(r"\ , $", line)
    binary = ''
    for token in split_line:
        binary += switch.get(token, "ERROR")
    outfile.write(binary)

file.close()
outfile.close()