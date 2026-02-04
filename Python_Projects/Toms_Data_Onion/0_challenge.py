import base64

with open("Payloads/0_challenge.txt", "r") as prompt:
    file = prompt.read()

# decoding the ascii85 bytes
decodedFile = base64.a85decode(file)

# decoding bytes into string
final = decodedFile.decode("UTF-8")

with open("Payloads/1_challenge.txt", "w") as nextPrompt:
    nextPrompt.write(final)