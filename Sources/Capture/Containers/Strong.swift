import Foundation

/// A property wrapper that holds a strong reference to an object.
@propertyWrapper
public struct Strong<Object: AnyObject>: _OptionalReferenceContainerProtocol {
	public typealias RootContainer = Strong<Object>
	public typealias __CaptureRefObject = Object

	@_spi(Internals)
	public var __refObject: Object?

	public var wrappedValue: Object? {
		get { __refObject }
		set { __refObject = newValue }
		_modify { yield &__refObject }
	}

	public var object: Object? {
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

	public init(wrappedValue: Object? = nil) {
		self.wrappedValue = wrappedValue
	}

	@inlinable
	public init(_ object: Object?) {
		self.init(wrappedValue: object)
	}
}

extension Strong: Sendable where Object: Sendable {}
