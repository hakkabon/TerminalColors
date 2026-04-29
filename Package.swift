// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TerminalColors",
    products: [
        .library(
            name: "TerminalColors",
            targets: ["TerminalColors"]),
    ],
    targets: [
        .target(
            name: "TerminalColors"),
        .testTarget(
            name: "TerminalColorsTests",
            dependencies: ["TerminalColors"]
        ),
    ]
)
