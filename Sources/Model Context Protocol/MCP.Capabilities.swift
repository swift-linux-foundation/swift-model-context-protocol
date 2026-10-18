public import RFC_8259

extension MCP {
    public struct Capabilities: Sendable, Hashable {
        public var tools: MCP.Capabilities.Tools?

        public init(tools: MCP.Capabilities.Tools? = nil) {
            self.tools = tools
        }
    }
}

extension MCP.Capabilities {
    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = []
        if let tools { members.append(("tools", tools.value)) }
        return .object(RFC_8259.Object(members))
    }
}
