// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "imagegallery-to-summarytable",
    platforms: [
            .macOS(.v10_15),
    ],
    products: [
        .executable(name: "imagegallery-to-summarytable", targets: ["imagegallery-to-summarytable"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "imagegallery-to-summarytable",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget(
            name: "imagegallery-to-summarytableTests",
            dependencies: ["imagegallery-to-summarytable"]),
    ]
)
