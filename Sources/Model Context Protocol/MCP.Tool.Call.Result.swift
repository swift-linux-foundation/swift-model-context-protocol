public import RFC_8259

extension MCP.Tool.Call {
    /// What a tool returns. A failing tool reports `isError` here, not as a protocol error,
    /// so the model can see what went wrong.
    public struct Result: Sendable, Hashable {
        public var content: [MCP.Content]
        /// The result as a JSON value, matching the tool's output schema when it has one.
        public var structuredContent: RFC_8259.Value?
        public var isError: Bool

        public init(content: [MCP.Content], structuredContent: RFC_8259.Value? = nil, isError: Bool = false) {
            self.content = content
            self.structuredContent = structuredContent
            self.isError = isError
        }
    }
}

extension MCP.Tool.Call.Result {
    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = [("content", .array(RFC_8259.Array(content.map(\.value))))]
        if let structuredContent { members.append(("structuredContent", structuredContent)) }
        members.append(("isError", .bool(isError)))
        return .object(RFC_8259.Object(members))
    }
}
