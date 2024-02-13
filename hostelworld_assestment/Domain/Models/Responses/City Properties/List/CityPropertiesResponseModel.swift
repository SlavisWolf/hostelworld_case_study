


import Foundation

struct CityPropertiesResponseModel: Decodable {
    let properties: [CityPropertiesOverviewModel]
}

struct CityPropertiesOverviewModel: Decodable {
    
    let propertyId: String
    let name: String
    let city: CityModel
    let latitude: String
    let longitude: String
    let type: String
    let images: [ImagePathModel]
    let overallRating: OverallRatingModel
        
    enum CodingKeys: String, CodingKey {
            case propertyId = "id"
            case name
            case city
            case latitude
            case longitude
            case type
            case images
            case overallRating
    }
}

struct OverallRatingModel: Decodable {
    let overall: Int?
    let numberOfRatings: Int
}



