import Testing
@testable import Capture

@Suite
struct UnownedTests {
	typealias Container = Unowned<Object>

	class Object: CapturableObjectProtocol, @unchecked Sendable {
		init(onDeinit: (() -> Void)? = nil) {
			self._onDeinit = onDeinit
		}

		private var _onDeinit: (() -> Void)?
		func onDeinit(perform action: (() -> Void)?) {
			_onDeinit = action
		}

		deinit { _onDeinit?() }
	}

	@Test
	func checkDeinit() async throws {
		var object: Object? = Object()
		weak var weakObject: Object? = object
		let container = Container(object!)

		#expect(weakObject != nil)
		#expect(container.object === object)

		object = nil
		#expect(weakObject == nil)
	}

	@Test
	func checkCapture() async throws {
		let object = Object()
		let container = Container(object)

		let captureItem = container.capture
		#expect(type(of: captureItem) == CaptureItem<Object>.self)
	}

	@Test
	func checkUnckeckedSendable() async throws {
		let object = Object()
		let container = Container(object)

		let captureItem = container.uncheckedSendable
		#expect(type(of: captureItem) == CaptureItem<Object>.UncheckedSendable.self)
	}
}
