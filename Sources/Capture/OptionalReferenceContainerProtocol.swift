import Foundation

/// Protocol to generalize Weak and Weak.Box APIs
public protocol OptionalReferenceContainerProtocol {
	associatedtype Object: AnyObject
	var object: Object? { get }
}

// MARK: - Void result closures

extension OptionalReferenceContainerProtocol {
	/// Weakly captures an object in non-parametrized void result closure.
	///
	/// Creates `() -> Void` handler from `(Object) -> Void` closure
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Unwrapping happens on the call of returned closure.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func observe(
	///     _ publisher: some Publisher<Void, Never>
	///   ) -> AnyCancellable {
	///     publisher.sink(
	///       receiveValue: capture { _self in
	///         // ...
	///       }
	///     )
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object) -> Void`, where Object is unwrapped weakly captured object.
	/// - Returns: `() -> Void` handler, created from `(Object) -> Void` closure by weakly capturing object.
	@inlinable
	public func capture(
		in closure: @escaping (Object) -> Void
	) -> () -> Void {
		return { [weak object] in
			guard let object else { return }
			closure(object)
		}
	}
	
	/// Weakly captures an object in non-parametrized lazy void result closure.
	///
	/// Primary idea behind this method is to be able to pass methods without referring to an object.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func handleCompletion() {
	///     // ...
	///   }
	///
	///   func observe(
	///     _ publisher: some Publisher<Void, Never>
	///   ) -> AnyCancellable {
	///     publisher.sink(
	///       receiveValue: capture(in: MyClass.handleCompletion)
	///     )
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object) -> () -> Void`, most likely it's `ObjectType.someInstanceMethod`
	/// - Returns: `() -> Void` handler, created from `(Object) -> () -> Void` closure by weakly capturing object
	@inlinable
	public func capture(
		in closure: @escaping (Object) -> () -> Void
	) -> () -> Void {
		return { [weak object] in
			guard let object else { return }
			closure(object)()
		}
	}
	
	/// Weakly captures an object in parametrized void result closure.
	///
	/// >  In context of this doc "`A, B, C...`" is a shortcut for 1 or more types.
	///
	/// Creates `(A, B, C...) -> Void` handler from `(Object, A, B, C...) -> Void` closure
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func observe(
	///     _ publisher: some Publisher<Int, Never>
	///   ) -> AnyCancellable {
	///     publisher.sink(
	///       // number of params comes from publisher, if it was
	///       // some completion with multiple args, all the args
	///       // would've been passed to the capture method
	///       receiveValue: capture { _self, value in
	///         // ...
	///       }
	///     )
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object, A, B, C...) -> Void`, where Object is unwrapped weakly captured object.
	/// - Returns: `(A, B, C...) -> Void` handler, created from `(Object, A, B, C) -> Void` closure by weakly capturing object.
	public func capture<each Arg>(
		in closure: @escaping (Object, repeat each Arg) -> Void
	) -> (repeat each Arg) -> Void {
		return { [weak object] (arg: repeat each Arg) in
			guard let object else { return }
			closure(object, repeat each arg)
		}
	}
}

// MARK: Sendable

extension OptionalReferenceContainerProtocol where Object: Sendable {
	/// Weakly captures an object in non-parametrized void result closure.
	///
	/// Creates `() -> Void` handler from `(Object) -> Void` closure
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Unwrapping happens on the call of returned closure.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func observe(
	///     _ publisher: some Publisher<Void, Never>
	///   ) -> AnyCancellable {
	///     publisher.sink(
	///       receiveValue: capture { _self in
	///         // ...
	///       }
	///     )
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object) -> Void`, where Object is unwrapped weakly captured object.
	/// - Returns: `() -> Void` handler, created from `(Object) -> Void` closure by weakly capturing object.
	@inlinable
	public func _capture(
		in closure: @escaping @Sendable (Object) -> Void
	) -> @Sendable () -> Void {
		return { [weak object] in
			guard let object else { return }
			closure(object)
		}
	}

