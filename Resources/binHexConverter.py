#Pick operation. Error if non numeric is entered.
binOrHex = int(input("Convert to binary or hex? 0 for binary or 1 for hex: "))

#Bad Input number.
if binOrHex != 0 and binOrHex != 1 :
    
    print("Bad input!")

#convert from hex to int to bin, number in int conversion denotes base incoming (16 in this case)
elif binOrHex == 0 :

    hexNum = int(input("Input a hexidecimal number for conversion to binary: "), 16)
    print(bin(hexNum))

#convert from hex to int to bin.
else :

    binNum = int(input("Input a binary number for conversion to hexidecimal (no spaces): "), 2)
    print(hex(binNum))