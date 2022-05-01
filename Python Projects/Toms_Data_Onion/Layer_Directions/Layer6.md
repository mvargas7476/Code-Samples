# [ Layer 6/6: Virtual Machine ]

Every computer has a CPU, and every CPU runs binary
instruction data called machine code. The format of the
binary data, or how a CPU interprets the data, is called the
instruction set architecture (ISA). As of 2020, the ISA of
the CPU in your desktop computer is probably some variant of
x86-64.

Let's look at two bytes of example machine code: 0x04 0xAA.
An x86-64-compatible CPU would read the first byte 0x04 and
interpret that as an instruction called "ADD AL, imm8". The
"imm8" part means that this instruction includes the next
byte too. Executing the instruction, the CPU would read and
interpret the second byte as an integer, adding it to the
value in the `AL` register. The result would be the same
whether these bytes were run on an Intel Core i9 or an AMD
Ryzen 9, because both of those CPUs are designed to run
x86-64 machine code.

What if we tried to run the same two bytes of machine code
on an original Nintendo Gameboy? The Gameboy's CPU is a
Sharp LR35902, which was custom-made for Nintendo in the
1980s, and has a unique ISA. This CPU would interpret the
first byte 0x04 as the "INC B" instruction, which adds one
to the `B` register. This instruction is only one byte long,
so the CPU would interpret the second byte as a new
instruction. The second byte 0xAA is the "XOR D"
instruction, which updates the `A` register by doing
a bitwise XOR operation with the `D` register.

As you can see, machine code has wildly different results
depending on the ISA of the CPU it is executed on.

So what if we want to run a Gameboy game on a modern desktop
computer? The desktop CPU would not interpret the Gameboy
machine code correctly, because the ISAs are different. We
would need some kind of software that is capable of reading
and excuting Sharp LR35902 machine code, but the software
itself must be compiled for x86-64 in order to run. This is
what emulators are: software that runs other software by
acting like "fake" or "virtual" hardware.

Here's another scenario: what if we want to compile software
so that it can run on all different kinds of CPUs? This was
one of the original goals of the Java programming language.
When James Gosling designed the first version of Java, he
invented a new ISA that we now call Java bytecode. He
implemented the first Java compiler, which converts Java
source code into Java bytecode. He also created the first
Java Virtual Machine (JVM), which is cross-platform software
that runs Java bytecode, similar to an emulator.

The difference between an emulator and a virtual machine is
that an emulator is pretending to be something else. The JVM
was never designed to immitate an existing CPU. In fact, the
opposite is true -- there are now multiple CPUs designed to
run Java bytecode directly, immitating the JVM.

The difference between machine code and bytecode is similar.
Both are binary instruction data, but machine code is
intended to be run by a real CPU, and bytecode is intended
to be run by a virtual machine.

    ----------------------------------------------------

After reading the novel above, you might be concerned about
how complicated this layer is going to be. Don't worry
though, because I'm actually going to give you all the code
necessary to decrypt the payload.

The next layer is encrypted using the infamous Dalling
cipher, which I invented three days ago. It's loosely based
on AES, but the exact details don't matter. The decryption
code provided below already works -- you just need to run
it.

The tricky part is that the provided code is actually
machine code. If you have a Tomtel Core i69 somewhere around
the house, you can use that to run the machine code. If you
don't have one of those, you will need to write an emulator.
There isn't much information about the ISA online, probably
because I invented it two days ago, but I have included a
detailed specification below.

The payload for this layer is bytecode for a program that
outputs the next layer. Create a virtual machine according
to the specification below, and use it to run the payload.


# [ Spec: Overview ]

The Tomtel Core i69 has:

 - 12 registers (see [ Spec: Registers ])
 - a fixed amount of memory (see [ Spec: Memory ])
 - an output stream (see [ Spec: Output ])
 - 13 distinct instructions (see [ Spec: Instruction Set ])

Its patented Advanced Positivity Technology (tm) means that
all values are treated as unsigned integers. There is no
such thing as a negative number on a Tomtel. There is no
floating point arithmetic either. Why would you want things
floating in your computer, anyway? For safety purposes,
Tomtel systems do not contain any liquid.

When running, it does the following in a loop:

 1. Reads one instruction from memory, at the address stored
    in the `pc` register.

 2. Adds the byte size of the instruction to the `pc`
    register.

 3. Executes the instruction.

It continues running until it executes a HALT instruction.
The HALT instruction indicates that the program is finished
and the output stream is complete.


## [ Spec: Example Program ]

Below is the bytecode for an example program, commented with
the corresponding instructions. You can run this program to
test your VM.

