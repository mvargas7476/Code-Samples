## [ Layer 5/6: Advanced Encryption Standard ]

The Advanced Encryption Standard (AES) is an
industry-standard encryption algorithm. In 2001, after a
five year evaluation of 15 different encryption algorithms,
this algorithm was selected as the standard for use by the
U.S. Federal Government. In 2003, the National Security
Agency announced that AES was sufficient to protect the
highest level of classified information: TOP SECRET. Since
then it has seen wide adoption.

Currently, there are no known attacks capable of breaking
AES encryption when implemented properly. It is generally
considered to be one of the strongest and safest encryption
algorithms.

    ----------------------------------------------------

This payload has been encrypted with AES-256 in Counter Mode
(CTR). To decrypt the payload you will need the encryption
key and the initialization vector (IV). It is not possible
to guess these, so I will just give them to you. They are at
the start of the payload.

But... surprise! The key is also encrypted with AES. It
turns out that the U.S. Government also has standards for
how to encrypt encryption keys. I've encrypted the key using
the AES Key Wrap algorithm specified in RFC 3394. How do you
decrypt the key? Well, you will need another key, called the
"key encrypting key" (KEK), and another initialization
vector. These are also impossible to guess, so I will just
give them to you. They are also at the start of the payload.

But... surprise! Just kidding. I haven't encrypted the KEK.
The U.S. Government does not have a standard for encrypting
key encrypting keys, as far as I'm aware. That would be a
bit too crazy.

The payload is structured like this:

 - First 32 bytes: The 256-bit key encrypting key (KEK).
 - Next 8 bytes: The 64-bit initialization vector (IV) for
   the wrapped key.
 - Next 40 bytes: The wrapped (encrypted) key. When
   decrypted, this will become the 256-bit encryption key.
 - Next 16 bytes: The 128-bit initialization vector (IV) for
   the encrypted payload.
 - All remaining bytes: The encrypted payload

The first step is to use the KEK and the 64-bit IV to unwrap
the wrapped key. The second step is to use the unwrapped key
and the 128-bit IV to decrypt the rest of the payload.

Don't try to write the decryption algorithms yourself. Or
do. I'm not your dad. You do you. Personally, I used OpenSSL
to generate the payload for this layer, and reused the
`aes_key_wrap` Ruby gem that I wrote years ago.