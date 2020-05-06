import Foundation
import ArgumentParser

struct MachOReader: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "machoreader",
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
        guard let _ = FileHandle(forReadingAtPath: filePath) else {
            throw ValidationError("'<file-path>' must point to the existing executable.")
        }
    }
    
    func run() throws {
        print("File path:")
        print(filePath)
    }
}

MachOReader.main()
