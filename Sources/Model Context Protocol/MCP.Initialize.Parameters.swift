public import JSON_RPC_Standard
public import RFC_8259

extension MCP.Initialize {
    /// What the client sends: the revision it wants and who it is.
    public struct Parameters: Sendable, Hashable {
        public var protocolVersion: MCP.Version
        public var clientInfo: MCP.Implementation?

        public init(protocolVersion: MCP.Version, clientInfo: MCP.Implementation? = nil) {
            self.protocolVersion = protocolVersion
            self.clientInfo = clientInfo
        }
    }
}

extension MCP.Initialize.Parameters {
    /// The parameters a request carries, or `invalidParams` without a protocol version.
    public init(_ params: RFC_8259.Value?) throws(JSON_RPC.Error) {
        guard let version = params?["protocolVersion"]?.string else {
            throw JSON_RPC.Error(code: .invalidParams, message: "missing protocolVersion")
        }
        let client = params?["clientInfo"]
        let clientInfo = client?["name"]?.string.flatMap { name in
            client?["version"]?.string.map { MCP.Implementation(name: name, version: $0, title: client?["title"]?.string) }
        }
        self.init(protocolVersion: MCP.Version(rawValue: version), clientInfo: clientInfo)
    }
}
