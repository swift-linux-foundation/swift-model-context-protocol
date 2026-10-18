public import RFC_8259

extension MCP.Tool.List {
    public struct Result: Sendable, Hashable {
        public var tools: [MCP.Tool]
        public var nextCursor: String?

        public init(tools: [MCP.Tool], nextCursor: String? = nil) {
            self.tools = tools
            self.nextCursor = nextCursor
        }
    }
}

extension MCP.Tool.List.Result {
    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = [
            ("tools", .array(RFC_8259.Array(tools.map(\.value))))
        ]
        if let nextCursor { members.append(("nextCursor", .string(nextCursor))) }
        return .object(RFC_8259.Object(members))
    }
}
