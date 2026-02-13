import Foundation

/// A property wrapper that holds a reference to an object using a configurable capture strategy.
///
/// This type provides a flexible container that can use weak, strong, or unowned reference strategies,
/// determined either at runtime or initialization time. It wraps an underlying reference container
/// and delegates to it, allowing you to switch between strategies based on your needs.
///
/// - Note: This type is useful when you need to dynamically choose a capture strategy at runtime.
///
/// You can initialize a `Captured` instance with a specific strategy:
/// - `.weak`: The reference becomes `nil` if the object is deallocated
/// - `.strong`: The object is kept alive by this container
/// - `.unowned`: The object must outlive this container (runtime error if accessed after deallocation)
@propertyWrapper
public struct Captured<Object: AnyObject>: _OptionalReferenceContainerProtocol {
	public typealias RootContainer = Self
	public typealias __CaptureRefObject = Object

	@_spi(Internals)
	public var underlyingContainer: any _OptionalReferenceContainerProtocol<Object>

	@_spi(Internals)
	public var __refObject: Object? {
		get { underlyingContainer.__refObject }
		set { underlyingContainer.__refObject = newValue }
		_modify { yield &underlyingContainer.__refObject }
	}

	public var wrappedValue: Object? {
		get { underlyingContainer.__refObject }
		set { underlyingContainer.__refObject = newValue }
		_modify { yield &underlyingContainer.__refObject }
	}

	public var object: Object? {
		get { underlyingContainer.__refObject }
		set { underlyingContainer.__refObject = newValue }
		_modify { yield &__refObject }
	}

	@_disfavoredOverload
	public init(
		wrappedValue: Object? = nil,
		strong: Bool = false
	) {
		self.underlyingContainer = if strong {
			Strong(wrappedValue)
		} else {
			Weak(wrappedValue)
		}
	}

	public init(
		_ object: Object,
		as strategy: ObjectCaptureStrategy = .weak
	) {
		self.init(
			unsafe: object,
			as: strategy
		)
	}

	public init(
		unsafe object: Object?,
		as strategy: ObjectCaptureStrategy = .weak
	) {
		self.underlyingContainer = switch strategy {
		case .weak:
			Weak(object)
		case .strong:
			Strong(object)
		case .unowned:
			Unowned(object!)
		}
	}

	public init(
		safe object: Object?,
		as strategy: ObjectCaptureStrategy = .weak
	) {
		if let object {
			self.init(object, as: strategy)
		} else if strategy == .unowned {
			self.init(wrappedValue: object, strong: false)
		} else {
			self.init(unsafe: object, as: strategy)
		}
	}

	@inlinable
	public init(
		wrappedValue: Object,
		_ strategy: ObjectCaptureStrategy = .weak
	) {
		self.init(wrappedValue, as: strategy)
	}
}

extension Captured: @unchecked Sendable where Object: Sendable {}
