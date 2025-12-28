import Foundation

public enum ObjectCaptureStrategy: Sendable {
	case `weak`
	case `strong`
	case `unowned`
}

extension NSObject: CapturableObjectProtocol {}

public protocol CapturableObjectProtocol: AnyObject {}

extension CapturableObjectProtocol {

	@inlinable
	public func capture(_ strategy: ObjectCaptureStrategy = .weak) -> _OptionalReferenceContainerProtocol<Self> {
		Capture.capture(self, strategy)
	}

	// MARK: - Void

	@inlinable
	public func capture<each Arg>(
		_ strategy: ObjectCaptureStrategy = .weak,
		in closure: @escaping (Self, repeat each Arg) -> Void
	) -> (repeat each Arg) -> Void {
		capture(
			strategy,
			orReturn: (),
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg>(
		_ strategy: ObjectCaptureStrategy = .weak,
		in closure: @escaping (Self, repeat each Arg) throws -> Void
	) -> (repeat each Arg) throws -> Void {
		capture(
			strategy,
			orReturn: (),
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg>(
		_ strategy: ObjectCaptureStrategy = .weak,
		in closure: @escaping (Self, repeat each Arg) async -> Void
	) -> (repeat each Arg) async -> Void {
		capture(
			strategy,
			orReturn: (),
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg>(
		_ strategy: ObjectCaptureStrategy = .weak,
		in closure: @escaping (Self, repeat each Arg) async throws -> Void
	) -> (repeat each Arg) async throws -> Void {
		capture(
			strategy,
			orReturn: (),
			in: closure
		)
	}

	// MARK: - defaultValue @autoclosure

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Self, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		capture(
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Self, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		capture(
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Self, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		capture(
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (Self, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		capture(
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	// MARK: - Source

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping () -> Output,
		in closure: @escaping (Self, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		Capture.capture(
			self,
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping () throws -> Output,
		in closure: @escaping (Self, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		Capture.capture(
			self,
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping () async -> Output,
		in closure: @escaping (Self, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		Capture.capture(
			self,
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping () async throws -> Output,
		in closure: @escaping (Self, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		Capture.capture(
			self,
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}
}