The bytecode is in hexadecimal, with whitespace between each
byte. This program outputs the ASCII string "Hello, world!",
and uses every type of instruction at least once.

    50 48  # MVI b <- 72
    C2     # ADD a <- b
    02     # OUT a
    A8 4D 00 00 00  # MVI32 ptr <- 0x0000004d
    4F     # MV a <- (ptr+c)
    02     # OUT a
    50 09  # MVI b <- 9
    C4     # XOR a <- b
    02     # OUT a
    02     # OUT a
    E1 01  # APTR 0x00000001
    4F     # MV a <- (ptr+c)
    02     # OUT a
    C1     # CMP
    22 1D 00 00 00  # JNZ 0x0000001d
    48 30  # MVI a <- 48
    02     # OUT a
    58 03  # MVI c <- 3
    4F     # MV a <- (ptr+c)
    02     # OUT a
    B0 29 00 00 00  # MVI32 pc <- 0x00000029
    48 31  # MVI a <- 49
    02     # OUT a
    50 0C  # MVI b <- 12
    C3     # SUB a <- b
    02     # OUT a
    AA     # MV32 ptr <- lb
    57     # MV b <- (ptr+c)
    48 02  # MVI a <- 2
    C1     # CMP
    21 3A 00 00 00  # JEZ 0x0000003a
    48 32  # MVI a <- 50
    02     # OUT a
    48 77  # MVI a <- 119
    02     # OUT a
    48 6F  # MVI a <- 111
    02     # OUT a
    48 72  # MVI a <- 114
    02     # OUT a
    48 6C  # MVI a <- 108
    02     # OUT a
    48 64  # MVI a <- 100
    02     # OUT a
    48 21  # MVI a <- 33
    02     # OUT a
    01     # HALT
    65 6F 33 34 2C  # non-instruction data


## [ Spec: Registers ]

The Tomtel Core i69 is a register machine. It has six 8-bit
registers and another six 32-bit registers for a total of 12
registers.

All registers are initialized to zero when the machine
starts.

All registers hold unsigned integers.

The 8-bit registers are:

    `a`  Accumulation register -- Used to store the result
         of various instructions.

    `b`  Operand register -- This is 'right hand side' of
         various operations.

    `c`  Count/offset register -- Holds an offset or index
         value that is used when reading memory.

    `d`  General purpose register

    `e`  General purpose register

    `f`  Flags register -- Holds the result of the
         comparison instruction (CMP), and is used by
         conditional jump instructions (JEZ, JNZ).

The 32-bit registers are:

    `la`   General purpose register

    `lb`   General purpose register

    `lc`   General purpose register

    `ld`   General purpose register

    `ptr`  Pointer to memory -- holds a memory address which
           is used by instructions that read or write
           memory.

    `pc`   Program counter -- holds a memory address that
           points to the next instruction to be executed.

In addition to these 12 registers, there is an 8-bit
pseudo-register used to read and write memory. This is only
used by the 8-bit move instructions (MV, MVI).

    `(ptr+c)`  Memory cursor -- Used to access one byte of
               memory. Using this pseudo-register as the
               {dst} of a move instruction will write to
               memory. Using this as the {src} of a move
               instruction will read from memory. The memory
               address of the byte to be read/written is the
               sum of the `ptr` and `c` registers.


## [ Spec: Memory ]

The Tomtel Core i69 has a fixed amount of memory. Whatever
the size of this layer's payload is, that's how much memory
is needed.

Memory is mutable. Any byte of memory can be read, written,
or executed as an instruction.

Output is not stored in memory.


## [ Spec: Output ]

The Tomtel Core i69 produces output, one byte at a time,
using the OUT instruction. Every time the OUT instruction is
executed, one byte is appended to the output stream.

Theoretically, there is no limit to how much output can be
generated, but I can guarantee that the correct output is
smaller than the size of the payload.

The output is complete when the VM stops due to executing
the HALT instruction.


## [ Spec: Instruction Set ]

Below are the details for every instruction that the Tomtel
Core i69 supports.

If the VM attempts to execute an instruction that is not
specified here, then something is wrong with the
implementation of the VM. There are non-instruction bytes in
the payload, but the bytecode is written such that they will
never be executed.

Every instruction has a name that looks like assembly
language. The parts of the name have the following format:

    ADD, SUB, XOR, ...
      The type of the instruction is always first, in
      uppercase.

    a, b, c, ptr, pc, ...
      Registers are referred to by their name, in lower
      case.

    <-
      Arrows indicate that the value on the left is being
      updated using the value on the right. This is just to
      help clarify instructions that involve two registers,
      indicating which register will be changed, and which
      will not.

    {dest}, {src}
      Register arguments have curly brackets. These are
      variables that represent a register/pseudo-register.
      The meaning and allowed values are explained in the
      documentation for that specific instruction.

    imm8, imm32
      Immediate values are represented with "imm" followed
      by their bit size. These are instruction arguments
      stored in the bytes immediately following the first
      byte of the instruction. "imm8" is a one-byte unsigned
      integer, and "imm32" is a four-byte unsigned integer
      in little-endian byte order. The documentation for the
      instruction explains how the immediate arguments are
      used.

