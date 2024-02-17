

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var showLoading = true
    var properties = [HomeCellData]()
    var errorMsg = ""
    
    private let showPropertiesUseCase: ShowPropertiesOverviewListProtocol
    
    init(showPropertiesUseCase: ShowPropertiesOverviewListProtocol = ShowPropertiesOverviewList() ) {
        self.showPropertiesUseCase = showPropertiesUseCase
    }
    
    func loadView() {
        
        showLoading = true
        Task { @MainActor in
            do {
                let cityProperties = try await showPropertiesUseCase.execute()
                parseData(cityProperties: cityProperties)
                errorMsg = ""
            } catch {
                errorMsg = "Error downloading the data."
                properties.removeAll()
                LogManager.safeLog(error)
            }
            showLoading = false
        }
    }
    
    private func parseData(cityProperties: [CityPropertiesOverviewModel]) {
        
        properties = cityProperties.map {
            
            var percentage: String?
            var imageUrl: URL?
            if let overall = $0.overallRating.overall, overall >= $0.overallRating.numberOfRatings {
                percentage = "\( ($0.overallRating.numberOfRatings * 100 ) / overall  )%"
            }
            if let imagePath = $0.images.first?.small, let url = URL(string: imagePath) { imageUrl = url }
            
            return HomeCellData(propertyId: $0.propertyId,
                                propertyName: $0.name,
                                propertyType: $0.type,
                                cityName: $0.city.name,
                                ratingPercentage: percentage,
                                imageUrl: imageUrl)
        }
    }
    
}
