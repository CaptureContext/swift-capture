import Foundation

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
