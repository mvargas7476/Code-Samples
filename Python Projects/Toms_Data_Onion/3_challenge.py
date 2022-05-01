import base64

def knownKeys(stringToUse, charactersKnown):
    # This is the general starting point to all of the payloads, therefore I can get 15 characters of the key with this
    key = []

    # You XOR the string with the character to get the key
    for i in range (0, len(charactersKnown)):
        key.append(stringToUse[i] ^ ord(charactersKnown[i]))
    return key

def fileDecrypor(haystack):
    key = [108, 36, 132, 142, 66, 25, 168, 225, 197, 219, 87, 101, 185, 198, 20, 
        158, 165, 25, 53, 150, 59, 57, 127, 165, 101, 209, 254, 1, 133, 125, 217, 76]
    string = ''

    for index, number in enumerate(haystack):
        string += chr(number ^ key[index % len(key)])
    
    return string


if __name__ == "__main__":
    with open("Payloads/3_challenge.txt", "r") as prompt:
        file = prompt.read()

    byteDecodedFile = base64.a85decode(file)

    # Zero uses the first 15 characters, One uses the next 30
    keyZero = knownKeys(byteDecodedFile[:15], "==[ Layer 4/6: ")
    keyOne = knownKeys(byteDecodedFile[30:63], " ]============================\n\n")

    file = fileDecrypor(byteDecodedFile)

    with open("Payloads/4_challenge.txt", "w") as nextPayload:
        for guess in file:
            nextPayload.write("{}".format(guess))