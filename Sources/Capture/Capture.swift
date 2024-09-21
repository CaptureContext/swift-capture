import Foundation

// MARK: - Void result closures

/// Weakly captures an object in non-parametrized void result closure.
@inlinable
public func capture<Object: AnyObject>(
	_ object: Object,
	in closure: @escaping (Object) -> Void
) -> () -> Void {
	return Weak(object).capture(in: closure)
}

/// Weakly captures an object in non-parametrized lazy void result closure.
@inlinable
public func capture<Object: AnyObject>(
	_ object: Object,
	in closure: @escaping (Object) -> () -> Void
) -> () -> Void {
	Weak(object).capture(in: closure)
}

/// Weakly captures an object in parametrized void result closure.
public func capture<Object: AnyObject, each Arg>(
	_ object: Object,
	in closure: @escaping (Object, repeat each Arg) -> Void
) -> (repeat each Arg) -> Void {
	Weak(object).capture(in: closure)
}

// MARK: Sendable

/// Weakly captures an object in non-parametrized void result closure.
@inlinable
public func capture<Object: AnyObject & Sendable>(
	_ object: Object,
	in closure: @escaping @Sendable (Object) -> Void
) -> @Sendable () -> Void {
	return Weak(object)._capture(in: closure)
}

/// Weakly captures an object in non-parametrized lazy void result closure.
@inlinable
public func capture<Object: AnyObject & Sendable>(
	_ object: Object,
	in closure: @escaping @Sendable (Object) -> () -> Void
) -> @Sendable () -> Void {
	Weak(object)._capture(in: closure)
}

/// Weakly captures an object in parametrized void result closure.
public func _capture<Object: AnyObject & Sendable, each Arg>(
	_ object: Object,
	in closure: @escaping @Sendable (Object, repeat each Arg) -> Void
) -> @Sendable (repeat each Arg) -> Void {
	Weak(object)._capture(in: closure)
}

// MARK: - Non-void result closures

/// Weakly captures an object in non-parametrized non-void result closure.
@inlinable
public func capture<Object: AnyObject, Output>(
	_ object: Object,
	orReturn defaultValue: @escaping @autoclosure () -> Output,
	in closure: @escaping (Object) -> Output
) -> () -> Output {
	Weak(object).capture(orReturn: defaultValue(), in: closure)
}

/// Weakly captures an object in non-parametrized lazy non-void result closure.
@inlinable
public func capture<Object: AnyObject, Output>(
	_ object: Object,
	orReturn defaultValue: @escaping @autoclosure () -> Output,
	in closure: @escaping (Object) -> () -> Output
) -> () -> Output {
	Weak(object).capture(orReturn: defaultValue(), in: closure)
}

/// Weakly captures an object in parametrized non-void result closure.
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object,
	orReturn defaultValue: @escaping @autoclosure () -> Output,
	in closure: @escaping (Object, repeat each Arg) -> Output
) -> (repeat each Arg) -> Output {
	Weak(object).capture(orReturn: defaultValue(), in: closure)
}

// MARK: Sendable

/// Weakly captures an object in non-parametrized non-void result closure.
@inlinable
public func _capture<Object: AnyObject & Sendable, Output>(
	_ object: Object,
	orReturn defaultValue: @escaping @autoclosure () -> Output,
	in closure: @escaping (Object) -> Output
) -> () -> Output {
	Weak(object).capture(orReturn: defaultValue(), in: closure)
}

/// Weakly captures an object in non-parametrized lazy non-void result closure.
@inlinable
public func _capture<Object: AnyObject & Sendable, Output>(
	_ object: Object,
	orReturn defaultValue: @escaping @autoclosure () -> Output,
	in closure: @escaping (Object) -> () -> Output
) -> () -> Output {
	Weak(object).capture(orReturn: defaultValue(), in: closure)
}

/// Weakly captures an object in parametrized non-void result closure.
public func _capture<Object: AnyObject & Sendable, each Arg, Output>(
	_ object: Object,
	orReturn defaultValue: @escaping @autoclosure @Sendable () -> Output,
	in closure: @escaping @Sendable (Object, repeat each Arg) -> Output
) -> @Sendable (repeat each Arg) -> Output {
	Weak(object)._capture(orReturn: defaultValue(), in: closure)
}

// MARK: - Non-void optional result closures

/// Weakly captures an object in non-parametrized non-void optional result closure.
@inlinable
public func capture<Object: AnyObject, Output>(
	_ object: Object,
	in closure: @escaping (Object) -> Output?
) -> () -> Output? {
	Weak(object).capture(in: closure)
}

/// Weakly captures an object in non-parametrized lazy non-void optional result closure.
@inlinable
public func capture<Object: AnyObject, Output>(
  _ object: Object,
  in closure: @escaping (Object) -> () -> Output?
) -> () -> Output? {
  Weak(object).capture(in: closure)
}

/// Weakly captures an object in parametrized non-void optional result closure.
public func capture<Object: AnyObject, each Arg, Output>(
	_ object: Object,
	in closure: @escaping (Object, repeat each Arg) -> Output?
) -> (repeat each Arg) -> Output? {
	Weak(object).capture(in: closure)
}

// MARK: Sendable

/// Weakly captures an object in non-parametrized non-void optional result closure.
@inlinable
public func _capture<Object: AnyObject & Sendable, Output>(
	_ object: Object,
	in closure: @escaping @Sendable (Object) -> Output?
) -> @Sendable () -> Output? {
	Weak(object)._capture(in: closure)
}

/// Weakly captures an object in non-parametrized lazy non-void optional result closure.
@inlinable
public func _capture<Object: AnyObject & Sendable, Output>(
	_ object: Object,
	in closure: @escaping @Sendable (Object) -> () -> Output?
) -> @Sendable () -> Output? {
	Weak(object)._capture(in: closure)
}

/// Weakly captures an object in parametrized non-void optional result closure.
public func _capture<Object: AnyObject & Sendable, each Arg, Output>(
	_ object: Object,
	in closure: @escaping @Sendable (Object, repeat each Arg) -> Output?
) -> @Sendable (repeat each Arg) -> Output? {
	Weak(object)._capture(in: closure)
}

