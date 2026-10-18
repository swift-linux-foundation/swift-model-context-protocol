public import RFC_8259

extension MCP {
    /// A tool's definition, as `tools/list` lists it.
    public struct Tool: Sendable, Hashable {
        public var name: String
        public var title: String?
        public var description: String?
        /// A JSON Schema object for the arguments.
        public var inputSchema: RFC_8259.Value
        /// A JSON Schema object for the structured result.
        public var outputSchema: RFC_8259.Value?
        public var annotations: MCP.Tool.Annotations?

        public init(
            name: String,
            title: String? = nil,
            description: String? = nil,
            inputSchema: RFC_8259.Value,
            outputSchema: RFC_8259.Value? = nil,
            annotations: MCP.Tool.Annotations? = nil
        ) {
            self.name = name
            self.title = title
            self.description = description
            self.inputSchema = inputSchema
            self.outputSchema = outputSchema
            self.annotations = annotations
        }
    }
}

extension MCP.Tool {
    public var value: RFC_8259.Value {
        var members: [(key: String, value: RFC_8259.Value)] = [("name", .string(name))]
        if let title { members.append(("title", .string(title))) }
        if let description { members.append(("description", .string(description))) }
        members.append(("inputSchema", inputSchema))
        if let outputSchema { members.append(("outputSchema", outputSchema)) }
        if let annotations { members.append(("annotations", annotations.value)) }
        return .object(RFC_8259.Object(members))
    }
}
