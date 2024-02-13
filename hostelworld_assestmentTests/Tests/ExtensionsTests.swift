


@testable import hostelworld_assestment_pre

import XCTest

final class ExtensionsTests: XCTestCase {

    func testClosedRangeNotContains() throws {
        let range = 1...100
        
        let sut = 5
        XCTAssertFalse(range.notContains(sut))
        XCTAssertNotEqual(range.notContains(sut), range.contains(sut) )
        
        
        let sut2 = 800
        XCTAssertTrue(range.notContains(sut2))
        XCTAssertNotEqual(range.notContains(sut2), range.contains(sut2) )
        
    }
    
    func testStringNotEmpty() {
        
        let sut = ""
        XCTAssertFalse(sut.isNotEmpty )
        XCTAssertNotEqual(sut.isNotEmpty, sut.isEmpty )
        
        let sut2 = "I'm not empty ;("
        XCTAssertTrue(sut2.isNotEmpty )
        XCTAssertNotEqual(sut2.isNotEmpty, sut2.isEmpty )
        
    }
}