	/// Weakly captures an object in non-parametrized lazy void result closure.
	///
	/// Primary idea behind this method is to be able to pass methods without referring to an object.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func handleCompletion() {
	///     // ...
	///   }
	///
	///   func observe(
	///     _ publisher: some Publisher<Void, Never>
	///   ) -> AnyCancellable {
	///     publisher.sink(
	///       receiveValue: capture(in: MyClass.handleCompletion)
	///     )
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object) -> () -> Void`, most likely it's `ObjectType.someInstanceMethod`
	/// - Returns: `() -> Void` handler, created from `(Object) -> () -> Void` closure by weakly capturing object
	@inlinable
	public func _capture(
		in closure: @escaping @Sendable (Object) -> () -> Void
	) -> @Sendable () -> Void {
		return { [weak object] in
			guard let object else { return }
			closure(object)()
		}
	}

	/// Weakly captures an object in parametrized void result closure.
	///
	/// >  In context of this doc "`A, B, C...`" is a shortcut for 1 or more types.
	///
	/// Creates `(A, B, C...) -> Void` handler from `(Object, A, B, C...) -> Void` closure
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func observe(
	///     _ publisher: some Publisher<Int, Never>
	///   ) -> AnyCancellable {
	///     publisher.sink(
	///       // number of params comes from publisher, if it was
	///       // some completion with multiple args, all the args
	///       // would've been passed to the capture method
	///       receiveValue: capture { _self, value in
	///         // ...
	///       }
	///     )
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object, A, B, C...) -> Void`, where Object is unwrapped weakly captured object.
	/// - Returns: `(A, B, C...) -> Void` handler, created from `(Object, A, B, C) -> Void` closure by weakly capturing object.
	public func _capture<each Arg>(
		in closure: @escaping @Sendable (Object, repeat each Arg) -> Void
	) -> @Sendable (repeat each Arg) -> Void {
		return { [weak object] (arg: repeat each Arg) in
			guard let object else { return }
			closure(object, repeat each arg)
		}
	}
}

// MARK: - Non-void result closures

extension OptionalReferenceContainerProtocol {
	/// Weakly captures an object in non-parametrized non-void result closure.
	///
	/// Creates `() -> Output` handler from `(Object) -> Output` closure.
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Unwrapping happens on the call of returned closure.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   var value: Int = 0
	///
	///   func createZeroDataSource() -> () -> Int {
	///     return capture(orReturn: -1) { _self in
	///       return 0
	///     }
	///   }
	///
	///   func createValueDataSource() -> () -> Int {
	///     return capture(orReturn: -1, in: \.value)
	///   }
	/// }
	/// ```
	///
	/// - Parameters:
	///   - defaultValue: Default value to be returned if object was deinitialized when returned handler was called.
	///   - closure: `(Object) -> Output`, where Object is unwrapped weakly captured object.
	/// - Returns: `() -> Output` handler, created from `(Object) -> Output` closure by weakly capturing object.
	@inlinable
	public func capture<Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Object) -> Output
	) -> () -> Output {
		return { [weak object] in
			guard let object else { return defaultValue() }
			return closure(object)
		}
	}
	
	/// Weakly captures an object in non-parametrized lazy non-void result closure.
	///
	/// Primary idea behind this method is to be able to pass methods without referring to an object.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   // `MyClass.getData` signature is `(MyClass) -> () -> Int`
	///   func getData() -> Int {
	///     return 0
	///   }
	///
	///   func createDataSource() -> () -> Int {
	///     return capture(orReturn: -1, in: MyClass.getData)
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object) -> () -> Output`, most likely it's `ObjectType.someInstanceMethod`.
	/// - Returns: `() -> Output` handler, created from `(Object) -> () -> Output` closure by weakly capturing object.
	@inlinable
	public func capture<Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Object) -> () -> Output
	) -> () -> Output {
		return { [weak object] in
			guard let object else { return defaultValue() }
			return closure(object)()
		}
	}
	
	/// Weakly captures an object in parametrized non-void result closure.
	///
	/// >  In context of this doc "`A, B, C...`" is a shortcut for 1 or more types.
	///
	/// Creates `(A, B, C...) -> Output` handler from `(Object, A, B, C...) -> Output` closure
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func createDataSource() -> (Bool) -> Int {
	///     // number of params comes from publisher, if it was
	///     // some completion with multiple args, all the args
	///     // would've been passed to the capture method
	///     return capture(orReturn: -1) { _self, isZero in
	///       return isZero ? 0 : 1
	///     }
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object, A, B, C...) -> Output`, where Object is unwrapped weakly captured object.
	/// - Returns: `(A, B, C...) -> Output` handler, created from `(Object, A, B, C) -> Output` closure by weakly capturing object.
	public func capture<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Object, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		return { [weak object] (arg: repeat each Arg) in
			guard let object else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}
}

// MARK: Sendable

