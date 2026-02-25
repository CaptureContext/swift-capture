/// A capture item type that conforms to both the protocol and Sendable.
public typealias _SendableCaptureItemProtocol<Object> = CaptureItemProtocol<Object> & Sendable

public protocol CaptureItemProtocol<Object>: __OptionalReferenceContainerProtocol where __CaptureRefObject == Object {
	associatedtype Object: AnyObject
}

public struct CaptureItem<Object: AnyObject>: CaptureItemProtocol {
	@_spi(Internals)
	public var underlyingContainer: any __OptionalReferenceContainerProtocol<Object>

	@_spi(Internals)
	public var __refObject: Object? {
		_read { yield underlyingContainer.__refObject }
		_modify { yield &underlyingContainer.__refObject }
	}

	public init(_ container: any __OptionalReferenceContainerProtocol<Object>) {
		self.underlyingContainer = container
	}

	public struct UncheckedSendable: CaptureItemProtocol, @unchecked Sendable {
		@_spi(Internals)
		public var underlyingContainer: any __OptionalReferenceContainerProtocol<Object>

		@_spi(Internals)
		public var __refObject: Object? {
			_read { yield underlyingContainer.__refObject }
			_modify { yield &underlyingContainer.__refObject }
		}

		public init(_ container: any __OptionalReferenceContainerProtocol<Object>) {
			self.underlyingContainer = container
		}
	}
}

extension _OptionalReferenceContainerProtocol {
	/// Converts this container into a capture item.
	///
	/// - Returns: A capture item wrapping this reference container.
	public var capture: CaptureItem<__CaptureRefObject> {
		CaptureItem(self)
	}
}

extension __OptionalReferenceContainerProtocol {
	/// Converts this container into an unchecked Sendable capture item.
	///
	/// This bypasses Sendable conformance checks
	///
	/// - Returns: An unchecked Sendable capture item wrapping this reference container.
	public var uncheckedSendable: CaptureItem<__CaptureRefObject>.UncheckedSendable {
		CaptureItem.UncheckedSendable(self)
	}
}

extension CaptureItemProtocol {
	/// The underlying captured object, if still alive.
	@usableFromInline
	var object: Object? { __refObject }

	/// Returns a capture item with an overridden capture strategy.
	///
	/// The original object reference is preserved, but the item uses the new strategy
	/// when executing closures.
	///
	/// - Note: If current object is `nil`, an attempt to override current strategy with `.unowned`
	///         will result in a fallback to `.weak` strategy
	///
	/// - Parameter overrideCaptureStrategy: The new capture strategy to apply.
	/// - Returns: A capture item using the overridden strategy.
	@inlinable
	public func `as`(
		_ overrideCaptureStrategy: ObjectCaptureStrategy
	) -> CaptureItem<Object> {
		return CaptureItem(Captured(
			safe: object,
			as: overrideCaptureStrategy
		))
	}

	/// Returns a capture item with an overridden capture strategy.
	///
	/// The original object reference is preserved, but the item uses the new strategy
	/// when executing closures.
	///
	/// - Note: If current object is `nil`, an attempt to override current strategy with `.unowned`
	///         will result in a runtime crash
	///
	/// - Parameter overrideCaptureStrategy: The new capture strategy to apply.
	/// - Returns: A capture item using the overridden strategy.
	@inlinable
	public func `as`(
		unsafe overrideCaptureStrategy: ObjectCaptureStrategy
	) -> CaptureItem<Object> {
		return CaptureItem(Captured(
			unsafe: object,
			as: overrideCaptureStrategy
		))
	}

	// MARK: - Swift bug workaround

	/// Returns a closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: A closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A closure that checks object liveness before executing the provided closure.
	@inlinable
	public func orReturn<each Arg, Output>(
		_ defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns a throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: A throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func orReturn<each Arg, Output>(
		_ defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns an async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: An async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func orReturn<each Arg, Output: Sendable>(
		_ defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns an async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: An async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func orReturn<each Arg, Output: Sendable>(
		_ defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	// MARK: - Void

	/// Returns a closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Parameters:
	///   - closure: A closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Void
	) -> (repeat each Arg) -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	/// Returns a throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Parameters:
	///   - closure: A throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Void
	) -> (repeat each Arg) throws -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	/// Returns an async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Parameters:
	///   - closure: An async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Void
	) -> (repeat each Arg) async -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	/// Returns an async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Parameters:
	///   - closure: An async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Void
	) -> (repeat each Arg) async throws -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	// MARK: - Optional

