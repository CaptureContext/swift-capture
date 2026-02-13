import Testing
@testable import Capture

@Suite
struct CaptureItemTests {
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
		var isObjectDeinitialized = false

		var object: Object? = Object(onDeinit: {
			isObjectDeinitialized = true
		})

		var weakObject = Weak(object)

		#expect(!isObjectDeinitialized)
		object = nil
		#expect(isObjectDeinitialized)

		do { // mute warnings
			weakObject = .init()
			_ = weakObject
		}
	}

	@Test
	func checkDeinit() {
		var isObjectDeinitialized = false
		var numberOfCalls = 0

		var object: Object? = Object(onDeinit: {
			isObjectDeinitialized = true
		})

		let closure = object!.capture { object in
			numberOfCalls += 1
		}

		do { // call
			#expect(numberOfCalls == 0)
			closure()
			#expect(numberOfCalls == 1)
		}

		do { // deinit
			#expect(!isObjectDeinitialized)
			object = nil
			#expect(isObjectDeinitialized)
		}

		do { // no call
			#expect(numberOfCalls == 1)
			closure()
			#expect(numberOfCalls == 1)
		}
	}

	func checkDeinitWithCaptureDataSource() {
		var isObjectDeinitialized = false
		var numberOfCalls = 0

		var object: Object? = Object(onDeinit: {
			isObjectDeinitialized = true
		})

		let closure = object!.capture(orReturn: 0) { object in
			numberOfCalls += 1
			return 1
		}

		do { // call
			#expect(numberOfCalls == 0)
			#expect(closure() == 1)
			#expect(numberOfCalls == 1)
		}

		do { // deinit
			#expect(!isObjectDeinitialized)
			object = nil
			#expect(isObjectDeinitialized)
		}

		do { // no call, default value
			#expect(numberOfCalls == 1)
			#expect(closure() == 0)
			#expect(numberOfCalls == 1)
		}
	}

	@Test
	func checkDeinitWithOptionalCaptureDataSource() {
		var isObjectDeinitialized = false
		var numberOfCalls = 0

		var object: Object? = Object(onDeinit: {
			isObjectDeinitialized = true
		})

		let closure: () -> Int? = object!.capture { _ in
			numberOfCalls += 1
			return 1
		}

		do { // call
			#expect(numberOfCalls == 0)
			#expect(closure() == 1)
			#expect(numberOfCalls == 1)
		}

		do { // deinit
			#expect(!isObjectDeinitialized)
			object = nil
			#expect(isObjectDeinitialized)
		}

		do { // no call, default value
			#expect(numberOfCalls == 1)
			#expect(closure() == nil)
			#expect(numberOfCalls == 1)
		}
	}

	@Test
	func checkDeinitWithArgumentedCaptureDataSource() {
		var isObjectDeinitialized = false
		var numberOfCalls = 0

		var object: Object? = Object(onDeinit: {
			isObjectDeinitialized = true
		})

		let closure: (Int) -> Int? = object!.capture { _, value in
			numberOfCalls += 1
			return value
		}

		do { // call
			#expect(numberOfCalls == 0)
			#expect(closure(3) == 3)
			#expect(numberOfCalls == 1)
		}

		do { // deinit
			#expect(!isObjectDeinitialized)
			object = nil
			#expect(isObjectDeinitialized)
		}

		do { // no call, default value
			#expect(numberOfCalls == 1)
			#expect(closure(3) == nil)
			#expect(numberOfCalls == 1)
		}
	}

	@Test
	func checkPassingMethods() {
		class LocalObject: Object, @unchecked Sendable {
			private(set) var didSomething: Bool = false

			func doSomething() {
				didSomething = true
			}

			func undoSomething() {
				didSomething = false
			}
		}

		var isObjectDeinitialized = false

		var object: LocalObject? = LocalObject(onDeinit: {
			isObjectDeinitialized = true
		})

		let closure1: () -> Void = object!.capture(in: uncurryMethod(LocalObject.doSomething))
		let closure2: () -> Void = object!.capture(in: uncurryMethod(LocalObject.undoSomething))
		let closure3: () -> Bool = object!.capture(orReturn: false, in: \.didSomething)

		do {
			#expect(object?.didSomething == false)
			#expect(closure3() == false)
			closure1()
			#expect(object?.didSomething == true)
			#expect(closure3() == true)
		}

		do {
			#expect(object?.didSomething == true)
			#expect(closure3() == true)
			closure2()
			#expect(object?.didSomething == false)
			#expect(closure3() == false)
		}

		do {
			#expect(!isObjectDeinitialized)
			object = nil
			#expect(isObjectDeinitialized)
		}

		do {
			#expect(object?.didSomething == nil)
			#expect(closure3() == false)
			closure1()
			#expect(object?.didSomething == nil)
			#expect(closure3() == false)
		}

		do {
			#expect(object?.didSomething == nil)
			#expect(closure3() == false)
			closure2()
			#expect(object?.didSomething == nil)
			#expect(closure3() == false)
		}
	}

	@Suite
	struct APIChecks {
		@Test
		func methodAPIsCompilation() async throws {
			let object = Object()

			@Sendable func throwingOperation() throws {}
			@Sendable func asyncOperation() async {}
			@Sendable func asyncThrowingOperation() async throws {}

			do { // basic
				_ = object.capture(as: .weak) { _self in
					#expect(_self === object)
				}()

				_ = object.capture(as: .weak) { _self in
					#expect(_self === object)
					return 1
				}()

				_ = object.capture(as: .weak, orReturn: 0) { _self in
					#expect(_self === object)
					return 1
				}()

				do { // arguments
					let _: (Bool) -> Void = object.capture(as: .weak) { _self, _ in }
					let _: (Bool, Bool) -> Int? = object.capture(as: .weak) { _self, _, _ in nil }
					let _: (Int, Bool, String) -> Int = object.capture(as: .weak, orReturn: 0) { _self, _, _, _ in 1 }
				}
			}

			do { // throwing
				_ = try object.capture(as: .weak) { _self in
					#expect(_self === object)
					try throwingOperation()
				}()

				_ = try object.capture(as: .weak) { _self in
					#expect(_self === object)
					try throwingOperation()
					return 1
				}()

				_ = try object.capture(as: .weak, orReturn: 0) { _self in
					#expect(_self === object)
					try throwingOperation()
					return 1
				}()
			}

			do { // async
				_ = await object.capture(as: .weak) { _self in
					#expect(_self === object)
					await asyncOperation()
				}()

				_ = await object.capture(as: .weak) { _self in
					#expect(_self === object)
					await asyncOperation()
					return 1
				}()

				_ = await object.capture(as: .weak, orReturn: 0) { _self in
					#expect(_self === object)
					await asyncOperation()
					return 1
				}()
			}

			do { // async throwing
				_ = try await object.capture(as: .weak) { _self in
					#expect(_self === object)
					try await asyncThrowingOperation()
				}()

				_ = try await object.capture(as: .weak) { _self in
					#expect(_self === object)
					try await asyncThrowingOperation()
					return 1
				}()

				_ = try await object.capture(as: .weak, orReturn: 0) { _self in
					#expect(_self === object)
					try await asyncThrowingOperation()
					return 1
				}()
			}
		}

		@Test
		func functorAPIsCompilation() async throws {
			let object = Object()

			func throwingOperation() throws {}
			func asyncOperation() async {}
			func asyncThrowingOperation() async throws {}

			do { // basic
				_ = object.capture { _self in
					#expect(_self === object)
				}()


				_ = object.capture { _self in
					#expect(_self === object)
					return Optional(1)
				}()

				_ = object.capture(orReturn: 0) { _self in
					#expect(_self === object)
					return 1
				}()

				_ = object.capture.orReturn(0) { _self in
					#expect(_self === object)
					return 1
				}()

				do { // arguments
					let _: (Bool) -> Void = object.capture { _self, _ in }
					let _: (Bool, Bool) -> Int? = object.capture(in: { _self, _, _ in nil })
					let _: (Int, Bool, String) -> Int = object.capture(orReturn: 0) { _self, _, _, _ in 1 }
				}
			}

			do { // throwing
				_ = try object.capture { _self in
					#expect(_self === object)
					try throwingOperation()
				}()


				_ = try object.capture { _self in
					#expect(_self === object)
					try throwingOperation()
					return Optional(1)
				}()

				_ = try object.capture(orReturn: 0) { _self in
					#expect(_self === object)
					try throwingOperation()
					return 1
				}()

				_ = try object.capture.orReturn(0) { _self in
					#expect(_self === object)
					try throwingOperation()
					return 1
				}()
			}

			do { // async
				_ = await object.capture { _self in
					#expect(_self === object)
					await asyncOperation()
				}()


				_ = await object.capture { _self in
					#expect(_self === object)
					await asyncOperation()
					return Optional(1)
				}()

				_ = await object.capture(orReturn: 0) { _self in
					#expect(_self === object)
					await asyncOperation()
					return 1
				}()

				_ = await object.capture.orReturn(0) { _self in
					#expect(_self === object)
					await asyncOperation()
					return 1
				}()
			}

			do { // async throwing
				_ = try await object.capture { _self in
					#expect(_self === object)
					try await asyncThrowingOperation()
				}()


				_ = try await object.capture { _self in
					#expect(_self === object)
					try await asyncThrowingOperation()
					return Optional(1)
				}()

				_ = try await object.capture(orReturn: 0) { _self in
					#expect(_self === object)
					try await asyncThrowingOperation()
					return 1
				}()

				_ = try await object.capture.orReturn(0) { _self in
					#expect(_self === object)
					try await asyncThrowingOperation()
					return 1
				}()
			}

			do { // strategy override
				_ = object.capture.as(.weak)(in: { _self in
					#expect(_self === object)
				})()

				_ = object.capture.as(.weak)(in: { _self in
					#expect(_self === object)
					return Optional(1)
				})()

				_ = object.capture.as(.weak)(orReturn: 0) { _self in
					#expect(_self === object)
					return 1
				}()

				_ = object.capture.as(.weak).orReturn(0) { _self in
					#expect(_self === object)
					return 1
				}()
			}

			do { // MainActor
				let f1: @MainActor () -> Void = object.capture.uncheckedSendable.onMainActor { _self in
					#expect(_self === object)
				}

				let f2: @MainActor () -> Optional<Int> = object.capture.uncheckedSendable.onMainActor { _self in
					#expect(_self === object)
					return Optional(1)
				}

				let f3: @MainActor () -> Int = object.capture.uncheckedSendable.onMainActor(orReturn: 1) { _self in
					#expect(_self === object)
					return 1
				}

				let f1_async: @MainActor () async -> Void = object.capture.uncheckedSendable.onMainActor { _self in
					#expect(_self === object)
				}

				let f2_async: @MainActor () async -> Optional<Int> = object.capture.uncheckedSendable.onMainActor { _self in
					#expect(_self === object)
					return Optional(1)
				}

				let f3_async: @MainActor () async -> Int = object.capture.uncheckedSendable.onMainActor(orReturn: 1) { _self in
					#expect(_self === object)
					return 1
				}

				await Task { @MainActor in
					_ = f1()
					_ = f2()
					_ = f3()

					_ = await f1_async()
					_ = await f2_async()
					_ = await f3_async()
				}.value
			}
		}
	}
}
