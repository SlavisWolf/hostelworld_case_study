

import Foundation
@testable import hostelworld_assestment_pre

final class ShowPropertiesOverviewListSpy: ShowPropertiesOverviewListProtocol {
    
    var forceError = false
    var propertyListMock = [
        CityPropertiesOverviewModel(propertyId: "1",
                                    name: "Name1",
                                    city: CityModel(cityId: "1",
                                                    name: "cityName",
                                                    country: "country",
                                                    idCountry: "200"),
                                    latitude: "75.34",
                                    longitude: "24.12",
                                    type: "Type",
                                    images: [ImagePathModel(suffix: ".jpg",
                                                            prefix: "http://ucd.hwstatic.com/propertyimages/3/32849/3")],
                                    overallRating: OverallRatingModel(overall: 100,
                                                                      numberOfRatings: 25)),
        CityPropertiesOverviewModel(propertyId: "4",
                                    name: "Michael Jordan",
                                    city: CityModel(cityId: "1",
                                                    name: "Brussels",
                                                    country: "Belgium",
                                                    idCountry: "451"),
                                    latitude: "55.34",
                                    longitude: "64.12",
                                    type: "Pardon",
                                    images: [],
                                    overallRating: OverallRatingModel(overall: nil,
                                                                      numberOfRatings: 25)),
    ]
    
    func execute() async throws -> [CityPropertiesOverviewModel] {
        if forceError {
            throw NetworkError.unknow(5)
        }
        return propertyListMock
    }
}
