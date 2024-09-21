// swift-tools-version:6.0

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
			url: "https://github.com/apple/swift-docc-plugin.git",
			from: "1.4.0"
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
	],
	swiftLanguageModes: [.v6]
)

for target in package.targets where target.type == .system || target.type == .test {
	target.swiftSettings?.append(contentsOf: [
		.swiftLanguageMode(.v5),
		.enableExperimentalFeature("StrictConcurrency"),
		.enableUpcomingFeature("InferSendableFromCaptures"),
	])
}
