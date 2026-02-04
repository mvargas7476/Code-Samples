import base64

def getAllConditions(twentyEightNumbers):
    # This gets the necessary fields from the IPv4 and UDP headers for use in the program
    # fullLength, SourceIP, and destinationIP come from IPv4
    # ports, and checksum come from the UDP
    fullArray = {}

    fullArray["fullLength"] = (twentyEightNumbers[2] << 8) | twentyEightNumbers[3]
    fullArray["ipChecksum"] = (twentyEightNumbers[10] << 8) | twentyEightNumbers[11]
    fullArray["sourceIP"] = "{}{}{}{}".format(numToBinaryString(twentyEightNumbers[12]),numToBinaryString(twentyEightNumbers[13]), numToBinaryString(twentyEightNumbers[14]), numToBinaryString(twentyEightNumbers[15]))
    fullArray["destinationIP"] = "{}{}{}{}".format(numToBinaryString(twentyEightNumbers[16]), numToBinaryString(twentyEightNumbers[17]), numToBinaryString(twentyEightNumbers[18]), numToBinaryString(twentyEightNumbers[19]))
    fullArray["destinationPort"] = (twentyEightNumbers[22] << 8) | twentyEightNumbers[23]
    fullArray["udpChecksum"] = (twentyEightNumbers[26] << 8) | twentyEightNumbers[27]

    return fullArray

def processPayload(payload):
    moreToProcess = True
    counter = 0
    finalPayload = ''

    while moreToProcess:
        # Loops through the payload collecting the headers, and data, and conditions to process or discar packets
        headers = payload[counter:counter + 28]
        conditions = getAllConditions(headers)
        data = payload[counter + 28: counter + conditions["fullLength"]]

        data1 = 0
        for i in data:
            data1 = data1 << 8 | i 
        
        # Adding numbers so that our indexes are right as we loop through this
        counter += conditions["fullLength"]

        # Exits the loop once it processes the entire payload
        if counter >= len(payload):
            moreToProcess = False

        # Check conditions that will make discard packets if so continue
        if (conditions["sourceIP"] != '00001010000000010000000100001010'
            or conditions["destinationIP"] != '00001010000000010000000111001000' 
            or conditions["destinationPort"] != 42069
            or ipv4ChecksumValidation(headers) == False
            or udpChecksumValidation(headers, data1) == False):

            continue

        # If packet is valid, we add the character representation of the value to our final string
        for value in data:
            finalPayload += chr(value)

    return finalPayload
    
def ipv4ChecksumValidation(fullHeader):
    ip_header = fullHeader[:20]
    mask = 0b1111111111111111
    ip_checksum_calc = 0

    for i in range(0, 10):
        ip_checksum_calc += int.from_bytes(ip_header[i*2:i*2+2], byteorder='big')
    
    while ip_checksum_calc >> 16 != 0:
        ip_checksum_calc = (ip_checksum_calc & mask) + (ip_checksum_calc >> 16)
    ip_checksum_calc = ip_checksum_calc ^ mask

    if not ip_checksum_calc:
        return True
    else:
        return False

def udpChecksumValidation(fullHeader, data):
    mask = 0b1111111111111111
    pseudoHeader = [
        17,                          # Protocol
        fullHeader[12] << 8 | fullHeader[13],  # Half of Source IP
        fullHeader[14] << 8 | fullHeader[15],  # Other Half of Source IP
        fullHeader[16] << 8 | fullHeader[17],  # Half of destination IP
        fullHeader[18] << 8 | fullHeader[19],  # Other Half of destination IP
        fullHeader[24] << 8 | fullHeader[25],  # UDP Length
        fullHeader[20] << 8 | fullHeader[21],  # Source Port 
        fullHeader[22] << 8 | fullHeader[23],  # Destination Port
        fullHeader[26] << 8 | fullHeader[27]   # UDP Checksum
        ]

    udp_checksum_calc = 0
    udp_checksum_calc += pseudoHeader[1] + pseudoHeader[2]
    udp_checksum_calc += pseudoHeader[3] + pseudoHeader[4]
    udp_checksum_calc += pseudoHeader[0] + pseudoHeader[5]
    udp_checksum_calc += pseudoHeader[6] + pseudoHeader[7]
    udp_checksum_calc += pseudoHeader[5] + pseudoHeader[8]

    if pseudoHeader[5] % 2 == 1:
        data = data << 8
    while data != 0:
        udp_checksum_calc += data & mask
        data = data >> 16
    while udp_checksum_calc >> 16 != 0:
        udp_checksum_calc = (udp_checksum_calc & mask) + (udp_checksum_calc >> 16)
    udp_checksum_calc = udp_checksum_calc ^ mask
    if not udp_checksum_calc:
        return True
    else:
        return False


def numToBinaryString(num):
    return f'{num:08b}'


if __name__ == "__main__":
    with open("Payloads/4_challenge.txt", "r") as payload:
        file = payload.read()

    byteDecodedFile = base64.a85decode(file)

    final = processPayload(byteDecodedFile)

    with open("Payloads/5_challenge_1.txt", "w") as nextPayload:
        nextPayload.write(final)