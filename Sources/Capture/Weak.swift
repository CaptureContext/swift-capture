import Foundation

@propertyWrapper
public struct Weak<Object: AnyObject> {
  public weak var wrappedValue: Object?
  
  public var projectedValue: Object? {
    get { wrappedValue }
    set { wrappedValue = newValue }
  }
  
  public init(_ object: Object?) {
    self.init(wrappedValue: object)
  }
  
  public init() {}
  
  public init(wrappedValue: Object?) {
    self.wrappedValue = wrappedValue
  }
}

extension Weak {
  public func capture(
    in closure: @escaping (Object) -> Void
  ) -> (() -> Void) {
    return { [weak wrappedValue] in
      guard let object = wrappedValue else { return }
      closure(object)
    }
  }
  
  public func capture<T0>(
    in closure: @escaping (Object, T0) -> Void
  ) -> ((T0) -> Void) {
    return { [weak wrappedValue] params in
      guard let object = wrappedValue else { return }
      closure(object, params)
    }
  }
  
  public func capture<T0, T1>(
    in closure: @escaping (Object, T0, T1) -> Void
  ) -> ((T0, T1) -> Void) {
    return { [weak wrappedValue] t0, t1 in
      guard let object = wrappedValue else { return }
      closure(object, t0, t1)
    }
  }
  
  public func capture<T0, T1, T2>(
    in closure: @escaping (Object, T0, T1, T2) -> Void
  ) -> ((T0, T1, T2) -> Void) {
    return { [weak wrappedValue] t0, t1, t2 in
      guard let object = wrappedValue else { return }
      closure(object, t0, t1, t2)
    }
  }
  
  public func capture<T0, T1, T2, T3>(
    in closure: @escaping (Object, T0, T1, T2, T3) -> Void
  ) -> ((T0, T1, T2, T3) -> Void) {
    return { [weak wrappedValue] t0, t1, t2, t3 in
      guard let object = wrappedValue else { return }
      closure(object, t0, t1, t2, t3)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4) -> Void
  ) -> ((T0, T1, T2, T3, T4) -> Void) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4 in
      guard let object = wrappedValue else { return }
      closure(object, t0, t1, t2, t3, t4)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5) -> Void
  ) -> ((T0, T1, T2, T3, T4, T5) -> Void) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5 in
      guard let object = wrappedValue else { return }
      closure(object, t0, t1, t2, t3, t4, t5)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, T6>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6) -> Void
  ) -> ((T0, T1, T2, T3, T4, T5, T6) -> Void) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6 in
      guard let object = wrappedValue else { return }
      closure(object, t0, t1, t2, t3, t4, t5, t6)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, T6, T7>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6, T7) -> Void
  ) -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Void) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6, t7 in
      guard let object = wrappedValue else { return }
      closure(object, t0, t1, t2, t3, t4, t5, t6, t7)
    }
  }
}

extension Weak {
  public func capture<Value>(
    or defaultValue: @escaping @autoclosure () -> Value,
    in closure: @escaping (Object) -> Value
  ) -> (() -> Value) {
    return { [weak wrappedValue] in
      guard let object = wrappedValue else { return defaultValue() }
      return closure(object)
    }
  }
  
  public func capture<T0, Value>(
    or defaultValue: @escaping @autoclosure () -> Value,
    in closure: @escaping (Object, T0) -> Value
  ) -> ((T0) -> Value) {
    return { [weak wrappedValue] params in
      guard let object = wrappedValue else { return defaultValue() }
      return closure(object, params)
    }
  }
  
  public func capture<T0, T1, Value>(
    or defaultValue: @escaping @autoclosure () -> Value,
    in closure: @escaping (Object, T0, T1) -> Value
  ) -> ((T0, T1) -> Value) {
    return { [weak wrappedValue] t0, t1 in
      guard let object = wrappedValue else { return defaultValue() }
      return closure(object, t0, t1)
    }
  }
  
  public func capture<T0, T1, T2, Value>(
    or defaultValue: @escaping @autoclosure () -> Value,
    in closure: @escaping (Object, T0, T1, T2) -> Value
  ) -> ((T0, T1, T2) -> Value) {
    return { [weak wrappedValue] t0, t1, t2 in
      guard let object = wrappedValue else { return defaultValue() }
      return closure(object, t0, t1, t2)
    }
  }
  
