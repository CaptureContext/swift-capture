import Foundation

public protocol Weakifiable: AnyObject {}
extension NSObject: Weakifiable {}

extension Weakifiable {
    public func capture(in closure: @escaping (Self) -> Void)
    -> (() -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0>(in closure: @escaping (Self, T0) -> Void)
    -> ((T0) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1>(in closure: @escaping (Self, T0, T1) -> Void)
    -> ((T0, T1) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2>(in closure: @escaping (Self, T0, T1, T2) -> Void)
    -> ((T0, T1, T2) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3>(in closure: @escaping (Self, T0, T1, T2, T3) -> Void)
    -> ((T0, T1, T2, T3) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4>(in closure: @escaping (Self, T0, T1, T2, T3, T4) -> Void)
    -> ((T0, T1, T2, T3, T4) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5>(in closure: @escaping (Self, T0, T1, T2, T3, T4, T5) -> Void)
    -> ((T0, T1, T2, T3, T4, T5) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6>(in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6) -> Void)
    -> ((T0, T1, T2, T3, T4, T5, T6) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6, T7>(in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6, T7) -> Void)
    -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Void) { Weak(self).capture(in: closure) }
}

extension Weakifiable {
    public func capture<Value>(
        or defaultValue: @escaping @autoclosure () -> Value,
        in closure: @escaping (Self) -> Value
    ) -> (() -> Value) { Weak(self).capture(or: defaultValue(), in: closure) }
    
    public func capture<T0, Value>(
        or defaultValue: @escaping @autoclosure () -> Value,
        in closure: @escaping (Self, T0) -> Value
    ) -> ((T0) -> Value) { Weak(self).capture(or: defaultValue(), in: closure) }
    
    public func capture<T0, T1, Value>(
        or defaultValue: @escaping @autoclosure () -> Value,
        in closure: @escaping (Self, T0, T1) -> Value
    ) -> ((T0, T1) -> Value) { Weak(self).capture(or: defaultValue(), in: closure) }
    
    public func capture<T0, T1, T2, Value>(
        or defaultValue: @escaping @autoclosure () -> Value,
        in closure: @escaping (Self, T0, T1, T2) -> Value
    ) -> ((T0, T1, T2) -> Value) { Weak(self).capture(or: defaultValue(), in: closure) }
    
    public func capture<T0, T1, T2, T3, Value>(
        or defaultValue: @escaping @autoclosure () -> Value,
        in closure: @escaping (Self, T0, T1, T2, T3) -> Value
    ) -> ((T0, T1, T2, T3) -> Value) { Weak(self).capture(or: defaultValue(), in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, Value>(
        or defaultValue: @escaping @autoclosure () -> Value,
        in closure: @escaping (Self, T0, T1, T2, T3, T4) -> Value
    ) -> ((T0, T1, T2, T3, T4) -> Value) { Weak(self).capture(or: defaultValue(), in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, Value>(
        or defaultValue: @escaping @autoclosure () -> Value,
        in closure: @escaping (Self, T0, T1, T2, T3, T4, T5) -> Value
    ) -> ((T0, T1, T2, T3, T4, T5) -> Value) { Weak(self).capture(or: defaultValue(), in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6, Value>(
        or defaultValue: @escaping @autoclosure () -> Value,
        in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6) -> Value
    ) -> ((T0, T1, T2, T3, T4, T5, T6) -> Value) { Weak(self).capture(or: defaultValue(), in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6, T7, Value>(
        or defaultValue: @escaping @autoclosure () -> Value,
        in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6, T7) -> Value
    ) -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Value) { Weak(self).capture(or: defaultValue(), in: closure) }
}

extension Weakifiable {
    public func capture<Value>(
        in closure: @escaping (Self) -> Value
    ) -> (() -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, Value>(
        in closure: @escaping (Self, T0) -> Value
    ) -> ((T0) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, Value>(
        in closure: @escaping (Self, T0, T1) -> Value
    ) -> ((T0, T1) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, Value>(
        in closure: @escaping (Self, T0, T1, T2) -> Value
    ) -> ((T0, T1, T2) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3) -> Value
    ) -> ((T0, T1, T2, T3) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3, T4) -> Value
    ) -> ((T0, T1, T2, T3, T4) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3, T4, T5) -> Value
    ) -> ((T0, T1, T2, T3, T4, T5) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6) -> Value
    ) -> ((T0, T1, T2, T3, T4, T5, T6) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6, T7, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6, T7) -> Value
    ) -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Value?) { Weak(self).capture(in: closure) }
}

extension Weakifiable {
    public func capture<Value>(
        in closure: @escaping (Self) -> Value?
    ) -> (() -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, Value>(
        in closure: @escaping (Self, T0) -> Value?
    ) -> ((T0) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, Value>(
        in closure: @escaping (Self, T0, T1) -> Value?
    ) -> ((T0, T1) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, Value>(
        in closure: @escaping (Self, T0, T1, T2) -> Value?
    ) -> ((T0, T1, T2) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3) -> Value?
    ) -> ((T0, T1, T2, T3) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3, T4) -> Value?
    ) -> ((T0, T1, T2, T3, T4) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3, T4, T5) -> Value?
    ) -> ((T0, T1, T2, T3, T4, T5) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6) -> Value?
    ) -> ((T0, T1, T2, T3, T4, T5, T6) -> Value?) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6, T7, Value>(
        in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6, T7) -> Value?
    ) -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Value?) { Weak(self).capture(in: closure) }
}
