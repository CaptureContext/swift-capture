// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "swift-capture",
	products: [
		.library(
			name: "Capture",
			targets: ["Capture"]
		)
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
