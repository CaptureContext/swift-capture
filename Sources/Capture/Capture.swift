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
