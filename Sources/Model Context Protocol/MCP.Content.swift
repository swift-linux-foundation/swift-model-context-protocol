public import RFC_8259

extension MCP {
    /// A block of content in a tool result. Only text is modelled.
    public enum Content: Sendable, Hashable {
        case text(String)
    }
}

extension MCP.Content {
    public var value: RFC_8259.Value {
        switch self {
        case .text(let text): .object(RFC_8259.Object([("type", "text"), ("text", .string(text))]))
        }
    }
}
