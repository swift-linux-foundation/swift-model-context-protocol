public import RFC_8259

extension MCP.Capabilities {
    /// The server offers tools.
    public struct Tools: Sendable, Hashable {
        /// Whether the server notifies clients when its tool list changes.
        public var listChanged: Bool

        public init(listChanged: Bool = false) {
            self.listChanged = listChanged
        }
    }
}

extension MCP.Capabilities.Tools {
    public var value: RFC_8259.Value {
        .object(RFC_8259.Object([("listChanged", .bool(listChanged))]))
    }
}
