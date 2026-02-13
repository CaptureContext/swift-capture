import Foundation


/// A protocol indicating that a reference type can safely capture itself in closures.
public protocol CapturableObjectProtocol: AnyObject {}

/// Strategy for capturing an object in a closure.
public enum ObjectCaptureStrategy: Sendable {
	/// Capture the object weakly, allowing it to be deallocated.
	case `weak`

	/// Capture the object strongly, preventing deallocation.
	case `strong`

	/// Capture the object as unowned, assuming it outlives the closure.
	case `unowned`
}

extension CapturableObjectProtocol {
	/// Accesses the object's capture interface with default weak strategy.
	@inlinable
	public var capture: some CaptureItemProtocol<Self> {
		CaptureItem(Captured(self, as: .weak))
	}

	// MARK: - Void

	/// Returns a closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A closure that checks object liveness before executing the provided closure.
	@inlinable
	public func capture<each Arg>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping (Self, repeat each Arg) -> Void
	) -> (repeat each Arg) -> Void {
		capture(
			as: strategy,
			orReturn: (),
			in: closure
		)
	}

	/// Returns a throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func capture<each Arg>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping (Self, repeat each Arg) throws -> Void
	) -> (repeat each Arg) throws -> Void {
		capture(
			as: strategy,
			orReturn: (),
			in: closure
		)
	}

	/// Returns an async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: An async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func capture<each Arg>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping (Self, repeat each Arg) async -> Void
	) -> (repeat each Arg) async -> Void {
		capture(
			as: strategy,
			orReturn: (),
			in: closure
		)
	}

	/// Returns an async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: An async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func capture<each Arg>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping (Self, repeat each Arg) async throws -> Void
	) -> (repeat each Arg) async throws -> Void {
		capture(
			as: strategy,
			orReturn: (),
			in: closure
		)
	}

	// MARK: - Optional

	/// Returns a closure that captures the object with optional result.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A closure that returns nil if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping (Self, repeat each Arg) -> Output?
	) -> (repeat each Arg) -> Output? {
		capture(
			as: strategy,
			orReturn: nil,
			in: closure
		)
	}

	/// Returns a throwing closure that captures the object with optional result.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A throwing closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A throwing closure that returns nil if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping (Self, repeat each Arg) throws -> Output?
	) -> (repeat each Arg) throws -> Output? {
		capture(
			as: strategy,
			orReturn: nil,
			in: closure
		)
	}

	/// Returns an async closure that captures the object with optional result.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: An async closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     An async closure that returns nil if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping (Self, repeat each Arg) async -> Output?
	) -> (repeat each Arg) async -> Output? {
		capture(
			as: strategy,
			orReturn: nil,
			in: closure
		)
	}

	/// Returns an async throwing closure that captures the object with optional result.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: An async throwing closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     An async throwing closure that returns nil if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping (Self, repeat each Arg) async throws -> Output?
	) -> (repeat each Arg) async throws -> Output? {
		capture(
			as: strategy,
			orReturn: nil,
			in: closure
		)
	}

	// MARK: - defaultValue @autoclosure

	/// Returns a closure that captures the object with an autoclosure default value.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: A closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Self, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		capture(
			as: strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	/// Returns a throwing closure that captures the object with an autoclosure default value.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: A throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A throwing closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Self, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		capture(
			as: strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	/// Returns an async closure that captures the object with an autoclosure default value.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: An async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Self, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		capture(
			as: strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	/// Returns an async throwing closure that captures the object with an autoclosure default value.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: An autoclosure providing a default value if the object was deallocated.
	///   - closure: An async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async throwing closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Self, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		capture(
			as: strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	// MARK: - Source

	/// Returns a closure that captures the object with a default value closure.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value closure is executed; otherwise the provided closure executes.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A closure providing a default value if the object was deallocated.
	///   - closure: A closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping () -> Output,
		in closure: @escaping (Self, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		capture.as(strategy)(orReturn: defaultValue, in: closure)
	}

	/// Returns a throwing closure that captures the object with a default value closure.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value closure is executed; otherwise the provided closure executes.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A throwing closure providing a default value if the object was deallocated.
	///   - closure: A throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A throwing closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping () throws -> Output,
		in closure: @escaping (Self, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		capture.as(strategy)(orReturn: defaultValue, in: closure)
	}

	/// Returns an async closure that captures the object with a default value closure.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value closure is executed; otherwise the provided closure executes.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: An async closure providing a default value if the object was deallocated.
	///   - closure: An async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping () async -> Output,
		in closure: @escaping (Self, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		capture.as(strategy)(orReturn: defaultValue, in: closure)
	}

	/// Returns an async throwing closure that captures the object with a default value closure.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value closure is executed; otherwise the provided closure executes.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: An async throwing closure providing a default value if the object was deallocated.
	///   - closure: An async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     An async throwing closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping () async throws -> Output,
		in closure: @escaping (Self, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		capture.as(strategy)(orReturn: defaultValue, in: closure)
	}
}

