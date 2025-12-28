import Foundation

@propertyWrapper
public struct Weak<Object: AnyObject>: _OptionalReferenceContainerProtocol {
	public typealias __CaptureRefObject = Object
	public var __optionalRefObject: Object? { wrappedValue }

	public weak var wrappedValue: Object?
	
	@inlinable
	public var object: Object? {
		get { wrappedValue }
		set { wrappedValue = newValue }
	}
	
	@inlinable
	public var projectedValue: Box {
		return .init(wrappedValue)
	}
	
	@inlinable
	public var box: Box {
		return projectedValue
	}
	
	public init() {}
	
	public init(wrappedValue: Object?) {
		self.wrappedValue = wrappedValue
	}
	
	@inlinable
	public init(_ object: Object?) {
		self.init(wrappedValue: object)
	}

	@inlinable
	public static func capture(
		_ initializer: (Box) -> Object
	) -> Object {
		let box = Box()
		let object = initializer(box)
		box.wrappedValue = object
		return object
	}

	@inlinable
	public static func uncheckedSendableCapture(
		_ initializer: (Box.UncheckedSendable) -> Object
	) -> Object {
		let box = Box.UncheckedSendable()
		let object = initializer(box)
		box.wrappedValue = object
		return object
	}
}

extension Weak {
	@propertyWrapper
	public class Box: _OptionalReferenceContainerProtocol {
		public typealias __CaptureRefObject = Object
		public var __optionalRefObject: Object? { wrappedValue }

		public weak var wrappedValue: Object? = nil
		
		@inlinable
		public var object: Object? {
			get { wrappedValue }
			set { wrappedValue = newValue }
		}
		
		@inlinable
		public var projectedValue: Weak {
			return .init(wrappedValue)
		}

		@inlinable
		public func unboxed() -> Weak { projectedValue }

		@inlinable
		public func uncheckedSendable() -> UncheckedSendable {
			.init(object)
		}

		public init() {}
		
		public init(wrappedValue: Object?) {
			self.wrappedValue = wrappedValue
		}
		
		@inlinable
		public convenience init(_ object: Object?) {
			self.init(wrappedValue: object)
		}
	}
}

extension Weak.Box {
	@propertyWrapper
	public class UncheckedSendable: Weak.Box, @unchecked Sendable {
		public override var wrappedValue: Object? {
			get { super.object }
			set { super.object = newValue }
		}
	}
}

extension Weak: Sendable where Object: Sendable {}
