

import Foundation
import XCTest

extension XCTestCase {

    func waitTask(seconds: TimeInterval = 0.25) {
        let expectation = XCTestExpectation(description: "Wair")
        DispatchQueue.global().asyncAfter(deadline: .now() + seconds) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func getUrlForJson(path: String) -> URL? {
        return Bundle(for: HomeViewModelTests.self).url(forResource: path, withExtension: ".json")
    }
    
}
