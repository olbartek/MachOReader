internal struct Magic {
    internal let value: UInt32
    internal let fileArchitecture: FileArchitecture
    internal let shouldSwapBytes: Bool
    
    internal init(value: UInt32,
                  fileArchitecture: FileArchitecture,
                  shouldSwapBytes: Bool) {
        self.value = value
        self.fileArchitecture = fileArchitecture
        self.shouldSwapBytes = shouldSwapBytes
    }
}

extension Magic: HexStringConvertible, CustomStringConvertible {
    var hexDescription: String {
        return value.hexDescription
    }
    
    var description: String {
        return value.hexDescription
    }
}
