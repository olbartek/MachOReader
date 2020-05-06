/*
* Machine types known by all.
* Ref https://opensource.apple.com/source/cctools/cctools-836/include/mach/machine.h
*/
internal struct CPU {
    internal enum CPUType: Int32 {
        case VAX = 1
        case ROMP = 2
        case NS32032 = 4
        case NS32332 = 5
        case MC680x0 = 6
        case I386    = 7
        case MIPS    = 8
        case NS32532 = 9
        case HPPA    = 11
        case ARM     = 12
        case MC88000 = 13
        case SPARC   = 14
        case I860    = 15 // big-endian
        case I860_LITTLE = 16 // little-endian
        case RS6000  = 17
        //case MC98000 = 18
        case POWERPC = 18
        case VEO = 255
    }
    
    private let value: Int32
    private let type: CPUType
    internal let is64Bit: Bool
    
    internal init(value: Int32, type: CPUType, is64Bit: Bool) {
        self.value = value
        self.type = type
        self.is64Bit = is64Bit
    }
}

extension CPU: CustomStringConvertible, HexStringConvertible {
    internal var hexDescription: String {
        return value.hexDescription
    }
    
    internal var description: String {
        let archDescription = is64Bit ? "(64bit)" : "(32bit)"
        return "\(typeDescription) \(archDescription)"
    }
    
    private var typeDescription: String {
        switch type {
        case .VAX: return "VAX"
        case .ROMP: return "ROMP"
        case .NS32032: return "NS32032"
        case .NS32332: return "NS32332"
        case .MC680x0: return "MC680x0"
        case .I386: return is64Bit ? "X86_64" : "I386"
        case .MIPS: return "MIPS"
        case .NS32532: return "NS32532"
        case .HPPA: return "HPPA"
        case .ARM: return "ARM"
        case .MC88000: return "MC88000"
        case .SPARC: return "SPARC"
        case .I860: return "I860"
        case .I860_LITTLE: return "I860_LITTLE"
        case .RS6000: return "RS6000"
        case .POWERPC: return is64Bit ? "POWERPC64" : "POWERPC"
        case .VEO: return "VEO"
        }
    }
}
