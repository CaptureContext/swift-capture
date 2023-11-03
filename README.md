# swift-capture

[![test](https://github.com/CaptureContext/swift-capture/actions/workflows/Test.yml/badge.svg)](https://github.com/CaptureContext/swift-capture/actions/workflows/Test.yml) [![SwiftPM 5.9](https://img.shields.io/badge/📦_swiftpm-5.9-ED523F.svg?style=flat)](https://github.com/CaptureContext/swift-declarative-configuration/actions/workflows/Test.yml) ![Platforms](https://img.shields.io/badge/platforms-iOS_|_macOS_|_tvOS_|_watchOS_|_Catalyst-ED523F.svg?style=flat)
[![docs](https://img.shields.io/badge/docs-spi-ED523F.svg?style=flat)]([https://twitter.com/capture_context](https://swiftpackageindex.com/CaptureContext/swift-capture/3.0.1/documentation)) [![@capture_context](https://img.shields.io/badge/contact-@capture__context-1DA1F2.svg?style=flat&logo=twitter)](https://twitter.com/capture_context) 

A mechanism for ergonomic and safe capturing & weakifying objects in Swift.

## Usage Examples

```swift
Without Capture
```

```swift
With Capture
```

----

Default
```swift
{ [weak self] in 
  guard let self else { return }
  /// ...
}
```

```swift
capture { _self in
  /// ...
}
```

----

Multiple parameters
```swift
{ [weak self] a, b, c in 
  guard let self else { return }
  /// ...
}
```

```swift
capture { _self, a, b, c in 
  /// ...
}
```

---

Methods

```swift
{ [weak self] in 
  guard let self = self else { return }
  self.someMethod()
}
```

```swift
capture(in: <#Type#>.someMethod)
```

----

Return values

```swift
let object.dataSource = { [weak self] in
  guard let self = self else { return [] }
  return self.data
}
```

```swift
let object.dataSource = capture(orReturn: [], in: \.data)
```

## Installation

### Basic

You can add `swift-capture` to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency…**
2. Enter [`"https://github.com/capturecontext/swift-capture"`](https://github.com/capturecontext/swift-capture) into the package repository URL text field
3. Choose products you need to link them to your project.

### Recommended

If you use SwiftPM for your project, you can add `weak` to your package file. Also my advice is to use SSH.

```swift
.package(
  url: "git@github.com:capturecontext/swift-capture.git",
  .upToNextMajor("3.0.0")
)
```

Do not forget about target dependencies:

```swift
.product(
    name: "Capture", 
    package: "swift-capture"
)
```

## License

This library is released under the MIT license. See [LICENSE](./LICENSE) for details.

