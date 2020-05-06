internal struct Flags: CustomStringConvertible, HexStringConvertible {
    internal enum Flag: UInt32, CaseIterable, CustomStringConvertible {
        case MH_NOUNDEFS                 = 0x1
        case MH_INCRLINK                 = 0x2
        case MH_DYLDLINK                 = 0x4
        case MH_BINDATLOAD               = 0x8
        case MH_PREBOUND                 = 0x10
        case MH_SPLIT_SEGS               = 0x20
        case MH_LAZY_INIT                = 0x40
        case MH_TWOLEVEL                 = 0x80
        case MH_FORCE_FLAT               = 0x100
        case MH_NOMULTIDEFS              = 0x200
        case MH_NOFIXPREBINDING          = 0x400
        case MH_PREBINDABLE              = 0x800
        case MH_ALLMODSBOUND             = 0x1000
        case MH_SUBSECTIONS_VIA_SYMBOLS  = 0x2000
        case MH_CANONICAL                = 0x4000
        case MH_WEAK_DEFINES             = 0x8000
        case MH_BINDS_TO_WEAK            = 0x10000
        case MH_ALLOW_STACK_EXECUTION    = 0x20000
        case MH_ROOT_SAFE                = 0x40000
        case MH_SETUID_SAFE              = 0x80000
        case MH_NO_REEXPORTED_DYLIBS     = 0x100000
        case MH_PIE                      = 0x200000
        case MH_DEAD_STRIPPABLE_DYLIB    = 0x400000
        case MH_HAS_TLV_DESCRIPTORS      = 0x800000
        case MH_NO_HEAP_EXECUTION        = 0x1000000
        
        internal var description: String {
            switch self {
            case .MH_NOUNDEFS:
                return "MH_NOUNDEFS"
            case .MH_INCRLINK:
                return "MH_INCRLINK"
            case .MH_DYLDLINK:
                return "MH_DYLDLINK"
            case .MH_BINDATLOAD:
                return "MH_BINDATLOAD"
            case .MH_PREBOUND:
                return "MH_PREBOUND"
            case .MH_SPLIT_SEGS:
                return "MH_SPLIT_SEGS"
            case .MH_LAZY_INIT:
                return "MH_LAZY_INIT"
            case .MH_TWOLEVEL:
                return "MH_TWOLEVEL"
            case .MH_FORCE_FLAT:
                return "MH_FORCE_FLAT"
            case .MH_NOMULTIDEFS:
                return "MH_NOMULTIDEFS"
            case .MH_NOFIXPREBINDING:
                return "MH_NOFIXPREBINDING"
            case .MH_PREBINDABLE:
                return "MH_PREBINDABLE"
            case .MH_ALLMODSBOUND:
                return "MH_ALLMODSBOUND"
            case .MH_SUBSECTIONS_VIA_SYMBOLS:
                return "MH_SUBSECTIONS_VIA_SYMBOLS"
            case .MH_CANONICAL:
                return "MH_CANONICAL"
            case .MH_WEAK_DEFINES:
                return "MH_WEAK_DEFINES"
            case .MH_BINDS_TO_WEAK:
                return "MH_BINDS_TO_WEAK"
            case .MH_ALLOW_STACK_EXECUTION:
                return "MH_ALLOW_STACK_EXECUTION"
            case .MH_ROOT_SAFE:
                return "MH_ROOT_SAFE"
            case .MH_SETUID_SAFE:
                return "MH_SETUID_SAFE"
            case .MH_NO_REEXPORTED_DYLIBS:
                return "MH_NO_REEXPORTED_DYLIBS"
            case .MH_PIE:
                return "MH_PIE"
            case .MH_DEAD_STRIPPABLE_DYLIB:
                return "MH_DEAD_STRIPPABLE_DYLIB"
            case .MH_HAS_TLV_DESCRIPTORS:
                return "MH_HAS_TLV_DESCRIPTORS"
            case .MH_NO_HEAP_EXECUTION:
                return "MH_NO_HEAP_EXECUTION"
            }
        }
    }
    
    private let value: UInt32
    private let flags: [Flag]

    internal var hexDescription: String {
        return value.hexDescription
    }

    internal var description: String {
        return flags
            .map { $0.description }
            .joined(separator: " | ")
    }

    internal init(value: UInt32) {
        self.value = value
        self.flags = Self.flags(from: value)
    }
    
    private static func flags(from value: UInt32) -> [Flag] {
        var flags = [Flag]()
        
        for flag in Flag.allCases {
            if (value & flag.rawValue == flag.rawValue) {
                flags.append(flag)
            }
        }
        
        return flags
    }
}
