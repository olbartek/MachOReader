internal protocol Mapper {
    associatedtype Input
    associatedtype Output
    
    func map(input: Input) throws -> Output
}
