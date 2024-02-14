

@testable import hostelworld_assestment_pre
import XCTest

final class ShowPropertiesOverviewListTests: XCTestCase {
    
    var sut: ShowPropertiesOverviewList!

    override func setUpWithError() throws {
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolSpy.self]
        let session = URLSession(configuration: configuration)
        let service = CityPropertiesService(networkManager: NetworkManager(session: session))
        
        sut = ShowPropertiesOverviewList(service: service)
    }

    override func tearDownWithError() throws {
        sut = nil
        
    }

    func testExecute() async throws {
        
        let url = try XCTUnwrap(getUrlForJson(path: "cityProperties") )
        let data = try Data(contentsOf: url)
        URLProtocolSpy.requestHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let response = try await sut.execute()
        let first = try XCTUnwrap(response.first)
        
        XCTAssertEqual(first.name, "STF Vandrarhem Stigbergsliden")
        XCTAssertEqual(first.propertyId, "32849")
        XCTAssertEqual(first.city.name, "Gothenburg")
        XCTAssertEqual(first.city.country, "Sweden")
        XCTAssertEqual(first.type, "HOSTEL")
        XCTAssertEqual(first.images.first?.prefix, "http://ucd.hwstatic.com/propertyimages/3/32849/7")
        XCTAssertEqual(first.images.first?.suffix, ".jpg")
        XCTAssertEqual(first.overallRating.overall, 82)
        XCTAssertEqual(first.overallRating.numberOfRatings, 400)
        
        //it's static, don't forget to deinit
        URLProtocolSpy.requestHandler = nil
    }

}
