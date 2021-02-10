// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Weak",
    products: [
        .library(
            name: "Weak",
            targets: ["Weak"]
        ),
    ],
    targets: [
        .target(name: "Weak"),
        .testTarget(
            name: "WeakTests",
            dependencies: [
                .target(name: "Weak")
            ]
        ),
    ]
)
