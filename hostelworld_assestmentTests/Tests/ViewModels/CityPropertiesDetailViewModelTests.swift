

import Foundation
@testable import hostelworld_assestment_pre
import XCTest

final class CityPropertiesDetailViewModelTests: XCTestCase {
    
    var sut: CityPropertiesDetailViewModel!
    var spy: ShowCityDetailedPropertiesSpy!
    
    override func setUpWithError() throws {
        spy = ShowCityDetailedPropertiesSpy()
        sut = CityPropertiesDetailViewModel(selectedPropertyId: "test",
                                            showCityDetailedPropertiesUseCase: spy)
    }

    override func tearDownWithError() throws {
        spy = nil
        sut = nil
    }
    
    func testLoadView() throws {
        
        XCTAssertNil(sut.viewData)
        XCTAssertTrue(sut.errorMsg.isEmpty)
        XCTAssertFalse(sut.showCheckInAlert)
        
        sut.loadView()
        waitTask()
        
        XCTAssertTrue(sut.errorMsg.isEmpty)
        XCTAssertFalse(sut.showCheckInAlert)
        
        let viewData = try XCTUnwrap(sut.viewData)
        
        XCTAssertEqual(viewData.checkInStarts, "begin")
        XCTAssertEqual(viewData.checkInEnds, "end")
        XCTAssertEqual(viewData.address1, "address1")
        XCTAssertEqual(viewData.address2, "address2")
        XCTAssertEqual(viewData.city, "cityName")
        XCTAssertEqual(viewData.country , "country")
        XCTAssertEqual(viewData.description , "desc")
        XCTAssertEqual(viewData.directions , "directions")
        XCTAssertEqual(viewData.name , "name")
        XCTAssertEqual(viewData.type , "type")
        XCTAssertEqual(viewData.images.first?.original , URL(string: "www.google.jpg") )
        XCTAssertEqual(viewData.images.first?.large , URL(string: "www.google_l.jpg") )
    }
    
    func testLoadViewError() {
        
        spy.forceError = true
        sut.viewData = .init(name: "", type: "", address1: "", address2: "", city: "", country: "", description: "", directions: "", checkInStarts: "", checkInEnds: "", images: [])
        
        XCTAssertNotNil(sut.viewData)
        XCTAssertTrue(sut.errorMsg.isEmpty)
        XCTAssertFalse(sut.showCheckInAlert)
        
        sut.loadView()
        waitTask()
        
        XCTAssertNil(sut.viewData)
        XCTAssertEqual(sut.errorMsg, "It's been impossible downloading the info.")
        XCTAssertFalse(sut.showCheckInAlert)
    }
    
    func testCheckInButtonClicked()  {
        XCTAssertFalse(sut.showCheckInAlert)
        sut.checkInButtonClicked()
        XCTAssertTrue(sut.showCheckInAlert)
    }
    
}