Every instruction specifies its opcode, which is the binary
format of the instruction, as you will encounter it in the
payload. The bytes of the opcode are separated by spaces,
and have one of the following formats:

    0xAA
      A constant byte value, in hexadecimal format. Most
      instructions can identified by their unique first
      byte.

    0x__
      A placeholder byte for an immediate value. A single
      one of these represents an 8-bit immediate value. Four
      of these in a row represents a 32-bit immediate value
      in little-endian byte order.

    0b11DDDSSS
      A byte with variable argument bits, in binary format.
      Bits marked as "0" or "1" are constant, and can be
      used to identify the instruction. Consecutive bits
      marked with the same letter, like "DDD", correspond to
      an argument that is specific to the instruction. Read
      the instruction documentation for details about how to
      interpret the arguments.

Without further ado, here are the instructions:


--[ ADD a <- b ]--------------------------------------------

  8-bit addition
  Opcode: 0xC2 (1 byte)

  Sets `a` to the sum of `a` and `b`, modulo 256.


--[ APTR imm8 ]---------------------------------------------

  Advance ptr
  Opcode: 0xE1 0x__ (2 bytes)

  Sets `ptr` to the sum of `ptr` and `imm8`. Overflow
  behaviour is undefined.


--[ CMP ]---------------------------------------------------

  Compare
  Opcode: 0xC1 (1 byte)

  Sets `f` to zero if `a` and `b` are equal, otherwise sets
  `f` to 0x01.


--[ HALT ]--------------------------------------------------

  Halt execution
  Opcode: 0x01 (1 byte)

  Stops the execution of the virtual machine. Indicates that
  the program has finished successfully.


--[ JEZ imm32 ]---------------------------------------------

  Jump if equals zero
  Opcode: 0x21 0x__ 0x__ 0x__ 0x__ (5 bytes)

  If `f` is equal to zero, sets `pc` to `imm32`. Otherwise
  does nothing.


--[ JNZ imm32 ]---------------------------------------------

  Jump if not zero
  Opcode: 0x22 0x__ 0x__ 0x__ 0x__ (5 bytes)

  If `f` is not equal to zero, sets `pc` to `imm32`.
  Otherwise does nothing.


--[ MV {dest} <- {src} ]------------------------------------

  Move 8-bit value
  Opcode: 0b01DDDSSS (1 byte)

  Sets `{dest}` to the value of `{src}`.

  Both `{dest}` and `{src}` are 3-bit unsigned integers that
  correspond to an 8-bit register or pseudo-register. In the
  opcode format above, the "DDD" bits are `{dest}`, and the
  "SSS" bits are `{src}`. Below are the possible valid
  values (in decimal) and their meaning.

                          1 => `a`
                          2 => `b`
                          3 => `c`
                          4 => `d`
                          5 => `e`
                          6 => `f`
                          7 => `(ptr+c)`

  A zero `{src}` indicates an MVI instruction, not MV.


--[ MV32 {dest} <- {src} ]----------------------------------

  Move 32-bit value
  Opcode: 0b10DDDSSS (1 byte)

  Sets `{dest}` to the value of `{src}`.

  Both `{dest}` and `{src}` are 3-bit unsigned integers that
  correspond to a 32-bit register. In the opcode format
  above, the "DDD" bits are `{dest}`, and the "SSS" bits are
  `{src}`. Below are the possible valid values (in decimal)
  and their meaning.

                          1 => `la`
                          2 => `lb`
                          3 => `lc`
                          4 => `ld`
                          5 => `ptr`
                          6 => `pc`


--[ MVI {dest} <- imm8 ]------------------------------------

  Move immediate 8-bit value
  Opcode: 0b01DDD000 0x__ (2 bytes)

  Sets `{dest}` to the value of `imm8`.

  `{dest}` is a 3-bit unsigned integer that corresponds to
  an 8-bit register or pseudo-register. It is the "DDD" bits
  in the opcode format above. Below are the possible valid
  values (in decimal) and their meaning.

                          1 => `a`
                          2 => `b`
                          3 => `c`
                          4 => `d`
                          5 => `e`
                          6 => `f`
                          7 => `(ptr+c)`


--[ MVI32 {dest} <- imm32 ]---------------------------------

  Move immediate 32-bit value
  Opcode: 0b10DDD000 0x__ 0x__ 0x__ 0x__ (5 bytes)

  Sets `{dest}` to the value of `imm32`.

  `{dest}` is a 3-bit unsigned integer that corresponds to a
  32-bit register. It is the "DDD" bits in the opcode format
  above. Below are the possible valid values (in decimal)
  and their meaning.

                          1 => `la`
                          2 => `lb`
                          3 => `lc`
                          4 => `ld`
                          5 => `ptr`
                          6 => `pc`


--[ OUT a ]-------------------------------------------------

  Output byte
  Opcode: 0x02 (1 byte)

  Appends the value of `a` to the output stream.


--[ SUB a <- b ]--------------------------------------------

  8-bit subtraction
  Opcode: 0xC3 (1 byte)

  Sets `a` to the result of subtracting `b` from `a`. If
  subtraction would result in a negative number, 256 is
  added to ensure that the result is non-negative.


--[ XOR a <- b ]--------------------------------------------

  8-bit bitwise exclusive OR
  Opcode: 0xC4 (1 byte)

  Sets `a` to the bitwise exclusive OR of `a` and `b`.