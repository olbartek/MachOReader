import MachO.loader
import MachO.fat

internal class MachHeaderReader: MagicReading {
    internal let fileReader: FileReader
    
    internal init(fileReader: FileReader) {
        self.fileReader = fileReader
    }
    
    internal func readHeader() throws -> MachHeader {
        let magic = try readMagic()
        
        switch magic.fileArchitecture {
        case .arch32bit:
            let header = try read32BitHeader(shouldSwapBytes: magic.shouldSwapBytes)
            return .arch32(header)
        case .arch64bit:
            let header = try read64BitHeader(shouldSwapBytes: magic.shouldSwapBytes)
            return .arch64(header)
        case .fat32bit, .fat64bit:
            throw Error.invalidArchitecture(magic.fileArchitecture)
        }
    }
    
    private func read32BitHeader(shouldSwapBytes: Bool) throws -> MachHeader32 {
        let header = fileReader.read(dataType: mach_header.self,
                                     shouldSwapBytes: shouldSwapBytes)
        
        return MachHeader32(
            magic: try MagicMapper().map(input: header.magic),
            cpu: try CPUMapper().map(input: header.cputype),
            cpuSubType: cpuSubType(value: header.cpusubtype),
            fileType: try FileTypeMapper().map(input: header.filetype),
            numberOfCommands: Int(header.ncmds),
            sizeOfCommands: Int(header.sizeofcmds),
            flags: flags(value: header.flags)
        )
    }
    
    private func read64BitHeader(shouldSwapBytes: Bool) throws -> MachHeader64 {
        let header = fileReader.read(dataType: mach_header_64.self,
                                     shouldSwapBytes: shouldSwapBytes)
        
        return MachHeader64(
            magic: try MagicMapper().map(input: header.magic),
            cpu: try CPUMapper().map(input: header.cputype),
            cpuSubType: cpuSubType(value: header.cpusubtype),
            fileType: try FileTypeMapper().map(input: header.filetype),
            numberOfCommands: Int(header.ncmds),
            sizeOfCommands: Int(header.sizeofcmds),
            flags: flags(value: header.flags),
            reserved: header.reserved
        )
    }
}

private extension MachHeaderReader {
    func cpuSubType(value: Int32) -> CPUSubType {
        return CPUSubType(value: value)
    }
    
    func flags(value: UInt32) -> Flags {
        return Flags(value: value)
    }
}

extension MachHeaderReader {
    internal enum Error: Swift.Error {
        case invalidArchitecture(FileArchitecture)
    }
}
