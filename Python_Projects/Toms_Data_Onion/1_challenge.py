import base64

def flipBytes(number):
    # The XOR operator will flip bytes based on the 1 value and where it is. Look at table for this online
    # So the mask will flip every even bit to check this uncomment the lines below to see output
    flipBit = 0b01010101
    # print ("{} mask".format(binaryRepresentation(maskingBit)))
    # print ("{} characters".format(binaryRepresentation(number)))
    # print (binaryRepresentation(number ^ maskingBit))
    return (number ^ flipBit)

def shiftRight (number):
    # This function uses a mask to keep the last digit from the original number
    # it then ORs the bite by moving it to the first position to maintain the last bit and not lose it
    maskLastDigit = 0b00000001
    lastDigit = (number & maskLastDigit)
    return  (lastDigit << 7) | (number >> 1)

def binaryRepresentation (num):
    return (f'{num:08b}')


if __name__ == "__main__":
    with open("Payloads/1_challenge.txt", "r") as prompt:
        file = prompt.read()

    byteDecodedFile = base64.a85decode(file)

    final = ''
    for i in byteDecodedFile:
        # This will do the following from the inside out:
            # ord gives the number value for the character
            # flipBytes will flip the bytes
            # shiftRight will shift the bytes to the right
            # chr gives the character based off of the number value
        final += chr(shiftRight(flipBytes(i)))

    with open("Payloads/2_challenge.txt", "w") as nextPrompt:
        nextPrompt.write(final)