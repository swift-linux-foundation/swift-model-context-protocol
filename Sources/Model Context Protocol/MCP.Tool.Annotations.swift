public import RFC_8259

extension MCP.Tool {
    /// Hints about a tool's behaviour. Clients must not rely on them from untrusted servers.
    public struct Annotations: Sendable, Hashable {
        public var title: String?
        /// The tool changes nothing in its environment.
        public var readOnlyHint: Bool?
        /// The tool may destroy something; meaningful only when it is not read-only.
        public var destructiveHint: Bool?
        /// Repeating a call with the same arguments has no further effect.
        public var idempotentHint: Bool?
        /// The tool reaches entities outside a closed domain.
        public var openWorldHint: Bool?

        public init(title: String? = nil, readOnlyHint: Bool? = nil, destructiveHint: Bool? = nil, idempotentHint: Bool? = nil, openWorldHint: Bool? = nil) {
            self.title = title
            self.readOnlyHint = readOnlyHint
            self.destructiveHint = destructiveHint
            self.idempotentHint = idempotentHint
            self.openWorldHint = openWorldHint
        }
    }
}

extension MCP.Tool.Annotations {
    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = []
        if let title { members.append(("title", .string(title))) }
        if let readOnlyHint { members.append(("readOnlyHint", .bool(readOnlyHint))) }
        if let destructiveHint { members.append(("destructiveHint", .bool(destructiveHint))) }
        if let idempotentHint { members.append(("idempotentHint", .bool(idempotentHint))) }
        if let openWorldHint { members.append(("openWorldHint", .bool(openWorldHint))) }
        return .object(RFC_8259.Object(members))
    }
}
