## [ Layer 2/6: Parity Bit ]

Parity bits are used to detect when data is being corrupted
-- for example, by a faulty cable. If the receiver of the
data notices that a parity bit is not correct, that
indicates that the data is being changed somehow.

    ----------------------------------------------------

For each byte of the payload, the seven most significant
bits carry data, and the least significant bit is the parity
bit. Combine the seven data bits from each byte where the
parity bit is correct, discarding bytes where the parity bit
is incorrect.

To determine if the parity bit is correct, first count how
many '1' bits exist within the seven data bits. If the count
is odd, the parity bit should be '1'. If the count is even,
the parity bit should be '0'.

For example, here is the byte 0xA3 (163 in decimal):

  1 0 1 0 0 0 1 1 <-- Parity bit (least significant bit)
  ^ ^ ^ ^ ^ ^ ^
  | | | | | | |
    Data bits

Of the data bits above, three of them are '1's. This is an
odd number, so the '1' parity bit is correct.

To make this layer a little bit easier, the byte size of the
payload is guaranteed to be a multiple of eight. Every group
of eight bytes contains 64 bits total, including 8 parity
bits. Removing the 8 parity bits leaves behind 56 data
bits, which is exactly 7 bytes.