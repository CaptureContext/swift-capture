import XCTest
@testable import Weak

final class WeakTests: XCTestCase {
    class Object: Weakifiable {
        init(onDeinit: (() -> Void)? = nil) {
            self._onDeinit = onDeinit
        }
        
        private var _onDeinit: (() -> Void)?
        func onDeinit(perform action: (() -> Void)?) {
            _onDeinit = action
        }
        
        deinit { _onDeinit?() }
    }
    
    func testDeinit() {
        var isObjectDeinitialized = false
        
        var object: Object? = Object(onDeinit: {
            isObjectDeinitialized = true
        })
        
        let weakObject = Weak(object)
        
        XCTAssert(!isObjectDeinitialized)
        object = nil
        XCTAssert(isObjectDeinitialized)
    }
    
    func testDeinitWithCapture() {
        var isObjectDeinitialized = false
        var numberOfCalls = 0
        
        var object: Object? = Object(onDeinit: {
            isObjectDeinitialized = true
        })
        
        let closure = object!.capture { object in
            numberOfCalls += 1
        }
        
        XCTAssertEqual(numberOfCalls, 0)
        closure()
        XCTAssertEqual(numberOfCalls, 1)
        
        XCTAssert(!isObjectDeinitialized)
        object = nil
        XCTAssert(isObjectDeinitialized)
        
        XCTAssertEqual(numberOfCalls, 1)
        closure()
        XCTAssertEqual(numberOfCalls, 1)
    }
    
    func testDeinitWithCaptureDataSource() {
        var isObjectDeinitialized = false
        var numberOfCalls = 0
        
        var object: Object? = Object(onDeinit: {
            isObjectDeinitialized = true
        })
        
        let closure = object!.capture(or: 0) { object in
            numberOfCalls += 1
            return 1
        }
        
        XCTAssertEqual(numberOfCalls, 0)
        XCTAssertEqual(closure(), 1)
        XCTAssertEqual(numberOfCalls, 1)
        
        XCTAssert(!isObjectDeinitialized)
        object = nil
        XCTAssert(isObjectDeinitialized)
        
        XCTAssertEqual(numberOfCalls, 1)
        XCTAssertEqual(closure(), 0)
        XCTAssertEqual(numberOfCalls, 1)
    }
    
    func testDeinitWithCaptureOptionalDataSource() {
        var isObjectDeinitialized = false
        var numberOfCalls = 0
        
        var object: Object? = Object(onDeinit: {
            isObjectDeinitialized = true
        })
        
        let closure: () -> Int? = object!.capture { object in
            numberOfCalls += 1
            return 1
        }
        
        XCTAssertEqual(numberOfCalls, 0)
        XCTAssertEqual(closure(), 1)
        XCTAssertEqual(numberOfCalls, 1)
        
        XCTAssert(!isObjectDeinitialized)
        object = nil
        XCTAssert(isObjectDeinitialized)
        
        XCTAssertEqual(numberOfCalls, 1)
        XCTAssertEqual(closure(), nil)
        XCTAssertEqual(numberOfCalls, 1)
    }
    
    func testDeinitWithCaptureOptionalDataSourceDefaultValue() {
        var isObjectDeinitialized = false
        var numberOfCalls = 0
        
        var object: Object? = Object(onDeinit: {
            isObjectDeinitialized = true
        })
        
        let closure: () -> Int? = object!.capture(or: 1) { object in
            numberOfCalls += 1
            return nil
        }
        
        XCTAssertEqual(numberOfCalls, 0)
        XCTAssertEqual(closure(), nil)
        XCTAssertEqual(numberOfCalls, 1)
        
        XCTAssert(!isObjectDeinitialized)
        object = nil
        XCTAssert(isObjectDeinitialized)
        
        XCTAssertEqual(numberOfCalls, 1)
        XCTAssertEqual(closure(), 1)
        XCTAssertEqual(numberOfCalls, 1)
    }
}