extension OptionalReferenceContainerProtocol where Object: Sendable {
	/// Weakly captures an object in non-parametrized non-void result closure.
	///
	/// Creates `() -> Output` handler from `(Object) -> Output` closure.
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Unwrapping happens on the call of returned closure.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   var value: Int = 0
	///
	///   func createZeroDataSource() -> () -> Int {
	///     return capture(orReturn: -1) { _self in
	///       return 0
	///     }
	///   }
	///
	///   func createValueDataSource() -> () -> Int {
	///     return capture(orReturn: -1, in: \.value)
	///   }
	/// }
	/// ```
	///
	/// - Parameters:
	///   - defaultValue: Default value to be returned if object was deinitialized when returned handler was called.
	///   - closure: `(Object) -> Output`, where Object is unwrapped weakly captured object.
	/// - Returns: `() -> Output` handler, created from `(Object) -> Output` closure by weakly capturing object.
	@inlinable
	public func _capture<Output>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (Object) -> Output
	) -> @Sendable () -> Output {
		return { [weak object] in
			guard let object else { return defaultValue() }
			return closure(object)
		}
	}

	/// Weakly captures an object in non-parametrized lazy non-void result closure.
	///
	/// Primary idea behind this method is to be able to pass methods without referring to an object.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   // `MyClass.getData` signature is `(MyClass) -> () -> Int`
	///   func getData() -> Int {
	///     return 0
	///   }
	///
	///   func createDataSource() -> () -> Int {
	///     return capture(orReturn: -1, in: MyClass.getData)
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object) -> () -> Output`, most likely it's `ObjectType.someInstanceMethod`.
	/// - Returns: `() -> Output` handler, created from `(Object) -> () -> Output` closure by weakly capturing object.
	@inlinable
	public func _capture<Output>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (Object) -> () -> Output
	) -> @Sendable () -> Output {
		return { [weak object] in
			guard let object else { return defaultValue() }
			return closure(object)()
		}
	}

	/// Weakly captures an object in parametrized non-void result closure.
	///
	/// >  In context of this doc "`A, B, C...`" is a shortcut for 1 or more types.
	///
	/// Creates `(A, B, C...) -> Output` handler from `(Object, A, B, C...) -> Output` closure
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func createDataSource() -> (Bool) -> Int {
	///     // number of params comes from publisher, if it was
	///     // some completion with multiple args, all the args
	///     // would've been passed to the capture method
	///     return capture(orReturn: -1) { _self, isZero in
	///       return isZero ? 0 : 1
	///     }
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object, A, B, C...) -> Output`, where Object is unwrapped weakly captured object.
	/// - Returns: `(A, B, C...) -> Output` handler, created from `(Object, A, B, C) -> Output` closure by weakly capturing object.
	public func _capture<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (Object, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		return { [weak object] (arg: repeat each Arg) in
			guard let object else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}
}


// MARK: - Non-void optional result closures

extension OptionalReferenceContainerProtocol {
	/// Weakly captures an object in non-parametrized non-void optional resilt closure.
	///
	/// Creates `() -> Output?` handler from `(Object) -> Output?` closure.
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Unwrapping happens on the call of returned closure.
	/// Handler will return nil if object was already deinitialized.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   var value: Int = 0
	///
	///   func createZeroDataSource() -> () -> Int? {
	///     return capture { _self in
	///       return _self.value
	///     }
	///   }
	/// }
	/// ```
	///
	/// - Parameters:
	///   - closure: `(Object) -> Output?`, where Object is unwrapped weakly captured object.
	/// - Returns: `() -> Output?` handler, created from `(Object) -> Output?` closure by weakly capturing object. Handler will return nil if object was already deinitialized.
	@inlinable
	public func capture<Output>(
		in closure: @escaping (Object) -> Output?
	) -> () -> Output? {
		return { [weak object] in
			guard let object else { return nil }
			return closure(object)
		}
	}
	
