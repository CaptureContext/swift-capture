import Testing
@_spi(Internals) import Capture


@Suite
struct CapturedTests {
	class Object {}

	@Test
	@available(
		iOS 16.0, macOS 13.0,
		macCatalyst 13.0, tvOS 16.0,
		watchOS 9.0, visionOS 1.0, *
	)
	func weakCapture() async throws {
		do { // basic
			let object: Object = .init()
			let container: Captured = .init(object)
			let impl = container.underlyingContainer
			#expect(type(of: impl) == Weak<Object>.self)
		}

		do { // explicit
			let object: Object = .init()
			let container: Captured = .init(object, as: .weak)
			let impl = container.underlyingContainer
			#expect(type(of: impl) == Weak<Object>.self)
		}

		do { // flag
			let object: Object = .init()
			let container: Captured = .init(wrappedValue: object, strong: false)
			let impl = container.underlyingContainer
			#expect(type(of: impl) == Weak<Object>.self)
		}

		do { // unsafe for weak (technically safe)
			do { // when nil
				let object: Object? = nil
				let container: Captured = .init(unsafe: object, as: .weak)
				let impl = container.underlyingContainer
				#expect(type(of: impl) == Weak<Object>.self)
			}

			do { // when not nil
				let object: Object? = Object()
				let container: Captured = .init(unsafe: object, as: .weak)
				let impl = container.underlyingContainer
				#expect(type(of: impl) == Weak<Object>.self)
			}
		}

		do { // safe for weak
			do { // when nil
				let object: Object? = nil
				let container: Captured = .init(safe: object, as: .weak)
				let impl = container.underlyingContainer
				#expect(type(of: impl) == Weak<Object>.self)
			}

			do { // when not nil
				let object: Object? = Object()
				let container: Captured = .init(safe: object, as: .weak)
				let impl = container.underlyingContainer
				#expect(type(of: impl) == Weak<Object>.self)
			}
		}

		do { // safe fallback for unowned when nil
			let object: Object? = nil
			let container: Captured = .init(safe: object, as: .unowned)
			let impl = container.underlyingContainer
			#expect(type(of: impl) == Weak<Object>.self)
		}

		do { // propertyWrapper
			do { // default
				@Captured
				var object: Object?
				#expect(type(of: _object.underlyingContainer) == Weak<Object>.self)
			}

			do { // flag
				@Captured(strong: false)
				var object: Object?
				#expect(type(of: _object.underlyingContainer) == Weak<Object>.self)
			}
		}
	}

	@Test
	@available(
		iOS 16.0, macOS 13.0,
		macCatalyst 13.0, tvOS 16.0,
		watchOS 9.0, visionOS 1.0, *
	)
	func unownedCapture() async throws {
		do { // explicit
			let object: Object = .init()
			let container: Captured = .init(object, as: .unowned)
			let impl = container.underlyingContainer
			#expect(type(of: impl) == Unowned<Object>.self)
		}

		do { // safe
			do { // when not nil
				let object: Object? = Object()
				let container: Captured = .init(safe: object, as: .unowned)
				let impl = container.underlyingContainer
				#expect(type(of: impl) == Unowned<Object>.self)
			}

			do { // when nil
				let object: Object? = nil
				let container: Captured = .init(safe: object, as: .unowned)
				let impl = container.underlyingContainer
				#expect(type(of: impl) == Weak<Object>.self) // fallback
			}
		}

		do { // unsafe
			do { // when not nil
				let object: Object? = Object()
				let container: Captured = .init(unsafe: object, as: .unowned)
				let impl = container.underlyingContainer
				#expect(type(of: impl) == Unowned<Object>.self)
			}

			do { // when nil
				// let object: Object? = Object()
				// let container: Captured = .init(unsafe: object, as: .unowned) // ❌ Crash
				// let impl = container.underlyingContainer
				// #expect(type(of: impl) == Unowned<Object>.self)
			}
		}
	}

	@Test
	@available(
		iOS 16.0, macOS 13.0,
		macCatalyst 13.0, tvOS 16.0,
		watchOS 9.0, visionOS 1.0, *
	)
	func strongCapture() async throws {
		do { // explicit
			let object: Object = .init()
			let container: Captured = .init(object, as: .strong)
			let impl = container.underlyingContainer
			#expect(type(of: impl) == Strong<Object>.self)
		}

		do { // flag
			let object: Object? = Object()
			let container: Captured = .init(wrappedValue: object, strong: true)
			let impl = container.underlyingContainer
			#expect(type(of: impl) == Strong<Object>.self)
		}

		do { // unsafe
			let object: Object? = Object()
			let container: Captured = .init(unsafe: object, as: .unowned)
			let impl = container.underlyingContainer
			#expect(type(of: impl) == Unowned<Object>.self)
		}

		do { // propertyWrapper
			@Captured(strong: true)
			var object: Object?
			#expect(type(of: _object.underlyingContainer) == Strong<Object>.self)
		}
	}
}
