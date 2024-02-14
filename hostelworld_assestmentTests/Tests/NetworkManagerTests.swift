
@testable import hostelworld_assestment_pre
import XCTest

final class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!

    override func setUpWithError() throws {

        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolSpy.self]
        let session = URLSession(configuration: configuration)
        sut = NetworkManager(session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // I just have tested here errors because success is already tested in the use cases tests classes.
    func testErrors() async throws {
        
        let url = try XCTUnwrap(URL(string: "https://github.com/SlavisWolf") )
        
        
        let closureMaker: (Int) -> (URLRequest) throws -> (HTTPURLResponse, Data?) = { number in
            return { response in
                let response = HTTPURLResponse(url: url, statusCode: number, httpVersion: nil, headerFields: nil)!
                return (response, nil)
            }
        }
        
        // 400 error
        URLProtocolSpy.requestHandler = closureMaker(401)
      
        do {
            let _ = try await sut.performNetworkRequest(path: "Test", method: .get) as CityModel
        } catch NetworkError.requestError(let code) {
            XCTAssertEqual(code, 401)
        } catch { XCTFail("Invalid error") }
        
        // 500 error
        URLProtocolSpy.requestHandler = closureMaker(524)
        do {
            let _ = try await sut.performNetworkRequest(path: "Test", method: .get) as CityModel
        } catch NetworkError.serverError(let code) {
            XCTAssertEqual(code, 524)
        } catch { XCTFail("Invalid error") }
        
        // unknow code error
        URLProtocolSpy.requestHandler = closureMaker(1)
        do {
            let _ = try await sut.performNetworkRequest(path: "Test", method: .get) as CityModel
        } catch NetworkError.unknow(let code) {
            XCTAssertEqual(code, 1)
        } catch { XCTFail("Invalid error") }
        
        
        URLProtocolSpy.requestHandler = nil
    }

}
