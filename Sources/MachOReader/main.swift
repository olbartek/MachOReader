import Foundation
import ArgumentParser

struct MachOReader: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Mach-O file format reader, written entirely in Swift.",
        subcommands: []
    )
    
    @Argument(help: "The file path of Mach-O executable.")
    private var filePath: String
    
    @Flag(name: .shortAndLong, help: "Read header.")
    private var header: Bool
    
    @Flag(name: .shortAndLong, help: "Read fat header.")
    private var fat: Bool

    func validate() throws {
        let fileManager = FileManager.default
        
        guard fileManager.fileExists(atPath: filePath) else {
            throw ValidationError("'<file-path>' must point to the existing executable.")
        }
    }
    
    func run() {
        
        print(filePath)
        
    }
}

MachOReader.main()
