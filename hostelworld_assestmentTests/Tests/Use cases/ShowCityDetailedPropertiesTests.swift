


import Foundation
@testable import hostelworld_assestment_pre
import XCTest

class ShowCityDetailedPropertiesTests: XCTestCase {
    
    var sut: ShowCityDetailedProperties!
    let validId = "false_id"

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolSpy.self]
        let session = URLSession(configuration: configuration)
        let service = CityPropertiesService(networkManager: NetworkManager(session: session))
        
        sut = ShowCityDetailedProperties(service: service)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testExecute() async throws {
        
        let url = try XCTUnwrap(getUrlForJson(path: "cityDetailedProperties") )
        let data = try Data(contentsOf: url)
        URLProtocolSpy.requestHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let response = try await sut.execute(id: validId)
        waitTask()
        
        XCTAssertEqual(response.propertyId, "32849")
        XCTAssertEqual(response.address1, "Stigbergsliden 10")
        XCTAssertEqual(response.address2, "Stigbergsliden 40")
        XCTAssertEqual(response.description, "description test")
        XCTAssertEqual(response.directions, "go walking")
        XCTAssertEqual(response.name, "STF Vandrarhem Stigbergsliden")
        XCTAssertEqual(response.type, "HOSTEL")
        XCTAssertEqual(response.checkIn.startsAt, "14")
        XCTAssertEqual(response.checkIn.endsAt, "17")
        XCTAssertEqual(response.city.name, "Gothenburg")
        XCTAssertEqual(response.city.country, "Sweden")
        XCTAssertEqual(response.images.first?.prefix, "http://ucd.hwstatic.com/propertyimages/3/32849/7")
        XCTAssertEqual(response.images.first?.suffix, ".jpg")
        
        URLProtocolSpy.requestHandler = nil
    }

}
