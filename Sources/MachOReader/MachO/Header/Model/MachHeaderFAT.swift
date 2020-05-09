internal enum MachHeaderFAT {
    case arch32(MachHeaderFAT32)
    case arch64(MachHeaderFAT64)
}

extension MachHeaderFAT: CustomStringConvertible, HexStringConvertible {
    var description: String {
        switch self {
        case .arch32(let header):
            return header.description
        case .arch64(let header):
            return header.description
        }
    }
    
    var hexDescription: String {
        switch self {
        case .arch32(let header):
            return header.hexDescription
        case .arch64(let header):
            return header.hexDescription
        }
    }
}

internal struct MachHeaderFAT32 {
    internal struct Architecture {
        internal let cpu: CPU
        internal let cpuSubType: CPUSubType
        internal let offset: UInt32
        internal let size: UInt32
        internal let align: UInt32
    }
    
    internal let magic: Magic
    internal let architectures: [Architecture]
}

internal struct MachHeaderFAT64 {
    internal struct Architecture {
        internal let cpu: CPU
        internal let cpuSubType: CPUSubType
        internal let offset: UInt64
        internal let size: UInt64
        internal let align: UInt32
    }
    
    internal let magic: Magic
    internal let architectures: [Architecture]
}

extension MachHeaderFAT32.Architecture: CustomStringConvertible, HexStringConvertible {
    internal var description: String {
        return cpu.description
    }
    
    internal var hexDescription: String {
        return cpu.hexDescription
    }
}

extension MachHeaderFAT32: CustomStringConvertible, HexStringConvertible {
    internal var description: String {
        return ["MachO FAT Header 32bit", propertiesDescription].joined(separator: "\n")
    }
    
    internal var hexDescription: String {
        return ["Macho FAT Header 32bit", propertiesHexDescription].joined(separator: "\n")
    }
}

extension MachHeaderFAT64.Architecture: CustomStringConvertible, HexStringConvertible {
    internal var description: String {
        return cpu.description
    }
    
    internal var hexDescription: String {
        return cpu.hexDescription
    }
}

extension MachHeaderFAT64: CustomStringConvertible, HexStringConvertible {
    internal var description: String {
        return ["MachO FAT Header 64bit", propertiesDescription].joined(separator: "\n")
    }
    
    internal var hexDescription: String {
        return ["Macho FAT Header 64bit", propertiesHexDescription].joined(separator: "\n")
    }
}