extension CapturableObjectProtocol where Self: Sendable {
	// MARK: - Void
	/// Returns a Sendable closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable closure that checks object liveness before executing the provided closure.	@inlinable
	public func capture<each Arg>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping @Sendable (Self, repeat each Arg) -> Void
	) -> @Sendable (repeat each Arg) -> Void {
		capture(
			as: strategy,
			orReturn: (),
			in: closure
		)
	}

	/// Returns a Sendable throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func capture<each Arg>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping @Sendable (Self, repeat each Arg) throws -> Void
	) -> @Sendable (repeat each Arg) throws -> Void {
		capture(
			as: strategy,
			orReturn: (),
			in: closure
		)
	}

	/// Returns a Sendable async closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async closure that checks object liveness before executing the provided closure.
	@inlinable
	public func capture<each Arg>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping @Sendable (Self, repeat each Arg) async -> Void
	) -> @Sendable (repeat each Arg) async -> Void {
		capture(
			as: strategy,
			orReturn: (),
			in: closure
		)
	}

	/// Returns a Sendable async throwing closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the closure is not executed.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async throwing closure that checks object liveness before executing the provided closure.
	@inlinable
	public func capture<each Arg>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping @Sendable (Self, repeat each Arg) async throws -> Void
	) -> @Sendable (repeat each Arg) async throws -> Void {
		capture(
			as: strategy,
			orReturn: (),
			in: closure
		)
	}

	// MARK: - Optional

	/// Returns a Sendable closure that captures the object with optional result.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A Sendable closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A Sendable closure that returns nil if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping @Sendable (Self, repeat each Arg) -> Output?
	) -> @Sendable (repeat each Arg) -> Output? {
		capture(
			as: strategy,
			orReturn: nil,
			in: closure
		)
	}

	/// Returns a Sendable throwing closure that captures the object with optional result.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A Sendable throwing closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A Sendable throwing closure that returns nil if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping @Sendable (Self, repeat each Arg) throws -> Output?
	) -> @Sendable (repeat each Arg) throws -> Output? {
		capture(
			as: strategy,
			orReturn: nil,
			in: closure
		)
	}

	/// Returns a Sendable async closure that captures the object with optional result.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A Sendable async closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A Sendable async closure that returns nil if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping @Sendable (Self, repeat each Arg) async -> Output?
	) -> @Sendable (repeat each Arg) async -> Output? {
		capture(
			as: strategy,
			orReturn: { nil },
			in: closure
		)
	}

	/// Returns a Sendable async throwing closure that captures the object with optional result.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, nil is returned.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - closure: A Sendable async throwing closure receiving the captured object and returning an optional result.
	/// - Returns:
	///     A Sendable async throwing closure that returns nil if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		in closure: @escaping @Sendable (Self, repeat each Arg) async throws -> Output?
	) -> @Sendable (repeat each Arg) async throws -> Output? {
		capture(
			as: strategy,
			orReturn: { nil },
			in: closure
		)
	}

	// MARK: - defaultValue @autoclosure

	/// Returns a Sendable closure that captures the object with an autoclosure default value.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable @autoclosure () -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		capture(
			as: strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	/// Returns a Sendable throwing closure that captures the object with an autoclosure default value.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable throwing closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable @autoclosure () -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) throws -> Output
	) -> @Sendable (repeat each Arg) throws -> Output {
		capture(
			as: strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	/// Returns a Sendable async closure that captures the object with an autoclosure default value.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output: Sendable>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable @autoclosure () -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		capture(
			as: strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	/// Returns a Sendable async throwing closure that captures the object with an autoclosure default value.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A Sendable autoclosure providing a default value if the object was deallocated.
	///   - closure: A Sendable async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async throwing closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output: Sendable>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable @autoclosure () -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) async throws -> Output
	) -> @Sendable (repeat each Arg) async throws -> Output {
		capture(
			as: strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	// MARK: - Source

	/// Returns a Sendable closure that captures the object with a default value closure.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value closure is executed; otherwise the provided closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A Sendable closure providing a default value if the object was deallocated.
	///   - closure: A Sendable closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable () -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		capture.as(strategy).uncheckedSendable(orReturn: defaultValue, in: closure)
	}

	/// Returns a Sendable throwing closure that captures the object with a default value closure.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value closure is executed; otherwise the provided closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A Sendable throwing closure providing a default value if the object was deallocated.
	///   - closure: A Sendable throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable throwing closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable () throws -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) throws -> Output
	) -> @Sendable (repeat each Arg) throws -> Output {
		capture.as(strategy).uncheckedSendable(orReturn: defaultValue, in: closure)
	}

	/// Returns a Sendable async closure that captures the object with a default value closure.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value closure is executed; otherwise the provided closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A Sendable async closure providing a default value if the object was deallocated.
	///   - closure: A Sendable async closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async closure that returns the default value if the object was deallocated, or the closure result otherwise.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable () async -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		capture.as(strategy).uncheckedSendable(orReturn: defaultValue, in: closure)
	}

	/// Returns a closure that captures the object with the specified strategy.
	///
	/// The returned closure contains a guard check: it verifies the captured object is still alive
	/// when called. If deallocated, the default value is returned; otherwise the closure executes.
	///
	/// - Note: Only available when `Self` conforms to `Sendable`.
	///
	/// - Parameters:
	///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`).
	///   - defaultValue: A closure providing a default value if the object was deallocated.
	///   - closure: An async throwing closure receiving the captured object and any further arguments.
	/// - Returns:
	///     A Sendable async throwing closure that checks object liveness before executing
	///     the provided closure.
	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable () async throws -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) async throws -> Output
	) -> @Sendable (repeat each Arg) async throws -> Output {
		capture.as(strategy).uncheckedSendable(orReturn: defaultValue, in: closure)
	}
}

extension NSObject: CapturableObjectProtocol {}
