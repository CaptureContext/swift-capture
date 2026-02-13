# swift-capture

Ergonomic and safe weak capturing for Swift closures.

## Table of Contents

- [Motivation](#motivation)
- [Usage](#usage)
- [Installation](#installation)
- [License](#license)

## Motivation

Weak captures in Swift closures often require repetitive boilerplate:

```swift
{ [weak self] in
  guard let self else { return }
  // ...
}
```

While explicit, this pattern adds noise and can obscure the intent of the closure, especially when used frequently.

`swift-capture` provides a set of helpers that encapsulate this pattern, allowing weakly captured objects to be used safely without repeating the same guard logic.

## Usage

> [!NOTE]
>
> _All `NSObject` subclasses conform to `CapturableObjectProtocol` by default.
> Custom reference types can conform by inheriting `AnyObject`._

A common use case for capturing objects is handling asynchronous results:

```swift
func loadData() {
  apiService.fetchData { [weak self] items in 
    guard let self else { return }
    self.items = items
  }
}
```

Can be replaced with:

```swift
func loadData() {
  apiService.fetchData(completion: capture { _self, items in
    _self.items = items
  })
}
```

If the object is already deallocated, the closure is simply not executed.

`swift-capture` helpers utilize variadic generics to automatically support any number of arguments:

```swift
networkService.perform(request, completion: capture { _self, response, data, error in
  // ...
})
```

For `non-Void` and `non-Optional` output closures, a default value must be provided:

```swift
dataSource.numberOfItems = capture(orReturn: 0) { _self in
  _self.items.count
}
```

Access to properties can be simplified by using key paths as functions:

```swift
dataSource.numberOfItems = capture(orReturn: 0, in: \.items.count)
```

#### Overriding strategy

When you need a custom capture strategy, it is recommended to use method accessors:

```swift
object.capture(as: .strong) { _self in
  _self.performCriticalWork()
}
```

The functor accessor also provides a way to override the default (`.weak`) strategy:

```swift
object.capture.as(.strong).orReturn(()) { _self in
  _self.performWork()
}
```

> [!NOTE]
>
> _There are proper overrides of `callAsFunction` available as well, so the following examples are also valid:_
>
> ```swift
> object.capture.as(.strong)(in: { _self in
>     _self.performWork()
> })
> ```
>
> ```swift
> object.capture.as(.strong).self { _self in
>     _self.performWork()
> }
> ```
>
> ```swift
> object.capture.as(.strong).callAsFunction { _self in
>     _self.performWork()
> }
> ```
>
> _However, this will not compile even though the code is valid:_
>
> ```swift
> object.capture.as(.strong) { _self in // ❌ Extra trailing closure passed in call
>     _self.performWork()
> }
> ```
>
> _Convenience method `orReturn` is provided as a workaround for [a Swift compiler bug](https://github.com/swiftlang/swift/issues/87210) that leads to a compilation issue when `callAsFunction` is used as a trailing closure._

---

#### Async / throwing variants

All function kinds are supported:

```swift
try object.capture { _self in
  try _self.throwingWork()
}

await object.capture { _self in
  await _self.asyncWork()
}

try await object.capture { _self in
  try await _self.asyncThrowingWork()
}
```

Including overloads for `orReturn` and `onMainActor` functor methods.

### Sendability

- Functors are `Sendable` when the captured object is `Sendable`.
- Sendable functors preserve closure sendability.
- `onMainActor` can be used to preserve `@MainActor`.
- `uncheckedSendable` is available for explicit opt-out.

```swift
object.capture.uncheckedSendable.onMainActor { _self in
  _self.updateUI()
}
```

### Containers

This package does also provide:

- `Weak`
- `Strong`
- `Unowned`
- `Captured`

## Installation

### Basic

You can add `swift-capture` to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency…**
2. Enter [`https://github.com/capturecontext/swift-capture`](https://github.com/capturecontext/swift-capture) into the package repository URL text field
3. Choose the products you need to link to your project.

### Recommended

If you use SwiftPM for your project structure, add `swift-capture` to your package file:

```swift
.package(
  url: "https://github.com/capturecontext/swift-capture.git",
  .upToNextMajor(from: "4.0.0")
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

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
