import Foundation


public protocol CapturableObjectProtocol: AnyObject {}

public enum ObjectCaptureStrategy: Sendable {
	case `weak`
	case `strong`
	case `unowned`
}

extension CapturableObjectProtocol {
	@inlinable
	public var capture: some CaptureItemProtocol<Self> {
		CaptureItem(Captured(self, as: .weak))
	}

	// MARK: - Void

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

	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping () -> Output,
		in closure: @escaping (Self, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		capture.as(strategy)(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping () throws -> Output,
		in closure: @escaping (Self, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		capture.as(strategy)(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping () async -> Output,
		in closure: @escaping (Self, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		capture.as(strategy)(orReturn: defaultValue, in: closure)
	}

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

	@inlinable
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

	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable () -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		capture.as(strategy).uncheckedSendable(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable () throws -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) throws -> Output
	) -> @Sendable (repeat each Arg) throws -> Output {
		capture.as(strategy).uncheckedSendable(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func capture<each Arg, Output>(
		as strategy: ObjectCaptureStrategy,
		orReturn defaultValue: @escaping @Sendable () async -> Output,
		in closure: @escaping @Sendable (Self, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		capture.as(strategy).uncheckedSendable(orReturn: defaultValue, in: closure)
	}

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
