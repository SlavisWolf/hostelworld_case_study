

import Foundation

protocol NetworkManagerProtocol {
    func performNetworkRequest<T: Decodable>(path: String, method: HttpMethod) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let baseUrl: String
    
    init(session: URLSession = URLSession.shared,
                 decoder: JSONDecoder = JSONDecoder(),
                 baseUrl: String = ConfigManager.retrieveValue(key: .BaseUrl) ?? "") {
        self.session = session
        self.decoder = decoder
        self.baseUrl = baseUrl
    }
    
    func performNetworkRequest<T: Decodable>(path: String, method: HttpMethod) async throws -> T {
        LogManager.safeLog("-------------------PERFORMING NETWORK REQUEST-------------------")
        guard let url = URL(string: baseUrl + path) else { throw NetworkError.invalidUrl }
        LogManager.safeLog(url.absoluteString)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.noResponse }
        
        try validateHttpCode(httpResponse.statusCode)
        LogManager.safeLog(String(data: data, encoding: .utf8) ?? "" )
        return try decoder.decode(T.self, from: data)
    }
    
    private func validateHttpCode(_ code: Int) throws {
        
        if (400...499).contains(code) {
            throw NetworkError.requestError(code)
        } else if (500...599).contains(code)  {
            throw NetworkError.serverError(code)
        } else if (200...299).notContains(code){
            throw NetworkError.unknow(code)
        }
    }
}
