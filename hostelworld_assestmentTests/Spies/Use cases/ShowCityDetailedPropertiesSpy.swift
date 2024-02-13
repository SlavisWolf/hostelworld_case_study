


import Foundation
@testable import hostelworld_assestment_pre

final class ShowCityDetailedPropertiesSpy: ShowCityDetailedPropertiesProtocol {
    
    var mock = CityDetailedPropertiesResponseModel(propertyId: "id",
                                                   name: "name",
                                                   rating: nil,
                                                   bestFor: [],
                                                   description: "desc",
                                                   latitude: "",
                                                   longitude: "",
                                                   address1: "address1",
                                                   address2: "address2",
                                                   directions: "directions",
                                                   city: CityModel(cityId: "",
                                                                   name: "cityName",
                                                                   country: "country",
                                                                   idCountry: ""),
                                                   paymentMethods: [],
                                                   policies: [],
                                                   totalRatings: "",
                                                   images: [ImagePathModel(suffix: ".jpg",
                                                                           prefix: "www.google")],
                                                   type: "type",
                                                   depositPercentage: 0,
                                                   associations: [],
                                                   checkIn: CheckInModel(startsAt: "begin",
                                                                         endsAt: "end") )
    var forceError = false
    
    func execute(id: String) async throws -> CityDetailedPropertiesResponseModel {
        if forceError {
            throw NetworkError.requestError(1)
        }
        return mock
    }
    
    
}
