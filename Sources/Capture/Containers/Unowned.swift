import Foundation

/// A property wrapper that holds an unowned reference to an object.
///
/// The wrapped value is non-optional and does not extend the lifetime of the referenced object.
/// Accessing an unowned reference to a deallocated object will cause a runtime error.
/// This is useful for capture scenarios where you have strict guarantees that the object will outlive
/// the closure, allowing you to avoid the overhead of weak reference checking.
///
/// - Warning: Ensure the referenced object outlives this container to avoid crashes.
@propertyWrapper
public struct Unowned<Object: AnyObject>: _OptionalReferenceContainerProtocol {
	public typealias RootContainer = Unowned<Object>
	public typealias __CaptureRefObject = Object

	@_spi(Internals)
	public unowned var storage: Object

	@_spi(Internals)
	public var __refObject: Object? {
		get { storage }
		set { newValue.map { storage = $0 } }
	}

	public unowned var wrappedValue: Object {
		get { storage }
		set { self.storage = newValue }
		_modify { yield &storage }
	}

	public unowned var object: Object {
		get { storage }
		set { self.storage = newValue }
		_modify { yield &storage }
	}

	@inlinable
	public var projectedValue: Self {
		get { self }
		set { self = newValue }
		_modify { yield &self }
	}

	public init(wrappedValue: Object) {
		self.storage = wrappedValue
	}

	@inlinable
	public init(_ object: Object) {
		self.init(wrappedValue: object)
	}
}

extension Unowned: Sendable where Object: Sendable {}
