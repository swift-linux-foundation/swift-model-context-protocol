extension MCP {
    public struct Version: RawRepresentable, Sendable, Hashable {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension MCP.Version: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

extension MCP.Version {
    public static let all: [MCP.Version] = ["2025-11-25", "2025-06-18", "2025-03-26", "2024-11-05"]
}

extension MCP.Version: Comparable {
    /// Versions are `YYYY-MM-DD` dates, so the later date is the greater version.
    public static func < (lhs: MCP.Version, rhs: MCP.Version) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
