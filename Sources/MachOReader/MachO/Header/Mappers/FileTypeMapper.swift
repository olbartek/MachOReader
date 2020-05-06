import MachO.loader

internal class FileTypeMapper: Mapper {
    
    internal func map(input: UInt32) throws -> FileType {
        let fileType = Int32(input)
        
        let kind: FileType.Kind
        switch fileType {
        case MH_OBJECT:
            kind = .object
        case MH_EXECUTE:
            kind = .execute
        case MH_FVMLIB:
            kind = .fvmlib
        case MH_CORE:
            kind = .core
        case MH_PRELOAD:
            kind = .preload
        case MH_DYLIB:
            kind = .dylib
        case MH_DYLINKER:
            kind = .dylinker
        case MH_BUNDLE:
            kind = .bundle
        case MH_DYLIB_STUB:
            kind = .dylibStub
        case MH_DSYM:
            kind = .dsym
        case MH_KEXT_BUNDLE:
            kind = .kextBundle
        default:
            throw Error.unknownFileType
        }
        
        return FileType(value: input, kind: kind)
    }
    
    internal enum Error: Swift.Error {
        case unknownFileType
    }
}
