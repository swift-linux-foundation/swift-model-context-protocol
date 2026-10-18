public import RFC_8259

extension MCP.Initialize {
    public struct Result: Sendable, Hashable {
        public var protocolVersion: MCP.Version
        public var capabilities: MCP.Capabilities
        public var serverInfo: MCP.Implementation
        public var instructions: String?

        public init(
            protocolVersion: MCP.Version,
            capabilities: MCP.Capabilities,
            serverInfo: MCP.Implementation,
            instructions: String? = nil
        ) {
            self.protocolVersion = protocolVersion
            self.capabilities = capabilities
            self.serverInfo = serverInfo
            self.instructions = instructions
        }
    }
}

extension MCP.Initialize.Result {
    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = [
            ("protocolVersion", .string(protocolVersion.rawValue)),
            ("capabilities", capabilities.value),
            ("serverInfo", serverInfo.value),
        ]
        if let instructions { members.append(("instructions", .string(instructions))) }
        return .object(RFC_8259.Object(members))
    }
}
