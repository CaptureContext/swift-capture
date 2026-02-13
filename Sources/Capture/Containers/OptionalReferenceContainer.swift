import Foundation

/// Protocol for `CaptureItemProtocol` APIs generalization
public protocol __OptionalReferenceContainerProtocol<__CaptureRefObject> {
	associatedtype __CaptureRefObject: AnyObject

	@_spi(Internals)
	var __refObject: __CaptureRefObject? { get set }
}


/// Protocol for `Weak`/`Unowned`/`Strong` APIs generalization
public protocol _OptionalReferenceContainerProtocol<__CaptureRefObject>: __OptionalReferenceContainerProtocol {}
