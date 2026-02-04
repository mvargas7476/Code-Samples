import base64
from Crypto.Cipher import AES
from aes_keywrap import aes_wrap_key, aes_unwrap_key
import struct

# Got this from google
QUAD = struct.Struct('>Q')
def aes_unwrap_key_and_iv(kek, wrapped):
    n = len(wrapped)//8 - 1
    #NOTE: R[0] is never accessed, left in for consistency with RFC indices
    R = [None]+[wrapped[i*8:i*8+8] for i in range(1, n+1)]
    A = QUAD.unpack(wrapped[:8])[0]
    decrypt = AES.new(kek, AES.MODE_ECB).decrypt
    for j in range(5,-1,-1): #counting down
        for i in range(n, 0, -1): #(n, n-1, ..., 1)
            ciphertext = QUAD.pack(A^(n*j+i)) + R[i]
            B = decrypt(ciphertext)
            A = QUAD.unpack(B[:8])[0]
            R[i] = B[8:]
    return b"".join(R[1:]), A


if __name__ == "__main__":
    with open("Payloads/5_challenge.txt", "r") as payload:
        file = payload.read()

    byteDecodedFile = base64.a85decode(file)

    # All of these come from the directions
    # the first Key and IV is used to decrypt the second Key
    keKey = byteDecodedFile[:32]
    kekCheck = byteDecodedFile[32:40]

    wrappedKey = byteDecodedFile[40:80]
    initialVector = byteDecodedFile[80:96]

    payload = byteDecodedFile[96:]
    
    key, iv_check = aes_unwrap_key_and_iv(keKey, wrappedKey)

    if iv_check != int.from_bytes(kekCheck, byteorder="big"):
        raise ValueError("Integrity Check Failed")

    cipher = AES.new(key, AES.MODE_CTR, nonce=bytes(0), initial_value=initialVector)

    decryptedPayload = cipher.decrypt(payload)

    with open("Payloads/6_challenge.txt", "wb") as nextPayload:
        nextPayload.write(decryptedPayload)