import Testing
@testable import Capture

@Suite
struct StrongTests {
	typealias Container = Strong<Object>

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
		var container = Container(object)

		#expect(container.object != nil)
		#expect(container.object === object)

		object = nil
		#expect(container.object != nil)

		container.object = nil
		#expect(container.object == nil)
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
