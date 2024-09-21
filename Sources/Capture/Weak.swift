import Foundation

/// Value-type container for capturing objects weakly
///
/// We believe that most APIs should not be too opinionated and this package provides
/// various ways to capture objects, so feel free to use it as property wrapper or plain property/variable.
///
/// However opinionated approach removes cognitive load while working with APIs, so we do also provide recomendations.
///
/// It's recommended to conform your objects to ``Weakifiable`` protocol instead of using this type if possible
/// or use `_capture(...)` methods directly if not.
///
/// But there is a recommended usecase: workarounds for poorly designed APIs with ``capture(_:)-swift.type.method`` 😅
@propertyWrapper
public struct Weak<Object: AnyObject>: OptionalReferenceContainerProtocol {
	
	/// Weak reference to an object
	public weak var wrappedValue: Object?
	
	/// Convenience property to access wrappedValue with better semantics when used inline
	@inlinable
	public var object: Object? {
		get { wrappedValue }
		set { wrappedValue = newValue }
	}
	
	/// Creates a reference-type box with a weak reference the object
	@inlinable
	public var projectedValue: Box {
		return .init(wrappedValue)
	}
	
	/// Convenience property to access projectedValue with better semantics when used inline
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
	
	/// Passes capturable box in a closure, box object is set to returned value after return
	///
	/// Recommended usecase: workarounds for poorly designed APIs 😅
	/// ```swift
	/// return Weak.capture { box in
	///   return createFancyBottomSheet(onLinkTapped: { url in
	///     guard let controller = box.object else { return }
	///     openWebView(url, in: controller)
	///   })
	/// }
	/// ```
	/// instead of
	/// ```swift
	/// var controller: UIViewController
	/// controller = createFancyBottomSheet(onLinkTapped: { [weak controller] url in
	///   guard let controller else { return }
	///   openWebView(url, in: controller)
	/// })
	/// return controller
	/// ```
	@inlinable
	public static func capture(
		_ initializer: (Box) -> Object
	) -> Object {
		let box = Box()
		let object = initializer(box)
		box.wrappedValue = object
		return object
	}

	/// Passes capturable box in a closure, box object is set to returned value after return
	///
	/// Recommended usecase: workarounds for poorly designed APIs 😅
	/// ```swift
	/// return Weak._capture { box in
	///   return createFancyBottomSheet(onLinkTapped: { url in
	///     guard let controller = box.object else { return }
	///     openWebView(url, in: controller)
	///   })
	/// }
	/// ```
	/// instead of
	/// ```swift
	/// var controller: UIViewController
	/// controller = createFancyBottomSheet(onLinkTapped: { [weak controller] url in
	///   guard let controller else { return }
	///   openWebView(url, in: controller)
	/// })
	/// return controller
	/// ```
	@inlinable
	public static func _capture(
		_ initializer: (UncheckedSendableBox) -> Object
	) -> Object {
		let box = UncheckedSendableBox()
		let object = initializer(box)
		box.wrappedValue = object
		return object
	}
}

extension Weak {
	/// Value-type container for capturing objects weakly
	///
	/// We believe that most APIs should not be too opinionated and this package provides
	/// various ways to capture objects, so feel free to use it as property wrapper or plain property/variable.
	///
	/// However opinionated approach removes cognitive load while working with APIs, so we do also provide recomendations.
	///
	/// It's recommended to conform your objects to ``Weakifiable`` protocol instead of using this type if possible
	/// or use `_capture(...)` methods directly if not.
	///
	/// But there is a recommended usecase: workarounds for poorly designed APIs with ``capture(_:)-swift.type.method`` 😅
	@propertyWrapper
	public class Box: OptionalReferenceContainerProtocol {
		/// Weak reference to an object
		public weak var wrappedValue: Object? = nil
		
		/// Convenience property to access wrappedValue with better semantics when used inline
		@inlinable
		public var object: Object? {
			get { wrappedValue }
			set { wrappedValue = newValue }
		}
		
		/// Creates a value-type ``Weak`` container with a weak reference the object
		@inlinable
		public var projectedValue: Weak {
			return .init(wrappedValue)
		}
		
		/// Convenience method to access ``projectedValue`` with better semantics when used inline
		///
		/// - Returns: Value-type weak reference to an object
		@inlinable
		public func unboxed() -> Weak { projectedValue }
		
		public init() {}
		
		public init(wrappedValue: Object?) {
			self.wrappedValue = wrappedValue
		}
		
		@inlinable
		public convenience init(_ object: Object?) {
			self.init(wrappedValue: object)
		}
	}

	@propertyWrapper
	public class UncheckedSendableBox: Box, @unchecked Sendable {
		public override var wrappedValue: Object? {
			get { super.object }
			set { super.object = newValue }
		}
	}
}

extension Weak: Sendable where Object: Sendable {}
