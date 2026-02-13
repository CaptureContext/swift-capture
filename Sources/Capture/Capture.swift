import Foundation

@inlinable
public func capture<Object: AnyObject>(
	_ object: Object,
	as strategy: ObjectCaptureStrategy = .weak
) -> some CaptureItemProtocol<Object> {
	Captured(object, as: strategy).capture
}
