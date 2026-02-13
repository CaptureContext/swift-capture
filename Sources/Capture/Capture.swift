import Foundation

/// Creates a capture item from an object with the specified strategy.
///
/// This function wraps an object in a capture interface, returning a capture item
/// that can be used to safely execute closures with automatic liveness checks.
///
/// - Parameters:
///   - object: The object to capture.
///   - strategy: The capture strategy (`.weak`, `.strong`, or `.unowned`). Defaults to `.weak`.
/// - Returns:
///     A capture item that can safely capture the object according to the specified strategy.
@inlinable
public func capture<Object: AnyObject>(
	_ object: Object,
	as strategy: ObjectCaptureStrategy = .weak
) -> some CaptureItemProtocol<Object> {
	Captured(object, as: strategy).capture
}
