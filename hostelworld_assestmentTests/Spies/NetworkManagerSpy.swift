


import Foundation
@testable import hostelworld_assestment_pre

enum JsonNetworkFileMock: String {
    
    case cityProperties
    case cityDetailedProperties
    
    init?(endPoint: String) {
        switch endPoint {
        case "/cities/1530/properties/":
            self = .cityProperties
        case "b":
            self = .cityDetailedProperties
        default:
            return nil
        }
    }
}

final class NetworkManagerSpy: NetworkManagerProtocol {
    
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder() ) {
        self.decoder = decoder
    }
    
    func performNetworkRequest<T: Decodable>(path: String, method: HttpMethod) async throws -> T {
        
        guard let fileMock = JsonNetworkFileMock(endPoint: path) else {
            throw NetworkError.invalidUrl
        }
        
        guard let jsonFileUrl = Bundle(for: NetworkManagerSpy.self).url(forResource: fileMock.rawValue,
                                                                        withExtension: "json") else {
            throw NetworkError.requestError(1)
        }
    
        let data = try Data(contentsOf: jsonFileUrl)
        return try decoder.decode(T.self, from: data)
    }
    
}
