// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Octarine",
    platforms: [
        .macOS(.v13),
        .iOS(.v14)
    ],
    products: [
        .library(name: "Octarine", targets: ["Octarine"])
    ],
    dependencies: [
        .package(url: "https://github.com/dclelland/Plinth", from: "2.11.0")
    ],
    targets: [
        .target(
            name: "Octarine",
            dependencies: [
                .product(name: "Plinth", package: "Plinth")
            ]
        )
    ]
)
