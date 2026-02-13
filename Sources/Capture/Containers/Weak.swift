import Foundation

@propertyWrapper
public struct Weak<Object: AnyObject>: _OptionalReferenceContainerProtocol {
	public typealias RootContainer = Weak<Object>
	public typealias __CaptureRefObject = Object

	@_spi(Internals)
	public weak var __refObject: Object?

	public weak var wrappedValue: Object? {
		get { __refObject }
		set { __refObject = newValue }
		_modify { yield &__refObject }
	}

	public weak var object: Object? {
		get { __refObject }
		set { __refObject = newValue }
		_modify { yield &__refObject }
	}

	@inlinable
	public var projectedValue: Self {
		get { self }
		set { self = newValue }
		_modify { yield &self }
	}

	@inlinable
	public init(_ object: Object?) {
		self.init(wrappedValue: object)
	}

	public init(wrappedValue: Object? = nil) {
		self.wrappedValue = wrappedValue
	}
}

extension Weak: Sendable where Object: Sendable {}
