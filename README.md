# swift-model-context-protocol

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-linux-foundation/swift-model-context-protocol/workflows/CI/badge.svg)](https://github.com/swift-linux-foundation/swift-model-context-protocol/actions/workflows/ci.yml)

Model Context Protocol specification types for Swift.

## Overview

swift-model-context-protocol models the server side of the [Model Context Protocol](https://modelcontextprotocol.io), a project of the Linux Foundation's Agentic AI Foundation, on top of [swift-json-rpc-standard](https://github.com/swift-standards/swift-json-rpc-standard). Messages are values of `RFC_8259.Value`.

The scope is tools only:

- `MCP.Version` (the published revisions, newest first) and `MCP.Method`;
- `MCP.Initialize.Parameters` and `MCP.Initialize.Result`, with `MCP.Implementation` and `MCP.Capabilities`;
- `MCP.Tool` with `MCP.Tool.Annotations`, `MCP.Tool.List.Result`;
- `MCP.Tool.Call` and `MCP.Tool.Call.Result`, with text `MCP.Content`.

Resources, prompts, sampling, other content kinds and client requests are not modelled. A server that answers JSON-RPC lines with these types is [swift-mcp](https://github.com/swift-compositions/swift-mcp).

## Products

- `Model Context Protocol` (module `Model_Context_Protocol`).

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-linux-foundation/swift-model-context-protocol.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Model Context Protocol", package: "swift-model-context-protocol"),
    ]
)
```

## Quick Start

```swift
import Model_Context_Protocol

let tool = MCP.Tool(
    name: "echo",
    description: "Echoes its text.",
    inputSchema: ["type": "object", "properties": ["text": ["type": "string"]]],
    annotations: MCP.Tool.Annotations(readOnlyHint: true)
)
MCP.Tool.List.Result(tools: [tool]).value
```

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
