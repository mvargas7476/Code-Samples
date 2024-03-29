## [ Layer 1/6: Bitwise Operations ]

Computers are big calculators. They perform operations with
numbers -- adding, subtracting, multiplying, etc. They
represent numbers using binary digits (ones and zeros)
called "bits". For example, here are the decimal numbers
zero to ten with their binary representations:

                    Decimal | Binary
                    --------+---------
                       0    |     0
                       1    |     1
                       2    |    10
                       3    |    11
                       4    |   100
                       5    |   101
                       6    |   110
                       7    |   111
                       8    |  1000
                       9    |  1001
                      10    |  1010

In addition to mathematical operations, computers can
perform operations that act upon the individual bits of a
number. These are called bitwise operations, and there are
only about six different ones: AND, OR, XOR, NOT,
LEFT-SHIFT, and RIGHT-SHIFT.

Bitwise operations are useful when working with binary data
at a low level, such as writing device drivers,
cryptographic algorithms, or working with binary file
formats (as opposed to text formats like XML or JSON).

As an example, let's say we have the decimal numbers 10 and
6, each stored in one byte. A byte contains exactly 8 bits,
so the binary representation is padded out with zeros on the
left. If we ask the computer to perform a bitwise AND
operation on these two bytes, it would do this:

                00001010  <-- decimal 10
            AND 00000110  <-- decimal 6
                --------
                00000010  <-- result: decimal 2

Bitwise AND looks at each bit in both of the bytes. If both
bits are 1, then the resulting bit is 1, otherwise the
resulting bit is 0.

Bitwise operations are not really mathematical operations.
Notice how "10 AND 6 = 2" doesn't make much sense
mathematically. That is because bitwise operations work at
the level of individual bits, ignoring of whatever decimal
number the bits represent.

    ----------------------------------------------------

Like all the layers, the payload is again encoded with
Adobe-flavoured ASCII85. After ASCII85 decoding the payload,
apply the following operations to each byte:

  1. Flip every second bit
  2. Rotate the bits one position to the right

For example:

                        |      Binary      Decimal  Hex
  ----------------------+-------------------------------
  Starting value        | 1 0 1 1 0 1 0 0    180     B4
                        |   v   v   v   v
  Flip every second bit | 1 1 1 0 0 0 0 1    225     E1
                        |  \ \ \ \ \ \ \ \
  Rotate to the right   | 1 1 1 1 0 0 0 0 )  240     F0
                        |  \_____________/

Here are some hints:

 - Bits can be flipped easily using XOR.

 - You can extract specific bits into a separate value using
   AND. This is called "masking".

 - You can use OR to combine some of the bits from one value
   with some of the bits from another value. Just make sure
   that the unimportant bits are masked (all set to zero).
   For example, if you want the first 4 bits of a byte
   combined with the last 4 bits of another byte:
   10100000 OR 00001010 = 10101010

 - Bit shift operations discard bits on one side, and add
   zeros to the other side. If you want to retain the bits
   that will be shifted off the end of a byte, you probably
   need to mask it into a separate variable before doing the
   shift.