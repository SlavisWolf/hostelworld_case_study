


import Foundation

protocol CityPropertiesServiceProtocol {
    func getCityPropertyList() async throws -> CityPropertiesResponseModel
    func getPropertyDetails(id: String) async throws -> CityDetailedPropertiesResponseModel
}

final class CityPropertiesService: CityPropertiesServiceProtocol {
    
    private let cityProperties = "/cities/1530/properties/"
    private let propertiesDetailPath = "/properties/{ID}"
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager() ) {
        self.networkManager = networkManager
    }
    
    func getCityPropertyList() async throws -> CityPropertiesResponseModel {
        return try await networkManager.performNetworkRequest(path: cityProperties, method: .get)
    }
    
    func getPropertyDetails(id: String) async throws -> CityDetailedPropertiesResponseModel {
        let finalPath = propertiesDetailPath.replacingOccurrences(of: "{ID}", with: id)
        return try await networkManager.performNetworkRequest(path: finalPath, method: .get)
    }
    
}
