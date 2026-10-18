extension MCP {
    public struct Method: RawRepresentable, Sendable, Hashable {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension MCP.Method {
    public static let initialize = Self(rawValue: "initialize")
    public static let initialized = Self(rawValue: "notifications/initialized")
    public static let ping = Self(rawValue: "ping")
    public static let toolsList = Self(rawValue: "tools/list")
    public static let toolsCall = Self(rawValue: "tools/call")
}
