


import Foundation

protocol ShowCityDetailedPropertiesProtocol {
    func execute(id: String) async throws -> CityDetailedPropertiesResponseModel
}

final class ShowCityDetailedProperties: ShowCityDetailedPropertiesProtocol {
    
    let service: CityPropertiesServiceProtocol
    
    init(service: CityPropertiesServiceProtocol = CityPropertiesService() ) {
        self.service = service
    }
    
    func execute(id: String) async throws -> CityDetailedPropertiesResponseModel {
        return try await service.getPropertyDetails(id: id)
    }
    
}
