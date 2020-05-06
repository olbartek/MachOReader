extension CustomStringConvertible {
    var propertiesDescription: String {
        let mirror = Mirror(reflecting: self)
        
        let descriptionString = mirror.children
            .compactMap { child -> String? in
                guard let propertyName = child.label,
                    let propertyValue = child.value as? CustomStringConvertible else {
                    return nil
                }
                
                return "\(propertyName): \(propertyValue.description)"
            }
            .joined(separator: "\n")
        
        return descriptionString
    }
}
