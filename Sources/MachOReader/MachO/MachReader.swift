import Foundation

internal class MachReader {
    private let fileReader: FileReader
    
    internal init(filePath: String) throws {
        guard let fileHandle = FileHandle(forReadingAtPath: filePath) else {
            throw Error.invalidPath
        }
        
        self.fileReader = FileReader(fileHandle: fileHandle)
    }
    
    internal func readMagic() throws -> Magic {
        let magic = fileReader.read(dataType: UInt32.self)
        
        return try MagicMapper().map(input: magic)
    }
    
    internal func readHeader(fileOffset: UInt64 = 0) throws -> MachHeader {
        let reader = MachHeaderReader(fileReader: fileReader)
        
        return try reader.readHeader()
    }
    
    internal func readFATHeader() throws -> MachHeaderFAT {
        let reader = MachHeaderFATReader(fileReader: fileReader)
        
        return try reader.readHeader()
    }
    
}

extension MachReader {
    internal enum Error: Swift.Error {
        case invalidPath
    }
}
