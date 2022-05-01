import base64

def goodParitySelector(number):
    bitComp = 0b00000001
    parityBit = number & bitComp
    counter = 0

    # This checks each individual bit and counts how many 1 are there in the number
    for i in range (1, 8):
        numberOneCounter = number >> i & bitComp
        if numberOneCounter == 1:
            counter += 1

    # Depending on the conditions given by the challenge, we return true or false
    if (counter % 2) == 1 and parityBit == 0b00000001:
        return True
    elif (counter % 2) == 0 and parityBit == 0b00000000:
        return True
    else:
        return False


def generatingSevenBytes(goodBytesArr):
    finalByte = 0
    counter = 0
    sevenBytesCollection = []

    # Once the good parity bytes are generated, we gather the 7 data bits, collect 8 of them and generate seven bytes
    for number in goodBytesArr:
        # This removes the parity bit from the number
        number = number >> 1
        
        # This moves the bytes 7 spots and then ORs the numbers, essentially adding the next 7 bits to the previous ones
        finalByte = finalByte << 7 | number
        counter += 1

        # If we have collected 56 bits, the we collect them and append them
        if (counter % 8 == 0 and counter != 0):
            sevenBytesCollection.append(finalByte)
            finalByte = 0
            counter = 0
    return sevenBytesCollection


if __name__ == "__main__":
    with open("Payloads/2_challenge.txt", "r") as prompt:
        file = prompt.read()

    byteDecodedFile = base64.a85decode(file)
    goodParityBytes = []

    # This returns and array of all elements with good parity
    for i in byteDecodedFile:
        if(goodParitySelector(i)):
            goodParityBytes.append(i)

    final = generatingSevenBytes(goodParityBytes)

    with open("Payloads/3_challenge-1.txt", "wb") as nextPayload:
        for sevenBytes in final:
            nextPayload.write(sevenBytes.to_bytes(7, byteorder='big'))