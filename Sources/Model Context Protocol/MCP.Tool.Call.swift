public import JSON_RPC_Standard
public import RFC_8259

extension MCP.Tool {
    public struct Call: Sendable, Hashable {
        public var name: String
        public var arguments: RFC_8259.Object

        public init(name: String, arguments: RFC_8259.Object = RFC_8259.Object()) {
            self.name = name
            self.arguments = arguments
        }
    }
}

extension MCP.Tool.Call {
    public init(_ params: RFC_8259.Value?) throws(JSON_RPC.Error) {
        guard let name = params?["name"]?.string else {
            throw JSON_RPC.Error(code: .invalidParams, message: "missing tool name")
        }
        self.init(name: name, arguments: params?["arguments"]?.object ?? RFC_8259.Object())
    }
}
