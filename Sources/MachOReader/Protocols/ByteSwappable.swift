import MachO.loader
import MachO.fat

internal protocol ByteSwappable {
    var byteSwapped: Self { get }
}

extension UInt32: ByteSwappable {}

extension fat_header: ByteSwappable {
    var byteSwapped: fat_header {
        var copy = self
        swap_fat_header(&copy, NX_LittleEndian)
        return copy
    }
}

extension fat_arch: ByteSwappable {
    var byteSwapped: fat_arch {
        var copy = self
        swap_fat_arch(&copy, 1, NX_LittleEndian)
        return copy
    }
}

extension fat_arch_64: ByteSwappable {
    var byteSwapped: fat_arch_64 {
        var copy = self
        swap_fat_arch_64(&copy, 1, NX_LittleEndian)
        return copy
    }
}
