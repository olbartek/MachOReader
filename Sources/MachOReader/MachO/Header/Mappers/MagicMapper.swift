import MachO.loader

internal class MagicMapper: Mapper {
    internal func map(input: UInt32) throws -> Magic {
        return Magic(
            value: input,
            fileArchitecture: fileArchitecture(magic: input),
            shouldSwapBytes: shouldSwapBytes(magic: input)
        )
    }
    
    private func fileArchitecture(magic: UInt32) -> FileArchitecture {
        if isArch32(magic: magic) {
            return .arch32bit
        }
        if isArch64(magic: magic) {
            return .arch64bit
        }
        if isFATArch32(magic: magic) {
            return .fat32bit
        }
        if isFATArch64(magic: magic) {
            return .fat64bit
        }
        
        fatalError("Undefined architecture read from magic: \(magic.hexDescription)")
    }
    
    private func isArch32(magic: UInt32) -> Bool {
        return magic == MH_MAGIC || magic == MH_CIGAM
    }
    
    private func isArch64(magic: UInt32) -> Bool {
        return magic == MH_MAGIC_64 || magic == MH_CIGAM_64
    }
    
    private func isFATArch32(magic: UInt32) -> Bool {
        return magic == FAT_MAGIC || magic == FAT_CIGAM
    }
    
    private func isFATArch64(magic: UInt32) -> Bool {
        return magic == FAT_MAGIC_64 || magic == FAT_CIGAM_64
    }
    
    private func shouldSwapBytes(magic: UInt32) -> Bool {
        return magic == MH_CIGAM || magic == MH_CIGAM_64
            || magic == FAT_CIGAM || magic == FAT_CIGAM_64
    }
}

// Magic header values:
// (Ref https://opensource.apple.com/source/xnu/xnu-2050.18.24/EXTERNAL_HEADERS/mach-o/loader.h)

/* Constant for the magic fields of the mach_header (32-bit architectures) */
// #define MH_MAGIC    0xfeedface    /* the mach magic number */
// #define MH_CIGAM    0xcefaedfe    /* NXSwapInt(MH_MAGIC) */

/* Constant for the magic field of the mach_header_64 (64-bit architectures) */
//#define MH_MAGIC_64   0xfeedfacf /* the 64-bit mach magic number */
//#define MH_CIGAM_64   0xcffaedfe /* NXSwapInt(MH_MAGIC_64) */
