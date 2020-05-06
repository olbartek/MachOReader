internal protocol HexStringConvertible {
    var hexDescription: String { get }
}

internal extension HexStringConvertible {
    private var hexPrefix: String {
        return "0x"
    }
}

extension HexStringConvertible where Self: BinaryInteger {
    var hexDescription: String {
        return hexPrefix + String(self, radix: 16, uppercase: false)
    }
}

extension HexStringConvertible {
    var propertiesHexDescription: String {
        let mirror = Mirror(reflecting: self)
        
        return mirror.children
            .compactMap { child -> String? in
                guard let propertyName = child.label,
                    let propertyValue = child.value as? HexStringConvertible else {
                    return nil
                }
                
                return "\(propertyName): \(propertyValue.hexDescription)"
            }
            .joined(separator: "\n")
    }
}

extension Array: HexStringConvertible where Element: HexStringConvertible {
    var hexDescription: String {
        let elementsString = self.map { $0.hexDescription }.joined(separator: ", ")
        return "[\(elementsString)]"
    }
}

extension Int: HexStringConvertible {}
extension Int8: HexStringConvertible {}
extension Int16: HexStringConvertible {}
extension Int32: HexStringConvertible {}
extension Int64: HexStringConvertible {}
extension UInt: HexStringConvertible {}
extension UInt8: HexStringConvertible {}
extension UInt16: HexStringConvertible {}
extension UInt32: HexStringConvertible {}
extension UInt64: HexStringConvertible {}


