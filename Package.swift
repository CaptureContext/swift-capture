// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "swift-capture",
  products: [
    .library(
      name: "Capture",
      targets: ["Capture"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-docc-plugin",
      from: "1.3.0"
    ),
  ],
  targets: [
    .target(name: "Capture"),
    .testTarget(
      name: "CaptureTests",
      dependencies: [
        .target(name: "Capture")
      ]
    ),
  ]
)
