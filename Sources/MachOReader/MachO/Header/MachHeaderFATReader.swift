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
        case .fat32bit:
            let header = try read32BitFATHeader(shouldSwapBytes: magic.shouldSwapBytes)
            return .arch32(header)
        case .fat64bit:
            let header = try read64BitFATHeader(shouldSwapBytes: magic.shouldSwapBytes)
            return .arch64(header)
        }
    }
    
    private func read32BitFATHeader(shouldSwapBytes: Bool) throws -> MachHeaderFAT32 {
        let header = fileReader.read(dataType: fat_header.self,
                                     shouldSwapBytes: shouldSwapBytes)
        let magic = try MagicMapper().map(input: header.magic)
        let numberOfArchitectures = Int(header.nfat_arch)
        
        let architectures: [MachHeaderFAT32.Architecture] = try (0..<numberOfArchitectures)
            .map { _ in
                let fatHeaderArch = try read32BitFATHeaderArchitecure(
                    fileOffset: fileReader.fileOffset,
                    shouldSwapBytes: shouldSwapBytes
                )
                return fatHeaderArch
            }
        
        return MachHeaderFAT32(magic: magic, architectures: architectures)
    }
    
    private func read32BitFATHeaderArchitecure(fileOffset: UInt64,
                                               shouldSwapBytes: Bool) throws -> MachHeaderFAT32.Architecture {
        let fatArch32 = fileReader.read(dataType: fat_arch.self,
                                        fileOffset: fileOffset,
                                        shouldSwapBytes: shouldSwapBytes)
        
        return MachHeaderFAT32.Architecture(
            cpu: try CPUMapper().map(input: fatArch32.cputype),
            cpuSubType: cpuSubType(value: fatArch32.cpusubtype),
            offset: fatArch32.offset,
            size: fatArch32.size,
            align: fatArch32.align
        )
    }
    
    private func read64BitFATHeader(shouldSwapBytes: Bool) throws -> MachHeaderFAT64 {
        let header = fileReader.read(dataType: fat_header.self,
                                     shouldSwapBytes: shouldSwapBytes)
        let magic = try MagicMapper().map(input: header.magic)
        let numberOfArchitectures = Int(header.nfat_arch)
        
        let architectures: [MachHeaderFAT64.Architecture] = try (0..<numberOfArchitectures)
            .map { _ in
                let fatHeaderArch = try read64BitFATHeaderArchitecture(
                    fileOffset: fileReader.fileOffset,
                    shouldSwapBytes: shouldSwapBytes
                )
                return fatHeaderArch
            }
        
        return MachHeaderFAT64(magic: magic, architectures: architectures)
    }
    
    private func read64BitFATHeaderArchitecture(fileOffset: UInt64,
                                                shouldSwapBytes: Bool) throws -> MachHeaderFAT64.Architecture {
        let fatArch64 = fileReader.read(dataType: fat_arch_64.self,
                                        fileOffset: fileOffset,
                                        shouldSwapBytes: shouldSwapBytes)
        
        return MachHeaderFAT64.Architecture(
            cpu: try CPUMapper().map(input: fatArch64.cputype),
            cpuSubType: cpuSubType(value: fatArch64.cpusubtype),
            offset: fatArch64.offset,
            size: fatArch64.size,
            align: fatArch64.align
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
