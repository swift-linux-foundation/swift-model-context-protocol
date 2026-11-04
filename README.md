# swift-model-context-protocol

Use this package when you are writing a Model Context Protocol server that offers tools and you want the protocol's messages as Swift values. It reads `initialize` and `tools/call` parameters and builds the results as `RFC_8259.Value`. Start from `MCP.Tool` and `MCP.Tool.Call`. Resources, prompts, sampling, content other than text and client requests are not modelled. For a server that already reads and answers the JSON-RPC lines, use swift-mcp.

## Laws

- `MCP.Version.all` lists the published revisions newest first.
- Reading `initialize` parameters needs only a `protocolVersion` string, and any string is accepted, whether or not it is in `MCP.Version.all`. Without one, reading fails with a JSON-RPC invalid params error.
- `clientInfo` is kept only when it has both a `name` and a `version` string. Otherwise it reads as nil, with no error.
- Reading `tools/call` parameters fails with a JSON-RPC invalid params error when `name` is missing or not a string. Missing `arguments`, or `arguments` that isn't an object, reads as no arguments.
- Every `value` leaves out members whose optional property is nil. `isError` and `listChanged` are always written, even when false.
