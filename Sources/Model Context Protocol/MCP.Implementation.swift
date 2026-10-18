public import RFC_8259

extension MCP {
    /// The name and version of a client or server.
    public struct Implementation: Sendable, Hashable {
        public var name: String
        public var version: String
        public var title: String?

        public init(name: String, version: String, title: String? = nil) {
            self.name = name
            self.version = version
            self.title = title
        }
    }
}

extension MCP.Implementation {
    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = [("name", .string(name)), ("version", .string(version))]
        if let title { members.append(("title", .string(title))) }
        return .object(RFC_8259.Object(members))
    }
}
