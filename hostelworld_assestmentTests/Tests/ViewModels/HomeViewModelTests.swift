

@testable import hostelworld_assestment_pre
import XCTest

final class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    var spy: ShowPropertiesOverviewListSpy!

    override func setUpWithError() throws {
        spy = ShowPropertiesOverviewListSpy()
        sut = HomeViewModel(showPropertiesUseCase: spy )
    }

    override func tearDownWithError() throws {
        spy = nil
        sut = nil
    }

    func testLoadView() throws {

        XCTAssertTrue(sut.properties.isEmpty)
        XCTAssertTrue(sut.showLoading)
        XCTAssertTrue(sut.errorMsg.isEmpty)
        
        sut.loadView()
        waitTask()
        
        XCTAssertFalse(sut.showLoading)
        XCTAssertTrue(sut.errorMsg.isEmpty)
        let viewData = sut.properties
        XCTAssertEqual(viewData.count, 2)
        
        //Check parse was done well
        let first = try XCTUnwrap(viewData.first)
        XCTAssertEqual(first.cityName, "cityName")
        XCTAssertEqual(first.imageUrl, URL(string: "http://ucd.hwstatic.com/propertyimages/3/32849/3_s.jpg") )
        XCTAssertEqual(first.propertyName, "Name1")
        XCTAssertEqual(first.propertyType, "Type")
        XCTAssertEqual(first.ratingPercentage, "25%")
        XCTAssertEqual(first.propertyId, "1")
        
        let second = try XCTUnwrap(viewData.last)
        XCTAssertEqual(second.cityName, "Brussels")
        XCTAssertNil(second.imageUrl)
        XCTAssertEqual(second.propertyName, "Michael Jordan")
        XCTAssertEqual(second.propertyType, "Pardon")
        XCTAssertNil(second.ratingPercentage)
        XCTAssertEqual(second.propertyId, "4")
    }
    
    func testLoadViewFail() throws {
        
        spy.forceError = true
        sut.properties = [.init(propertyId: "", propertyName: "", propertyType: "", cityName: "", ratingPercentage: nil, imageUrl: nil)]
        
        XCTAssertFalse(sut.properties.isEmpty)
        XCTAssertTrue(sut.showLoading)
        XCTAssertTrue(sut.errorMsg.isEmpty)
        
        sut.loadView()
        waitTask()
        
        XCTAssertEqual(sut.errorMsg, "Error downloading the data.")
        XCTAssertFalse(sut.showLoading)
        XCTAssertTrue(sut.properties.isEmpty)
    }

}
