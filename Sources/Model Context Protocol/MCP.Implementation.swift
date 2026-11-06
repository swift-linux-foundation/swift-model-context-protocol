public import RFC_8259

extension MCP {
    public struct Implementation: Sendable, Hashable {
        public var name: String
        // swift-linter:disable:next raw concept
        // REASON: MCP's Implementation.version is any string the implementer chooses, and the protocol doesn't constrain it to Version.Semantic or Version.Tools
        public var version: String
        public var title: String?

        // swift-linter:disable:next raw concept
        // REASON: MCP's Implementation.version is any string the implementer chooses, and the protocol doesn't constrain it to Version.Semantic or Version.Tools
        public init(name: String, version: String, title: String? = nil) {
            self.name = name
            self.version = version
            self.title = title
        }
    }
}

extension MCP.Implementation {
    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = [
            ("name", .string(name)), ("version", .string(version)),
        ]
        if let title { members.append(("title", .string(title))) }
        return .object(RFC_8259.Object(members))
    }
}
