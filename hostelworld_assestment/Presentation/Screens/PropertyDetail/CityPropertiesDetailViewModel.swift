

import Foundation


final class CityPropertiesDetailViewModel: ObservableObject {

    @Published var viewData: CityPropertiesDetailViewData?
    @Published var showCheckInAlert = false
    @Published var errorMsg = ""
    
    private let selectedPropertyId: String
    private let showCityDetailedPropertiesUseCase: ShowCityDetailedPropertiesProtocol
    
    init(selectedPropertyId: String,
         showCityDetailedPropertiesUseCase: ShowCityDetailedPropertiesProtocol = ShowCityDetailedProperties() ) {
        self.selectedPropertyId = selectedPropertyId
        self.showCityDetailedPropertiesUseCase = showCityDetailedPropertiesUseCase
    }
    
    func loadView() {
        
        errorMsg = ""
        viewData = nil
        
        Task { @MainActor in
            do {
                let response = try await showCityDetailedPropertiesUseCase.execute(id: selectedPropertyId)
                parseData(response)
            } catch {
                LogManager.safeLog()
                errorMsg = "It's been impossible downloading the info."
            }
        }
    }
    
    func checkInButtonClicked() {
        showCheckInAlert = true
    }
    
    private func parseData(_ data: CityDetailedPropertiesResponseModel) {
        let imagesUrl = data.images.compactMap({ CityPropertiesDetailViewData.ImageUrl(originalPath: $0.original, largePath: $0.large) } )
        
        viewData = CityPropertiesDetailViewData(name: data.name,
                                                type: data.type,
                                                address1: data.address1,
                                                address2: data.address2,
                                                city: data.city.name,
                                                country: data.city.country,
                                                description: data.description,
                                                directions: data.directions,
                                                checkInStarts: data.checkIn.startsAt,
                                                checkInEnds: data.checkIn.endsAt,
                                                images: imagesUrl)
    }
}

struct CityPropertiesDetailViewData {
    let name: String
    let type: String
    let address1: String
    let address2: String
    let city: String
    let country: String
    let description: String
    let directions: String
    let checkInStarts: String
    let checkInEnds: String
    let images: [ImageUrl]
    
    struct ImageUrl {
        let original: URL
        let large: URL
        
        init?(originalPath: String, largePath: String) {
            guard let original = URL(string: originalPath), let large = URL(string: largePath) else {
                return nil
            }
            self.original = original
            self.large = large
        }
    }
}

