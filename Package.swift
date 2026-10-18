// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-model-context-protocol",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Model Context Protocol",
            targets: ["Model Context Protocol"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-json-rpc-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-8259.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Model Context Protocol",
            dependencies: [
                .product(name: "JSON RPC Standard", package: "swift-json-rpc-standard"),
                .product(name: "RFC 8259", package: "swift-rfc-8259"),
            ]
        ),
        .testTarget(
            name: "Model Context Protocol Tests",
            dependencies: [
                .target(name: "Model Context Protocol"),
                .product(name: "JSON RPC Standard", package: "swift-json-rpc-standard"),
                .product(name: "RFC 8259", package: "swift-rfc-8259"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
