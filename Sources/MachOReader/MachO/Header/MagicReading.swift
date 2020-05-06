internal protocol MagicReading {
    var fileReader: FileReader { get }
    
    func readMagic() throws -> Magic
}

extension MagicReading {
    func readMagic() throws -> Magic {
        let magic = fileReader.read(dataType: UInt32.self)
        
        return try MagicMapper().map(input: magic)
    }
}
