import MachO.loader

internal class CPUMapper: Mapper {
    private let cpuTypeMask: Int32 = 0xff
    private let cpuArch64bitMask: Int32 = CPU_ARCH_ABI64
    
    internal func map(input: cpu_type_t) throws -> CPU {
        let cpuTypeRaw: Int32 = input & cpuTypeMask
        
        guard let cpuType = CPU.CPUType(rawValue: cpuTypeRaw) else {
            throw Error.unknownCpuType
        }
        
        let is64Bit = (input & cpuArch64bitMask) == cpuArch64bitMask
        
        return CPU(value: input, type: cpuType, is64Bit: is64Bit)
    }
    
    internal enum Error: Swift.Error {
        case unknownCpuType
    }
}
