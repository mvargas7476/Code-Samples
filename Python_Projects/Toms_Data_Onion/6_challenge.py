import base64

# Registers and their decriptions
# a Accumulation Register
# b Operand Register
# c Count/offset Register
# d General Purpose Register
# e General Purpose Register
# f Flags Register
# mc Memory Cursor which is the ptr + c
register8 = {'a': 0, 'b': 0, 'c': 0, 'd': 0, 'e': 0, 'f': 0}
reg8map = {1: 'a', 2: 'b', 3: 'c', 4: 'd', 5: 'e', 6: 'f', 7: 'ptr_c'}

# la General Purpose Register
# lb General Purpose Register
# lc General Purpose Register
# ld General Purpose Register
# ptr Pointer to memory
register32 = {'la': 0, 'lb': 0, 'lc': 0, 'ld': 0, 'ptr': 0, 'pc': 0}
reg32map = {1: 'la', 2: 'lb', 3: 'lc', 4: 'ld', 5: 'ptr', 6: 'pc'}

memory = []

# 1 byte
def add ():
    print("ADD {} <-- {}".format(register8['a'], register8['b']))
    register8['a'] = (register8['a'] + register8['b']) % 256

# 2 bytes
def aptr(imm8):
    print("APTR {} <-- {}".format(register32['ptr'], imm8))
    register32['ptr'] = register32['ptr'] + imm8

# 1 byte
def comp():
    print("CMP {} <-- {}".format(register8['a'], register8['b']))
    if register8['a'] == register8['b']:
        register8['f'] = 0 
    else: 
        register8['f'] = 0x01

# 5 bytes
def jez(imm32):
    print("JEZ f:{}  JUMP: {}".format(register8['f'], imm32))
    if register8['f'] == 0:
        register32['pc'] = imm32[3] << 24 | imm32[2] << 16 | imm32[1] << 8 | imm32[0]
        return True
    else:
        return False

# 5 bytes
def jnz(imm32):
    print("JNZ f:{}  JUMP: {}".format(register8['f'], imm32))
    if register8['f'] != 0:
        register32['pc'] = imm32[3] << 24 | imm32[2] << 16 | imm32[1] << 8 | imm32[0]
        return True
    else:
        return False

# 1 byte
def mv(currentbyte):
    # currentbyte is on format 0b01DDDSSS, so we shift and get the destination and the source
    dest = (currentbyte >> 3) & 0b00000111
    source = currentbyte & 0b000000111
    print("MV DDD: {} SSS: {}".format(reg8map[dest], reg8map[source]))
    # if the destination is 7 then we are changing the memory by inserting/reading into/from it
    if dest == 7:
        memory[register32['ptr'] + register8['c']] = register8[reg8map[source]]
    elif source == 7:
        register8[reg8map[dest]] = memory[register32['ptr'] + register8['c']]
    else:
        register8[reg8map[dest]] = register8[reg8map[source]]

# 1 byte
def mv32(currentbyte):
    # currentbyte is on format 0b10DDDSSS, so we shift and get the destination and the source
    dest = (currentbyte >> 3) & 0b00000111
    source = currentbyte & 0b000000111
    print("MV32 DDD: {} SSS: {}".format(reg32map[dest], reg32map[source]))
    register32[reg32map[dest]] = register32[reg32map[source]]
    # If dest is 6 then we are changing the pc register therefore, we have to continue in the while loop below
    if dest == 6:
        return True
    else:
        return False

# 2 bytes
def mvi(currentbyte, imm8):
    # currentbyte is in 0b01DDD000 format, so we pop the last three and the collect the destination with the mask
    dest = (currentbyte >> 3) & 0b00000111
    print("MVI DDD: {} imm: {}".format(reg8map[dest], imm8))
    # if the destination is 7 then we are changing the memory by inserting into it the imm8
    if dest == 7:
        memory[register32['ptr'] + register8['c']] = imm8
    else:
        register8[reg8map[dest]] = imm8

# 5 bytes
def mvi32(currentbyte, imm32):
    # currentbyte is in 0b10DDD000 format, so we pop the last three and the collect the destination with the mask
    dest = (currentbyte >> 3) & 0b00000111
    print("MVI32 DDD: {} imm: {}".format(reg32map[dest], imm32))
    register32[reg32map[dest]] = imm32[3] << 24 | imm32[2] << 16 | imm32[1] << 8 | imm32[0]
    # If dest is 6 then we are changing the pc register therefore, we have to continue in the while loop below
    if dest == 6:
        return True
    else:
        return False

# 1 byte
def out(finalDump):
    print("OUT {}".format(chr(register8['a'])))
    finalDump.append(chr(register8['a']))

# 1 byte
def sub():
    print("SUB {} <-- {}".format(register8['a'], register8['b']))
    register8['a'] -= register8['b']
    if register8['a'] < 0:
        register8['a'] += 256


# 1 byte
def xor():
    print("XOR {} <-- {}".format(register8['a'], register8['b']))
    register8['a'] = register8['a'] ^ register8['b']


if __name__ == "__main__":
    halt = False
    finalDump = []

    with open("Payloads/6_challenge.txt", "r") as prompt:
        file = prompt.read()

    decodedFile = base64.a85decode(file)
    memory = []
    for d in decodedFile:
        memory.append(d)

    while not halt:
        pc = register32['pc']
        currentByte = memory[pc]
        # Continue to loop until you reach the halt instruction
        # You check the current byte, and then increase the pc. 
        # If the opcode requires more bytes, they are set in the respective if and the pc is adjusted as needed.
        # There are some opcodes that actively change the pc register, if thats the case the pc gets updated
        # and then a continue is used to skip the avoid changing the new pc
        if currentByte & 0b11000000 == 0b01000000:
            if (currentByte & 0b11000111 == 0b01000000):
                imm8 = memory[pc + 1]
                mvi(currentByte, imm8)
                pc += 1
            else:
                mv(currentByte)
        elif currentByte & 0b11000000 == 0b10000000:
            if (currentByte & 0b11000111 == 0b10000000):
                imm32 = [memory[pc + 1], memory[pc + 2], memory[pc + 3], memory[pc + 4]]
                newPcCheck = mvi32(currentByte, imm32)
                if newPcCheck:
                    continue
                else:
                    pc += 4
            else:
                newPcCheck = mv32(currentByte)
                if newPcCheck:
                    continue
        elif currentByte == 0xC2:
            add()
        elif currentByte == 0xE1:
            nextByte = memory[pc + 1]
            aptr(nextByte)
            pc += 1
        elif currentByte == 0xC1:
            comp()
        elif currentByte == 0x01:
            halt = True
        elif currentByte == 0x21:
            imm32 = [memory[pc + 1], memory[pc + 2], memory[pc + 3], memory[pc + 4]]
            newPcCheck = jez(imm32)
            if newPcCheck:
                continue
            else:
                pc += 4
        elif currentByte == 0x22:
            imm32 = [memory[pc + 1], memory[pc + 2], memory[pc + 3], memory[pc + 4]]
            newPcCheck = jnz(imm32)
            if newPcCheck:
                continue
            else:
                pc += 4
        elif currentByte == 0x02:
            out(finalDump)
        elif currentByte == 0xC3:
            sub()
        elif currentByte == 0xC4:
            xor()
        pc += 1
        # In case that the pc was not changed in the loop, we update the pc variable, and update the pc register with it
        register32['pc'] = pc

    with open("The_Core.txt", "w") as nextPrompt:
        for i in finalDump:
            nextPrompt.write("{}".format(i))