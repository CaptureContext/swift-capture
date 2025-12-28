import Foundation

public func capture<Object: AnyObject>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
) -> _OptionalReferenceContainerProtocol<Object> {
	switch strategy {
	case .weak:
		return Weak(object)
	case .strong:
		return Strong(object)
	case .unowned:
		return Unowned(object)
	}
}

// MARK: - Void

@inlinable
public func capture<Object: AnyObject, each Arg>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	in closure: @escaping (Object, repeat each Arg) -> Void
) -> (repeat each Arg) -> Void {
	capture(
		object,
		strategy,
		orReturn: (),
		in: closure
	)
}

@inlinable
public func capture<Object: AnyObject, each Arg>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	in closure: @escaping (Object, repeat each Arg) throws  -> Void
) -> (repeat each Arg) throws -> Void {
	capture(
		object,
		strategy,
		orReturn: (),
		in: closure
	)
}

@inlinable
public func capture<Object: AnyObject, each Arg>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	in closure: @escaping (Object, repeat each Arg) async -> Void
) -> (repeat each Arg) async -> Void {
	capture(
		object,
		strategy,
		orReturn: (),
		in: closure
	)
}

@inlinable
public func capture<Object: AnyObject, each Arg>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	in closure: @escaping (Object, repeat each Arg) async throws -> Void
) -> (repeat each Arg) async throws -> Void {
	capture(
		object,
		strategy,
		orReturn: (),
		in: closure
	)
}

// MARK: - defaultValue @autoclosure

@inlinable
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	orReturn defaultValue: @escaping @autoclosure () -> Output,
	in closure: @escaping (Object, repeat each Arg) -> Output
) -> (repeat each Arg) -> Output {
	capture(
		object,
		strategy,
		orReturn: defaultValue,
		in: closure
	)
}

@inlinable
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	orReturn defaultValue: @escaping @autoclosure () -> Output,
	in closure: @escaping (Object, repeat each Arg) throws -> Output
) -> (repeat each Arg) throws -> Output {
	capture(
		object,
		strategy,
		orReturn: defaultValue,
		in: closure
	)
}

@inlinable
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	orReturn defaultValue: @escaping @autoclosure () -> Output,
	in closure: @escaping (Object, repeat each Arg) async -> Output
) -> (repeat each Arg) async -> Output {
	capture(
		object,
		strategy,
		orReturn: defaultValue,
		in: closure
	)
}

@inlinable
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	orReturn defaultValue: @escaping @autoclosure () -> Output,
	in closure: @escaping (Object, repeat each Arg) async throws -> Output
) -> (repeat each Arg) async throws -> Output {
	capture(
		object,
		strategy,
		orReturn: defaultValue,
		in: closure
	)
}

// MARK: - Source

// MARK: Basic

@inlinable
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	orReturn defaultValue: @escaping () -> Output,
	in closure: @escaping (Object, repeat each Arg) -> Output
) -> (repeat each Arg) -> Output {
	switch strategy {
	case .weak:
		return { [weak object] (args: repeat each Arg) in
			guard let object else { return defaultValue() }
			return closure(object, repeat each args)
		}
	case .unowned:
		return { [unowned object] (args: repeat each Arg) in
			guard let object else { return defaultValue() }
			return closure(object, repeat each args)
		}
	case .strong:
		return { [object] (args: repeat each Arg) in
			guard let object else { return defaultValue() }
			return closure(object, repeat each args)
		}
	}
}

// MARK: Throws

@inlinable
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	orReturn defaultValue: @escaping () throws -> Output,
	in closure: @escaping (Object, repeat each Arg) throws  -> Output
) -> (repeat each Arg) throws -> Output {
	switch strategy {
	case .weak:
		return { [weak object] (args: repeat each Arg) in
			guard let object else { return try defaultValue() }
			return try closure(object, repeat each args)
		}
	case .unowned:
		return { [unowned object] (args: repeat each Arg) in
			guard let object else { return try defaultValue() }
			return try closure(object, repeat each args)
		}
	case .strong:
		return { [object] (args: repeat each Arg) in
			guard let object else { return try defaultValue() }
			return try closure(object, repeat each args)
		}
	}
}

// MARK: Async

@inlinable
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	orReturn defaultValue: @escaping () async -> Output,
	in closure: @escaping (Object, repeat each Arg) async -> Output
) -> (repeat each Arg) async -> Output {
	switch strategy {
	case .weak:
		return { [weak object] (args: repeat each Arg) in
			guard let object else { return await defaultValue() }
			return await closure(object, repeat each args)
		}
	case .unowned:
		return { [unowned object] (args: repeat each Arg) in
			guard let object else { return await defaultValue() }
			return await closure(object, repeat each args)
		}
	case .strong:
		return { [object] (args: repeat each Arg) in
			guard let object else { return await defaultValue() }
			return await closure(object, repeat each args)
		}
	}
}

// MARK: AsyncThrows

@inlinable
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object?,
	_ strategy: ObjectCaptureStrategy = .weak,
	orReturn defaultValue: @escaping () async throws -> Output,
	in closure: @escaping (Object, repeat each Arg) async throws -> Output
) -> (repeat each Arg) async throws -> Output {
	switch strategy {
	case .weak:
		return { [weak object] (args: repeat each Arg) in
			guard let object else { return try await defaultValue() }
			return try await closure(object, repeat each args)
		}
	case .unowned:
		return { [unowned object] (args: repeat each Arg) in
			guard let object else { return try await defaultValue() }
			return try await closure(object, repeat each args)
		}
	case .strong:
		return { [object] (args: repeat each Arg) in
			guard let object else { return try await defaultValue() }
			return try await closure(object, repeat each args)
		}
	}
}
