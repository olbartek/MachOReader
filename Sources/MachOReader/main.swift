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
    
    @Flag(name: .shortAndLong, help: "Print raw values.")
    private var raw: Bool

    func validate() throws {
        guard let _ = FileHandle(forReadingAtPath: filePath) else {
            throw ValidationError("'<file-path>' must point to the existing executable.")
        }
    }
    
    func run() throws {
        let machReader = try MachReader(filePath: filePath)
        
        if header {
            let machHeader = try machReader.readHeader()
            printNewLine()
            print(raw ? machHeader.hexDescription : machHeader.description)
        }
        
        if fat {
            let fatHeader = try machReader.readFATHeader()
            printNewLine()
            print(raw ? fatHeader.hexDescription : fatHeader.description)
        }
    }
    
    private func printNewLine() {
        print("\n")
    }
}

MachOReader.main()
