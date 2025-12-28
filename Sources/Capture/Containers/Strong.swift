import Foundation

@propertyWrapper
public struct Strong<Object: AnyObject>: _OptionalReferenceContainerProtocol {
	public typealias __CaptureRefObject = Object
	public var __optionalRefObject: Object? { wrappedValue }

	public var wrappedValue: Object?

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

extension Strong {
	@propertyWrapper
	public class Box: _OptionalReferenceContainerProtocol {
		public typealias __CaptureRefObject = Object
		public var __optionalRefObject: Object? { wrappedValue }

		public var wrappedValue: Object? = nil

		@inlinable
		public var object: Object? {
			get { wrappedValue }
			set { wrappedValue = newValue }
		}

		@inlinable
		public var projectedValue: Strong {
			return .init(wrappedValue)
		}

		@inlinable
		public func unboxed() -> Strong { projectedValue }

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

extension Strong.Box {
	@propertyWrapper
	public class UncheckedSendable: Strong.Box, @unchecked Sendable {
		public override var wrappedValue: Object? {
			get { super.object }
			set { super.object = newValue }
		}
	}
}

extension Strong: Sendable where Object: Sendable {}
