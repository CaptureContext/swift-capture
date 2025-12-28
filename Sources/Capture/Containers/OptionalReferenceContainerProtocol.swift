import Foundation
import ConcurrencyExtras

public typealias _SendableOptionalReferenceContainerProtocol<__CaptureRefObject> = _OptionalReferenceContainerProtocol<__CaptureRefObject> & Sendable

/// Protocol to generalize Weak and Weak.Box APIs
public protocol _OptionalReferenceContainerProtocol<__CaptureRefObject> {
	associatedtype __CaptureRefObject: AnyObject
	var __optionalRefObject: __CaptureRefObject? { get }
}

extension _OptionalReferenceContainerProtocol {
	public var uncheckedSendable: _SendableOptionalReferenceContainerProtocol<__CaptureRefObject> {
		UncheckedSendable(self)
	}
}

extension UncheckedSendable: _OptionalReferenceContainerProtocol where Value: _OptionalReferenceContainerProtocol {
	public var __optionalRefObject: Value.__CaptureRefObject? { value.__optionalRefObject }
}

extension _OptionalReferenceContainerProtocol {

	// MARK: - Void

	@inlinable
	public func capture<each Arg>(
		_ strategy: ObjectCaptureStrategy = .weak,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Void
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
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Void
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
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Void
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
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Void
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
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output
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
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output
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
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output
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
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output
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
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		Capture.capture(
			__optionalRefObject,
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping () throws -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		Capture.capture(
			__optionalRefObject,
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping () async -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		Capture.capture(
			__optionalRefObject,
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	@inlinable
	public func capture<each Arg, Output>(
		_ strategy: ObjectCaptureStrategy = .weak,
		orReturn defaultValue: @escaping () async throws -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		Capture.capture(
			__optionalRefObject,
			strategy,
			orReturn: defaultValue,
			in: closure
		)
	}

	// MARK: - Void

	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Void
	) -> (repeat each Arg) -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Void
	) -> (repeat each Arg) throws -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Void
	) -> (repeat each Arg) async -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Void
	) -> (repeat each Arg) async throws -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	// MARK: - defaultValue @autoclosure

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	// MARK: - Source

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping () throws -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return try defaultValue() }
			return try closure(object, repeat each arg)
		}
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping () async -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return await defaultValue() }
			return await closure(object, repeat each arg)
		}
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping () async throws -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return try await defaultValue() }
			return try await closure(object, repeat each arg)
		}
	}
}

// MARK: - Sendable

extension _OptionalReferenceContainerProtocol where Self: Sendable {

	// MARK: - Void

	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Void
	) -> @Sendable (repeat each Arg) -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Void
	) -> @Sendable (repeat each Arg) throws -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Void
	) -> @Sendable (repeat each Arg) async -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Void
	) -> @Sendable (repeat each Arg) async throws -> Void {
		callAsFunction(orReturn: (), in: closure)
	}

	// MARK: - defaultValue @autoclosure

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> @Sendable (repeat each Arg) throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> @Sendable (repeat each Arg) async throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	// MARK: - Source

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @Sendable () throws -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> @Sendable (repeat each Arg) throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return try defaultValue() }
			return try closure(object, repeat each arg)
		}
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @Sendable () async -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return await defaultValue() }
			return await closure(object, repeat each arg)
		}
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		orReturn defaultValue: @escaping @Sendable () async throws -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> @Sendable (repeat each Arg) async throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return try await defaultValue() }
			return try await closure(object, repeat each arg)
		}
	}

	// MARK: - MainActor

	// MARK: Void

	@inlinable
	public func onMainActor<each Arg>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) -> Void
	) -> @MainActor @Sendable (repeat each Arg) -> Void {
		onMainActor(orReturn: (), in: closure)
	}

	@inlinable
	public func onMainActor<each Arg>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) throws -> Void
	) -> @MainActor @Sendable (repeat each Arg) throws -> Void {
		onMainActor(orReturn: (), in: closure)
	}

	@inlinable
	public func onMainActor<each Arg>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async -> Void
	) -> @MainActor @Sendable (repeat each Arg) async -> Void {
		onMainActor(orReturn: (), in: closure)
	}

	@inlinable
	public func onMainActor<each Arg>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Void
	) -> @MainActor @Sendable (repeat each Arg) async throws -> Void {
		onMainActor(orReturn: (), in: closure)
	}

	// MARK: defaultValue @autoclosure

	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) -> Output
	) -> @MainActor @Sendable (repeat each Arg) -> Output {
		onMainActor(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> @MainActor @Sendable (repeat each Arg) throws -> Output {
		onMainActor(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @MainActor @Sendable (repeat each Arg) async -> Output {
		onMainActor(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @autoclosure @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> @MainActor @Sendable (repeat each Arg) async throws -> Output {
		onMainActor(orReturn: defaultValue, in: closure)
	}

	// MARK: Source

	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @MainActor @Sendable () -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) -> Output
	) -> @MainActor @Sendable (repeat each Arg) -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}

	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @MainActor @Sendable () throws -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> @MainActor @Sendable (repeat each Arg) throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return try defaultValue() }
			return try closure(object, repeat each arg)
		}
	}

	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @MainActor @Sendable () async -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @MainActor @Sendable (repeat each Arg) async -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return await defaultValue() }
			return await closure(object, repeat each arg)
		}
	}

	@inlinable
	public func onMainActor<each Arg, Output>(
		orReturn defaultValue: @escaping @MainActor @Sendable () async throws -> Output,
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> @MainActor @Sendable (repeat each Arg) async throws -> Output {
		return { [self] (arg: repeat each Arg) in
			guard let object = self.__optionalRefObject else { return try await defaultValue() }
			return try await closure(object, repeat each arg)
		}
	}
}