	/// Weakly captures an object in non-parametrized lazy non-void optional result closure.
	///
	/// Primary idea behind this method is to be able to pass methods without referring to an object.
	///
	/// Handler will return nil if object was already deinitialized.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   // `MyClass.getData` signature is `(MyClass) -> () -> Int?`
	///   func getData() -> Int? {
	///     return 0
	///   }
	///
	///   func createDataSource() -> () -> Int? {
	///     return capture(orReturn: -1, in: MyClass.getData)
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object) -> () -> Output?`, most likely it's `ObjectType.someInstanceMethod`.
	/// - Returns: `() -> Output?` handler, created from `(Object) -> () -> Output?` closure by weakly capturing object.
	@inlinable
	public func capture<Output>(
		in closure: @escaping (Object) -> () -> Output?
	) -> () -> Output? {
		return { [weak object] in
			guard let object else { return nil }
			return closure(object)()
		}
	}
	
	/// Weakly captures an object in parametrized non-void optional result closure.
	///
	/// >  In context of this doc "`A, B, C...`" is a shortcut for 1 or more types.
	///
	/// Creates `(A, B, C...) -> Output?` handler from `(Object, A, B, C...) -> Output?` closure
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Handler will return nil if object was already deinitialized.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func createDataSource() -> (Bool) -> Int? {
	///     // number of params comes from publisher, if it was
	///     // some completion with multiple args, all the args
	///     // would've been passed to the capture method
	///     return capture(orReturn: -1) { _self, isZero in
	///       return isZero ? 0 : 1
	///     }
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object, A, B, C...) -> Void`, where Object is unwrapped weakly captured object.
	/// - Returns: `(A, B, C...) -> Output?` handler, created from `(Object, A, B, C) -> Output?` closure by weakly capturing object.
	public func capture<each Arg, Output>(
		in closure: @escaping (Object, repeat each Arg) -> Output?
	) -> (repeat each Arg) -> Output? {
		return { [weak object] (arg: repeat each Arg) in
			guard let object else { return nil }
			return closure(object, repeat each arg)
		}
	}
}

// MARK: Sendable

extension OptionalReferenceContainerProtocol where Object: Sendable {
	/// Weakly captures an object in non-parametrized non-void optional resilt closure.
	///
	/// Creates `() -> Output?` handler from `(Object) -> Output?` closure.
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Unwrapping happens on the call of returned closure.
	/// Handler will return nil if object was already deinitialized.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   var value: Int = 0
	///
	///   func createZeroDataSource() -> () -> Int? {
	///     return capture { _self in
	///       return _self.value
	///     }
	///   }
	/// }
	/// ```
	///
	/// - Parameters:
	///   - closure: `(Object) -> Output?`, where Object is unwrapped weakly captured object.
	/// - Returns: `() -> Output?` handler, created from `(Object) -> Output?` closure by weakly capturing object. Handler will return nil if object was already deinitialized.
	@inlinable
	public func _capture<Output>(
		in closure: @escaping @Sendable (Object) -> Output?
	) -> @Sendable () -> Output? {
		return { [weak object] in
			guard let object else { return nil }
			return closure(object)
		}
	}

	/// Weakly captures an object in non-parametrized lazy non-void optional result closure.
	///
	/// Primary idea behind this method is to be able to pass methods without referring to an object.
	///
	/// Handler will return nil if object was already deinitialized.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   // `MyClass.getData` signature is `(MyClass) -> () -> Int?`
	///   func getData() -> Int? {
	///     return 0
	///   }
	///
	///   func createDataSource() -> () -> Int? {
	///     return capture(orReturn: -1, in: MyClass.getData)
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object) -> () -> Output?`, most likely it's `ObjectType.someInstanceMethod`.
	/// - Returns: `() -> Output?` handler, created from `(Object) -> () -> Output?` closure by weakly capturing object.
	@inlinable
	public func _capture<Output>(
		in closure: @escaping @Sendable (Object) -> () -> Output?
	) -> @Sendable () -> Output? {
		return { [weak object] in
			guard let object else { return nil }
			return closure(object)()
		}
	}

	/// Weakly captures an object in parametrized non-void optional result closure.
	///
	/// >  In context of this doc "`A, B, C...`" is a shortcut for 1 or more types.
	///
	/// Creates `(A, B, C...) -> Output?` handler from `(Object, A, B, C...) -> Output?` closure
	/// so you can access weakly captured Object in your handler if the object is present.
	///
	/// Handler will return nil if object was already deinitialized.
	///
	/// Example:
	/// ```swift
	/// class MyClass: Weakifiable {
	///   func createDataSource() -> (Bool) -> Int? {
	///     // number of params comes from publisher, if it was
	///     // some completion with multiple args, all the args
	///     // would've been passed to the capture method
	///     return capture(orReturn: -1) { _self, isZero in
	///       return isZero ? 0 : 1
	///     }
	///   }
	/// }
	/// ```
	///
	/// - Parameter closure: `(Object, A, B, C...) -> Void`, where Object is unwrapped weakly captured object.
	/// - Returns: `(A, B, C...) -> Output?` handler, created from `(Object, A, B, C) -> Output?` closure by weakly capturing object.
	public func _capture<each Arg, Output>(
		in closure: @escaping @Sendable (Object, repeat each Arg) -> Output?
	) -> @Sendable (repeat each Arg) -> Output? {
		return { [weak object] (arg: repeat each Arg) in
			guard let object else { return nil }
			return closure(object, repeat each arg)
		}
	}
}