  public func capture<T0, T1, T2, T3, Value>(
    or defaultValue: @escaping @autoclosure () -> Value,
    in closure: @escaping (Object, T0, T1, T2, T3) -> Value
  ) -> ((T0, T1, T2, T3) -> Value) {
    return { [weak wrappedValue] t0, t1, t2, t3 in
      guard let object = wrappedValue else { return defaultValue() }
      return closure(object, t0, t1, t2, t3)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, Value>(
    or defaultValue: @escaping @autoclosure () -> Value,
    in closure: @escaping (Object, T0, T1, T2, T3, T4) -> Value
  ) -> ((T0, T1, T2, T3, T4) -> Value) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4 in
      guard let object = wrappedValue else { return defaultValue() }
      return closure(object, t0, t1, t2, t3, t4)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, Value>(
    or defaultValue: @escaping @autoclosure () -> Value,
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5) -> Value
  ) -> ((T0, T1, T2, T3, T4, T5) -> Value) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5 in
      guard let object = wrappedValue else { return defaultValue() }
      return closure(object, t0, t1, t2, t3, t4, t5)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, T6, Value>(
    or defaultValue: @escaping @autoclosure () -> Value,
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6) -> Value
  ) -> ((T0, T1, T2, T3, T4, T5, T6) -> Value) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6 in
      guard let object = wrappedValue else { return defaultValue() }
      return closure(object, t0, t1, t2, t3, t4, t5, t6)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, T6, T7, Value>(
    or defaultValue: @escaping @autoclosure () -> Value,
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6, T7) -> Value
  ) -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Value) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6, t7 in
      guard let object = wrappedValue else { return defaultValue() }
      return closure(object, t0, t1, t2, t3, t4, t5, t6, t7)
    }
  }
}

extension Weak {
  public func capture<Value>(
    in closure: @escaping (Object) -> Value
  ) -> (() -> Value?) {
    return { [weak wrappedValue] in
      guard let object = wrappedValue else { return nil }
      return closure(object)
    }
  }
  
  public func capture<T0, Value>(
    in closure: @escaping (Object, T0) -> Value
  ) -> ((T0) -> Value?) {
    return { [weak wrappedValue] params in
      guard let object = wrappedValue else { return nil }
      return closure(object, params)
    }
  }
  
  public func capture<T0, T1, Value>(
    in closure: @escaping (Object, T0, T1) -> Value
  ) -> ((T0, T1) -> Value?) {
    return { [weak wrappedValue] t0, t1 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1)
    }
  }
  
  public func capture<T0, T1, T2, Value>(
    in closure: @escaping (Object, T0, T1, T2) -> Value
  ) -> ((T0, T1, T2) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2)
    }
  }
  
  public func capture<T0, T1, T2, T3, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3) -> Value
  ) -> ((T0, T1, T2, T3) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4) -> Value
  ) -> ((T0, T1, T2, T3, T4) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3, t4)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5) -> Value
  ) -> ((T0, T1, T2, T3, T4, T5) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3, t4, t5)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, T6, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6) -> Value
  ) -> ((T0, T1, T2, T3, T4, T5, T6) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3, t4, t5, t6)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, T6, T7, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6, T7) -> Value
  ) -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6, t7 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3, t4, t5, t6, t7)
    }
  }
}

extension Weak {
  public func capture<Value>(
    in closure: @escaping (Object) -> Value?
  ) -> (() -> Value?) {
    return { [weak wrappedValue] in
      guard let object = wrappedValue else { return nil }
      return closure(object)
    }
  }
  
  public func capture<T0, Value>(
    in closure: @escaping (Object, T0) -> Value?
  ) -> ((T0) -> Value?) {
    return { [weak wrappedValue] params in
      guard let object = wrappedValue else { return nil }
      return closure(object, params)
    }
  }
  
  public func capture<T0, T1, Value>(
    in closure: @escaping (Object, T0, T1) -> Value?
  ) -> ((T0, T1) -> Value?) {
    return { [weak wrappedValue] t0, t1 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1)
    }
  }
  
  public func capture<T0, T1, T2, Value>(
    in closure: @escaping (Object, T0, T1, T2) -> Value?
  ) -> ((T0, T1, T2) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2)
    }
  }
  
  public func capture<T0, T1, T2, T3, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3) -> Value?
  ) -> ((T0, T1, T2, T3) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4) -> Value?
  ) -> ((T0, T1, T2, T3, T4) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3, t4)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5) -> Value?
  ) -> ((T0, T1, T2, T3, T4, T5) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3, t4, t5)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, T6, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6) -> Value?
  ) -> ((T0, T1, T2, T3, T4, T5, T6) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3, t4, t5, t6)
    }
  }
  
  public func capture<T0, T1, T2, T3, T4, T5, T6, T7, Value>(
    in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6, T7) -> Value?
  ) -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Value?) {
    return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6, t7 in
      guard let object = wrappedValue else { return nil }
      return closure(object, t0, t1, t2, t3, t4, t5, t6, t7)
    }
  }
}

extension Weak {
  public func capture(
    _ closure: @escaping (Object) -> (() -> Void)
  ) -> (() -> Void) {
    return { [weak wrappedValue] in
      guard let object = wrappedValue else { return }
      return closure(object)()
    }
  }
}
