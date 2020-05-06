internal struct CPUSubType {
    private let value: Int32
    
    internal init(value: Int32) {
        self.value = value
    }
}

extension CPUSubType: CustomStringConvertible, HexStringConvertible {
    internal var description: String {
        return value.hexDescription
    }
    
    internal var hexDescription: String {
        return value.hexDescription
    }
}
