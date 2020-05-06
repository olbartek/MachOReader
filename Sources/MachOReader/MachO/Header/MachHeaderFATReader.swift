import MachO.loader
import MachO.fat

internal class MachHeaderFATReader: MagicReading {
    internal let fileReader: FileReader
    
    private var shouldSwapBytes: Bool {
        guard let magic = try? readMagic() else {
            return false
        }
        
        return magic.shouldSwapBytes
    }
    
    internal init(fileReader: FileReader) {
        self.fileReader = fileReader
    }
    
    internal func readHeader() throws -> MachHeaderFAT {
        let magic = try readMagic()
        
        switch magic.fileArchitecture {
        case .arch32bit, .arch64bit:
            throw Error.invalidArchitecture(magic.fileArchitecture)
        case .fat32bit, .fat64bit:
            return try readFATHeader()
        }
    }
    
    private func readFATHeader() throws -> MachHeaderFAT {
        let shouldSwapBytes = try readMagic().shouldSwapBytes
        let header = fileReader.read(dataType: fat_header.self,
                                     shouldSwapBytes: shouldSwapBytes)
        let magic = try MagicMapper().map(input: header.magic)
        let numberOfArchitectures = Int(header.nfat_arch)
        
        let architectures: [MachHeaderFAT.Architecture] = try (0..<numberOfArchitectures)
            .map { _ in
                let fatHeaderArch = try readFATHeaderArchitecure(
                    fileOffset: fileReader.fileOffset,
                    shouldSwapBytes: shouldSwapBytes
                )
                return fatHeaderArch
            }
        
        return MachHeaderFAT(magic: magic, architectures: architectures)
    }
    
    private func readFATHeaderArchitecure(fileOffset: UInt64,
                                          shouldSwapBytes: Bool) throws -> MachHeaderFAT.Architecture {
        let fatArch = fileReader.read(dataType: fat_arch.self,
                                      fileOffset: fileOffset,
                                      shouldSwapBytes: shouldSwapBytes)
                        
        return MachHeaderFAT.Architecture(
            cpu: try CPUMapper().map(input: fatArch.cputype),
            cpuSubType: cpuSubType(value: fatArch.cpusubtype),
            offset: fatArch.offset,
            size: fatArch.size,
            align: fatArch.align
        )
    }
}

private extension MachHeaderFATReader {
    func cpuSubType(value: Int32) -> CPUSubType {
        return CPUSubType(value: value)
    }
    
    func flags(value: UInt32) -> Flags {
        return Flags(value: value)
    }
}

extension MachHeaderFATReader {
    internal enum Error: Swift.Error {
        case invalidArchitecture(FileArchitecture)
    }
}