	/// Returns a closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Parameters:
	///   - closure: A closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output?
	) -> (repeat each Arg) -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	/// Returns a throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Parameters:
	///   - closure: A throwing closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A throwing closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output?
	) -> (repeat each Arg) throws -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	/// Returns an async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Parameters:
	///   - closure: An async closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     An async closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output?
	) -> (repeat each Arg) async -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	/// Returns an async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Parameters:
	///   - closure: An async throwing closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     An async throwing closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output?
	) -> (repeat each Arg) async throws -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	// MARK: - defaultValue @autoclosure

	/// Returns a closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: A closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns a throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: A throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns an async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: An async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns an async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: An async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	// MARK: - Source

	/// Returns a closure that captures the object with the specified strategy.
	///
	/// This is the primary implementation that other callAsFunction variants delegate to.
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: A closure providing a default value if the object was deallocated.
	///   - closure: A closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}

	/// Returns a throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: A throwing closure providing a default value if the object was deallocated.
	///   - closure: A throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping () throws -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return try defaultValue() }
			return try closure(object, repeat each arg)
		}
	}

	/// Returns an async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An async closure providing a default value if the object was deallocated.
	///   - closure: An async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping () async -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return await defaultValue() }
			return await closure(object, repeat each arg)
		}
	}

	/// Returns an async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - defaultValue: An async throwing closure providing a default value if the object was deallocated.
	///   - closure: An async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping () async throws -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return try await defaultValue() }
			return try await closure(object, repeat each arg)
		}
	}
}

// MARK: - Sendable

extension CaptureItemProtocol where Self: Sendable {

	// MARK: - Swift bug workaround

	/// Returns a Sendable closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable closure that checks object liveness before executing the provided closure.
	@inlinable
	public func orReturn<each Arg, Output>(
		_ defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns a Sendable throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func orReturn<each Arg, Output>(
		_ defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> @Sendable (repeat each Arg) throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns a Sendable async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func orReturn<each Arg, Output: Sendable>(
		_ defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns a Sendable async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func orReturn<each Arg, Output: Sendable>(
		_ defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> @Sendable (repeat each Arg) async throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	// MARK: - Void

	/// Returns a Sendable closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - closure: A Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Void
	) -> @Sendable (repeat each Arg) -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	/// Returns a Sendable throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - closure: A Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Void
	) -> @Sendable (repeat each Arg) throws -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	/// Returns a Sendable async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - closure: A Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Void
	) -> @Sendable (repeat each Arg) async -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	/// Returns a Sendable async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - closure: A Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Void
	) -> @Sendable (repeat each Arg) async throws -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	// MARK: - Optional

