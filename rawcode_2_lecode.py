import sys, os

def str2Addr(str):
    if str[:2].upper() == "0X":
        return int(str[2:], 16)
    return int(str)

def bytesToU32(buf, offset, isLE):
    num = 0
    for i in range(4):
        num <<= 8
        if isLE:
            num += buf[offset + 3 - i]
        else:
            num += buf[offset + i]
    return num

def u32ToBytes(buf, offset, val, isLE):
    for i in range(4):
        if isLE:
            buf[offset + i] = (val >> (i * 8)) & 0xFF
        else:
            buf[offset + i] = (val >> ((3 - i) * 8)) & 0xFF

def fileToBytes(fileName):
    f = open(fileName, 'rb')
    dest = f.read()
    f.close()
    return dest

def bytesToFile(buf, fileName):
    try:
        os.makedirs(os.path.dirname(fileName), exist_ok=True)
    except FileNotFoundError:
        pass
    except Exception:
        return False
    try:
        f = open(fileName, 'wb')
        f.write(buf)
        f.close()
    except Exception:
        return False
    return True

if __name__=="__main__":
    if len(sys.argv) < 5:
        print("usage: %s %s %s %s " % (sys.argv[0], "(src lecode-XXX.bin)", "(src rawcode)", "(srcrawcode base addr)", "(output lecode-XXX.bin)"))
        sys.exit()
    baseLeBin = bytearray(fileToBytes(sys.argv[1]))
    baseLeBinAddr = bytesToU32(baseLeBin, 0xC, False)
    baseRawcode = bytearray(fileToBytes(sys.argv[2]))
    baseRawcodeAddr = str2Addr((sys.argv[3]))
    offset = baseRawcodeAddr - baseLeBinAddr
    if len(baseLeBin) < offset + len(baseRawcode):
        baseLeBin = baseLeBin + (bytearray([0]) * ((offset + len(baseRawcode)) - len(baseLeBin)))
    for i in range(len(baseRawcode)):
        baseLeBin[offset + i] = baseRawcode[i]
    u32ToBytes(baseLeBin, 0x10, baseRawcodeAddr, False)
    bytesToFile(baseLeBin, sys.argv[4])