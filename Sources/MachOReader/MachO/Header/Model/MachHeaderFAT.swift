internal struct MachHeaderFAT {
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

extension MachHeaderFAT.Architecture: CustomStringConvertible, HexStringConvertible {
    internal var description: String {
        return cpu.description
    }
    
    internal var hexDescription: String {
        return cpu.hexDescription
    }
}

extension MachHeaderFAT: CustomStringConvertible, HexStringConvertible {
    internal var description: String {
        return ["MachO FAT Header 64bit", propertiesDescription].joined(separator: "\n")
    }
    
    internal var hexDescription: String {
        return ["Macho FAT Header 64bit", propertiesHexDescription].joined(separator: "\n")
    }
}
