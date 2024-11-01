// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MHModal",
    platforms: [
      .iOS(.v15),
      .macOS(.v12)
    ], products: [
      .library(
        name: "MHModal",
        targets: ["MHModal"])
    ],
    targets: [
        .target(
            name: "MHModal"),
        .testTarget(
            name: "MHModalTests",
            dependencies: ["MHModal"]
        )
    ]
)
