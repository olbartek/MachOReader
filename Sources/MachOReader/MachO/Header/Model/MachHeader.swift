internal enum MachHeader {
    case arch32(MachHeader32)
    case arch64(MachHeader64)
}

extension MachHeader: CustomStringConvertible, HexStringConvertible {
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

internal struct MachHeader32 {
    internal let magic: Magic
    internal let cpu: CPU
    internal let cpuSubType: CPUSubType
    internal let fileType: FileType
    internal let numberOfCommands: Int
    internal let sizeOfCommands: Int
    internal let flags: Flags
}

extension MachHeader32: CustomStringConvertible, HexStringConvertible {
    internal var description: String {
        return ["MachO Header 32bit", propertiesDescription].joined(separator: "\n")
    }
    
    internal var hexDescription: String {
        return ["Macho Header 32bit", propertiesHexDescription].joined(separator: "\n")
    }
}

internal struct MachHeader64 {
    internal let magic: Magic
    internal let cpu: CPU
    internal let cpuSubType: CPUSubType
    internal let fileType: FileType
    internal let numberOfCommands: Int
    internal let sizeOfCommands: Int
    internal let flags: Flags
    internal let reserved: UInt32
}

extension MachHeader64: CustomStringConvertible, HexStringConvertible {
    internal var description: String {
        return ["MachO Header 64bit", propertiesDescription].joined(separator: "\n")
    }
    
    internal var hexDescription: String {
        return ["Macho Header 64bit", propertiesHexDescription].joined(separator: "\n")
    }
}
