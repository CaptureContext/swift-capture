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
	public var capture: some CaptureItemProtocol<__CaptureRefObject> {
		CaptureItem(self)
	}
}

extension __OptionalReferenceContainerProtocol {
	public var uncheckedSendable: some _SendableCaptureItemProtocol<__CaptureRefObject> {
		CaptureItem.UncheckedSendable(self)
	}
}

extension CaptureItemProtocol {
	@usableFromInline
	var object: Object? { __refObject }

	@inlinable
	public func `as`(
		_ overrideCaptureStrategy: ObjectCaptureStrategy
	) -> some CaptureItemProtocol<Object> {
		return CaptureItem(Captured(
			safe: object,
			as: overrideCaptureStrategy
		))
	}

	@inlinable
	public func `as`(
		unsafe overrideCaptureStrategy: ObjectCaptureStrategy
	) -> some CaptureItemProtocol<Object> {
		return CaptureItem(Captured(
			unsafe: object,
			as: overrideCaptureStrategy
		))
	}

	// MARK: - Swift bug workaround

	@inlinable
	public func orReturn<each Arg, Output>(
		_ defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output
	) -> (repeat each Arg) -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func orReturn<each Arg, Output>(
		_ defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> (repeat each Arg) throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func orReturn<each Arg, Output: Sendable>(
		_ defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output
	) -> (repeat each Arg) async -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func orReturn<each Arg, Output: Sendable>(
		_ defaultValue: @escaping @autoclosure () -> Output,
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> (repeat each Arg) async throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
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

	// MARK: - Optional

	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) -> Output?
	) -> (repeat each Arg) -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) throws -> Output?
	) -> (repeat each Arg) throws -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async -> Output?
	) -> (repeat each Arg) async -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping (__CaptureRefObject, repeat each Arg) async throws -> Output?
	) -> (repeat each Arg) async throws -> Output? {
		callAsFunction(orReturn: nil, in: closure)
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
			guard let object else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}

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

	@inlinable
	public func orReturn<each Arg, Output>(
		_ defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Output
	) -> @Sendable (repeat each Arg) -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func orReturn<each Arg, Output>(
		_ defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output
	) -> @Sendable (repeat each Arg) throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func orReturn<each Arg, Output: Sendable>(
		_ defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func orReturn<each Arg, Output: Sendable>(
		_ defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output
	) -> @Sendable (repeat each Arg) async throws -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

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

	// MARK: - Optional

	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) -> Output?
	) -> @Sendable (repeat each Arg) -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output?
	) -> @Sendable (repeat each Arg) throws -> Output? {
		callAsFunction(orReturn: nil, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Output?
	) -> @Sendable (repeat each Arg) async -> Output? {
		callAsFunction(orReturn: { nil }, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output>(
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output?
	) -> @Sendable (repeat each Arg) async throws -> Output? {
		callAsFunction(orReturn: { nil }, in: closure)
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
	public func callAsFunction<each Arg, Output: Sendable>(
		orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
		in closure: @escaping @Sendable (__CaptureRefObject, repeat each Arg) async -> Output
	) -> @Sendable (repeat each Arg) async -> Output {
		callAsFunction(orReturn: defaultValue, in: closure)
	}

	@inlinable
	public func callAsFunction<each Arg, Output: Sendable>(
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
			guard let object else { return defaultValue() }
			return closure(object, repeat each arg)
		}
	}

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

	// MARK: Optional

	@inlinable
	public func onMainActor<each Arg, Output>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) -> Output?
	) -> @MainActor @Sendable (repeat each Arg) -> Output? {
		onMainActor(orReturn: nil, in: closure)
	}

	@inlinable
	public func onMainActor<each Arg, Output>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) throws -> Output?
	) -> @MainActor @Sendable (repeat each Arg) throws -> Output? {
		onMainActor(orReturn: nil, in: closure)
	}

	@inlinable
	public func onMainActor<each Arg, Output>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async -> Output?
	) -> @MainActor @Sendable (repeat each Arg) async -> Output? {
		onMainActor(orReturn: nil, in: closure)
	}

	@inlinable
	public func onMainActor<each Arg, Output>(
		in closure: @escaping @MainActor @Sendable (__CaptureRefObject, repeat each Arg) async throws -> Output?
	) -> @MainActor @Sendable (repeat each Arg) async throws -> Output? {
		onMainActor(orReturn: nil, in: closure)
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
