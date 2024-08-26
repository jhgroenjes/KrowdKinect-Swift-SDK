// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KrowdKinect-Swift-SDK",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "KrowdKinect-Swift-SDK",
            targets: ["KrowdKinect-Swift-SDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ably/ably-cocoa.git", from: "1.2.33")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "KrowdKinect-Swift-SDK"),
        .testTarget(
            name: "KrowdKinect-Swift-SDKTests",
            dependencies: ["KrowdKinect-Swift-SDK"]),
    ]
)
