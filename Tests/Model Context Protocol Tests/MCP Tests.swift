import JSON_RPC_Standard
import Model_Context_Protocol
import RFC_8259
import Testing

@Suite
struct `MCP Tests` {

    @Test
    func `the newest revision comes first`() {
        #expect(MCP.Version.all.first == "2025-11-25")
        #expect(MCP.Version.all.map(\.rawValue) == MCP.Version.all.map(\.rawValue).sorted(by: >))
    }

    @Test
    func `methods carry the specified names`() {
        #expect(
            [MCP.Method.initialize, .initialized, .ping, .toolsList, .toolsCall].map(\.rawValue)
                == ["initialize", "notifications/initialized", "ping", "tools/list", "tools/call"]
        )
    }

    @Test
    func `initialize parameters read the version and client`() throws {
        let parameters = try MCP.Initialize.Parameters([
            "protocolVersion": "2025-06-18", "capabilities": [:],
            "clientInfo": ["name": "c", "version": "1"],
        ])
        #expect(parameters.protocolVersion == "2025-06-18")
        #expect(parameters.clientInfo == MCP.Implementation(name: "c", version: "1"))
    }

    @Test
    func `initialize without a version is invalid params`() {
        #expect(throws: JSON_RPC.Error(code: .invalidParams, message: "missing protocolVersion")) {
            try MCP.Initialize.Parameters(["capabilities": [:]])
        }
    }

    @Test
    func `the initialize result names the server and its capabilities`() {
        let result = MCP.Initialize.Result(
            protocolVersion: "2025-11-25",
            capabilities: MCP.Capabilities(tools: MCP.Capabilities.Tools()),
            serverInfo: MCP.Implementation(name: "s", version: "1"),
            instructions: "Be kind."
        )
        #expect(
            result.value == [
                "protocolVersion": "2025-11-25",
                "capabilities": ["tools": ["listChanged": false]],
                "serverInfo": ["name": "s", "version": "1"],
                "instructions": "Be kind.",
            ]
        )
    }

    @Test
    func `a tool lists its schema and annotations`() {
        let tool = MCP.Tool(
            name: "echo",
            description: "Echoes.",
            inputSchema: ["type": "object"],
            annotations: MCP.Tool.Annotations(readOnlyHint: true)
        )
        #expect(
            MCP.Tool.List.Result(tools: [tool]).value == [
                "tools": [
                    [
                        "name": "echo", "description": "Echoes.", "inputSchema": ["type": "object"],
                        "annotations": ["readOnlyHint": true],
                    ]
                ]
            ]
        )
    }

    @Test
    func `a call reads the tool name and defaults to no arguments`() throws {
        let call = try MCP.Tool.Call(["name": "echo"])
        #expect(call.name == "echo")
        #expect(call.arguments.isEmpty)
        #expect(
            try MCP.Tool.Call(["name": "echo", "arguments": ["text": "hi"]]).arguments["text"]
                == "hi"
        )
    }

    @Test
    func `a call without a name is invalid params`() {
        #expect(throws: JSON_RPC.Error(code: .invalidParams, message: "missing tool name")) {
            try MCP.Tool.Call(nil)
        }
    }

    @Test
    func `a call result carries content, structured content and the error flag`() {
        let result = MCP.Tool.Call.Result(
            content: [.text("hi")],
            structuredContent: ["said": "hi"],
            isError: true
        )
        #expect(
            result.value == [
                "content": [["type": "text", "text": "hi"]], "structuredContent": ["said": "hi"],
                "isError": true,
            ]
        )
    }
}
