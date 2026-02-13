import Foundation

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
