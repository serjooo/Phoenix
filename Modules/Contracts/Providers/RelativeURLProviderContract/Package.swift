// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "RelativeURLProviderContract",
    products: [
        .library(
            name: "RelativeURLProviderContract",
            targets: ["RelativeURLProviderContract"])
    ],
    targets: [
        .target(
            name: "RelativeURLProviderContract"
        )
    ]
)