	/// Returns a Sendable closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - closure: A Sendable closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A Sendable closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Output?
	) -> @Sendable (repeat each Arg) -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	/// Returns a Sendable throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - closure: A Sendable throwing closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A Sendable throwing closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output?
	) -> @Sendable (repeat each Arg) throws -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	/// Returns a Sendable async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - closure: A Sendable async closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A Sendable async closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Output?
	) -> @Sendable (repeat each Arg) async -> Output? {
		callAsFunction(orReturn: { nil }, in: closure)
	}

	/// Returns a Sendable async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - closure: A Sendable async throwing closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A Sendable async throwing closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output?
	) -> @Sendable (repeat each Arg) async throws -> Output? {
		callAsFunction(orReturn: { nil }, in: closure)
	}

	// MARK: - defaultValue @autoclosure

	/// Returns a Sendable closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns a Sendable throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> @Sendable (repeat each Arg) throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns a Sendable async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output: Sendable>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	/// Returns a Sendable async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output: Sendable>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> @Sendable (repeat each Arg) async throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	// MARK: - Source

	/// Returns a Sendable closure that captures the object with the specified strategy.
	///
	/// This is the primary implementation that other callAsFunction variants delegate to.
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable closure providing a default value if the object was deallocated.
	///   - closure: A Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}

	/// Returns a Sendable throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable throwing closure providing a default value if the object was deallocated.
	///   - closure: A Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @Sendable () throws -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> @Sendable (repeat each Arg) throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return try defaultValue() }
			return try closure(object, repeat each arg)
		}
	}

	/// Returns a Sendable async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable async closure providing a default value if the object was deallocated.
	///   - closure: A Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @Sendable () async -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return await defaultValue() }
			return await closure(object, repeat each arg)
		}
	}

	/// Returns a Sendable async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - defaultValue: A Sendable async throwing closure providing a default value if the object was deallocated.
	///   - closure: A Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @Sendable () async throws -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> @Sendable (repeat each Arg) async throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return try await defaultValue() }
			return try await closure(object, repeat each arg)
		}
	}

	// MARK: - MainActor

	// MARK: Void

	/// Returns a @MainActor closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - closure: A @MainActor Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) -> Void
	) -> @MainActor @Sendable (repeat each Arg) -> Void {
		onMainActor(orReturn: (), in: closure)
	}

	/// Returns a @MainActor throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - closure: A @MainActor Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) throws -> Void
	) -> @MainActor @Sendable (repeat each Arg) throws -> Void {
		onMainActor(orReturn: (), in: closure)
	}

	/// Returns a @MainActor async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - closure: A @MainActor Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async -> Void
	) -> @MainActor @Sendable (repeat each Arg) async -> Void {
		onMainActor(orReturn: (), in: closure)
	}

	/// Returns a @MainActor async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - closure: A @MainActor Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Void
	) -> @MainActor @Sendable (repeat each Arg) async throws -> Void {
		onMainActor(orReturn: (), in: closure)
	}

	// MARK: Optional

	/// Returns a @MainActor closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - closure: A @MainActor Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func onMainActor<each Arg, Output>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) -> Output?
	) -> @MainActor @Sendable (repeat each Arg) -> Output? {
		onMainActor(orReturn: nil, in: closure)
	}

	/// Returns a @MainActor throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - closure: A @MainActor Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable throwing closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func onMainActor<each Arg, Output>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output?
	) -> @MainActor @Sendable (repeat each Arg) throws -> Output? {
		onMainActor(orReturn: nil, in: closure)
	}

	/// Returns a @MainActor async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - closure: A @MainActor Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable async closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func onMainActor<each Arg, Output>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async -> Output?
	) -> @MainActor @Sendable (repeat each Arg) async -> Output? {
		onMainActor(orReturn: nil, in: closure)
	}

	/// Returns a @MainActor async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned without executing the closure.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - closure: A @MainActor Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable async throwing closure that returns the closure result if the object is alive, or nil otherwise.
	@inlinable
	public func onMainActor<each Arg, Output>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output?
	) -> @MainActor @Sendable (repeat each Arg) async throws -> Output? {
		onMainActor(orReturn: nil, in: closure)
	}

	// MARK: defaultValue @autoclosure

	/// Returns a @MainActor closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - defaultValue: A @MainActor autoclosure providing a default value if the object was deallocated.
	///   - closure: A @MainActor Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) -> Output
	) -> @MainActor @Sendable (repeat each Arg) -> Output {
		onMainActor(orReturn: defaultValue, in: closure)
	}

	/// Returns a @MainActor throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - defaultValue: A @MainActor autoclosure providing a default value if the object was deallocated.
	///   - closure: A @MainActor Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> @MainActor @Sendable (repeat each Arg) throws -> Output {
		onMainActor(orReturn: defaultValue, in: closure)
	}

	/// Returns a @MainActor async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - defaultValue: A @MainActor autoclosure providing a default value if the object was deallocated.
	///   - closure: A @MainActor Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @MainActor @Sendable (repeat each Arg) async -> Output {
		onMainActor(orReturn: defaultValue, in: closure)
	}

	/// Returns a @MainActor async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - defaultValue: A @MainActor autoclosure providing a default value if the object was deallocated.
	///   - closure: A @MainActor Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> @MainActor @Sendable (repeat each Arg) async throws -> Output {
		onMainActor(orReturn: defaultValue, in: closure)
	}

	// MARK: Source

	/// Returns a @MainActor closure that captures the object with the specified strategy.
	///
	/// This is the primary implementation that other onMainActor variants delegate to.
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - defaultValue: A @MainActor Sendable closure providing a default value if the object was deallocated.
	///   - closure: A @MainActor Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (
			__CaptureRefObject,
			repeat each Arg
		) -> Output
	) -> @MainActor @Sendable (repeat each Arg) -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}

	/// Returns a @MainActor throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - defaultValue: A @MainActor Sendable throwing closure providing a default value if the object was deallocated.
	///   - closure: A @MainActor Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @MainActor @Sendable () throws -> Output,
		in closure: @escaping @MainActor @Sendable (
			__CaptureRefObject,
			repeat each Arg
		) throws -> Output
	) -> @MainActor @Sendable (repeat each Arg) throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return try defaultValue() }
			return try closure(object, repeat each arg)
		}
	}

	/// Returns a @MainActor async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - defaultValue: A @MainActor Sendable async closure providing a default value if the object was deallocated.
	///   - closure: A @MainActor Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @MainActor @Sendable () async -> Output,
		in closure: @escaping @MainActor @Sendable (
			__CaptureRefObject,
			repeat each Arg
		) async -> Output
	) -> @MainActor @Sendable (repeat each Arg) async -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return await defaultValue() }
			return await closure(object, repeat each arg)
		}
	}

	/// Returns a @MainActor async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: The closure executes on the main thread.
	///
	/// - Parameters:
	///   - defaultValue: A @MainActor Sendable async throwing closure providing a default value if the object was deallocated.
	///   - closure: A @MainActor Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A @MainActor Sendable async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @MainActor @Sendable () async throws -> Output,
		in closure: @escaping @MainActor @Sendable (
			__CaptureRefObject,
			repeat each Arg
		) async throws -> Output
	) -> @MainActor @Sendable (repeat each Arg) async throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object else { return try await defaultValue() }
			return try await closure(object, repeat each arg)
		}
	}
}
