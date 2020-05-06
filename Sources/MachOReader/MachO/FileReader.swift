import Foundation

internal final class FileReader {
    private let fileHandle: FileHandle
    
    internal var fileOffset: UInt64 {
        get {
            return fileHandle.offsetInFile
        }
        set {
            fileHandle.seek(toFileOffset: newValue)
        }
    }
    
    internal init(fileHandle: FileHandle) {
        self.fileHandle = fileHandle
    }
    
    internal func read<T>(dataType: T.Type, fileOffset: UInt64 = 0) -> T {
        fileHandle.seek(toFileOffset: fileOffset)
        
        let dataTypeSize = MemoryLayout<T>.size
        let data = fileHandle.readData(ofLength: dataTypeSize)
        
        return data.convert(to: dataType)
    }
}

extension FileReader {
    func read<T>(dataType: T.Type,
                 fileOffset: UInt64 = 0,
                 shouldSwapBytes: Bool) -> T where T: ByteSwappable {
        let readData = read(dataType: dataType, fileOffset: fileOffset)
        
        return shouldSwapBytes ? readData.byteSwapped : readData
    }
}

private extension Data {
    func convert<T>(to type: T.Type) -> T {
        return self.withUnsafeBytes {
            $0.load(as: T.self)
        }
    }
}
