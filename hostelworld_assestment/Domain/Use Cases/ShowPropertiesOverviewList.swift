


import Foundation

protocol ShowPropertiesOverviewListProtocol {
    func execute() async throws -> [CityPropertiesOverviewModel]
}

final class ShowPropertiesOverviewList: ShowPropertiesOverviewListProtocol {
    
    let service: CityPropertiesServiceProtocol
    
    init(service: CityPropertiesServiceProtocol = CityPropertiesService() ) {
        self.service = service
    }
    
    func execute() async throws -> [CityPropertiesOverviewModel] {
        return try await service.getCityPropertyList().properties
    }
    
}
