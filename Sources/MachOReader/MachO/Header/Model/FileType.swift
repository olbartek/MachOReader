internal struct FileType {
    internal enum Kind: UInt32 {
        case object         /* relocatable object file */
        case execute        /* demand paged executable file */
        case fvmlib         /* fixed VM shared library file */
        case core           /* core file */
        case preload        /* preloaded executable file */
        case dylib          /* dynamically bound shared library */
        case dylinker       /* dynamic link editor */
        case bundle         /* dynamically bound bundle file */
        case dylibStub      /* shared library stub for static */
                            /*  linking only, no section contents */
        case dsym           /* companion file with only debug */
                            /*  sections */
        case kextBundle     /* x86_64 kexts */
    }
    
    internal let value: UInt32
    internal let kind: Kind
    
    internal init(value: UInt32, kind: Kind) {
        self.value = value
        self.kind = kind
    }
}

extension FileType: HexStringConvertible, CustomStringConvertible {
    internal var hexDescription: String {
        return value.hexDescription
    }
    
    internal var description: String {
        switch kind {
        case .object:
            return "MH_OBJECT"
        case .execute:
            return "MH_EXECUTE"
        case .fvmlib:
            return "MH_FVMLIB"
        case .core:
            return "MH_CORE"
        case .preload:
            return "MH_PRELOAD"
        case .dylib:
            return "MH_DYLIB"
        case .dylinker:
            return "MH_DYLINKER"
        case .bundle:
            return "MH_BUNDLE"
        case .dylibStub:
            return "MH_DYLIB_STUB"
        case .dsym:
            return "MH_DSYM"
        case .kextBundle:
            return "MH_KEXT_BUNDLE"
        }
    }
}
