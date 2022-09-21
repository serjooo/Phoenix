// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PackageStringProviderContract",
    products: [
        .library(
            name: "PackageStringProviderContract",
            targets: ["PackageStringProviderContract"])
    ],
    dependencies: [
        .package(path: "../../../Entities/SwiftPackage")
    ],
    targets: [
        .target(
            name: "PackageStringProviderContract",
            dependencies: [
                "SwiftPackage"
            ]
        )
    ]
)