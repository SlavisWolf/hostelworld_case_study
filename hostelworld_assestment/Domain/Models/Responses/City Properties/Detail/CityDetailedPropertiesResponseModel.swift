

import Foundation

struct CityDetailedPropertiesResponseModel: Decodable {
    
    let propertyId: String
    let name: String
    let rating: RatingModel?
    let bestFor: [String]
    let description: String
    let latitude: String
    let longitude: String
    let address1: String
    let address2: String
    let directions: String
    let city: CityModel
    let paymentMethods: [String]
    let policies: [String]
    let totalRatings: String
    let images: [ImagePathModel]
    let type: String
    let depositPercentage: Int
    let associations: [String]
    let checkIn: CheckInModel
    
    enum CodingKeys: String, CodingKey {
        case propertyId = "id"
        case name
        case rating
        case bestFor
        case description
        case latitude
        case longitude
        case address1
        case address2
        case directions
        case city
        case paymentMethods
        case policies
        case totalRatings
        case images
        case type
        case depositPercentage
        case associations
        case checkIn
    }
}

struct RatingModel: Decodable {
    let overall: Int
    let atmosphere: Int
    let cleanliness: Int
    let facilities: Int
    let staff: Int
    let security: Int
    let location: Int
    let valueForMoney: Int
}

struct CheckInModel: Decodable {
    let startsAt: String
    let endsAt: String
    
    enum CodingKeys: CodingKey {
        case startsAt
        case endsAt
    }
}

extension CheckInModel {
    // I know, this is ugly as fuck, I've done this just to be able to parse the data because the server sometimes sends an Int an other times it sends a String, this is a server error, this behaviour is not proper and leads to errors.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let starts = try? container.decode(String.self, forKey: .startsAt) {
            self.startsAt = starts
        } else {
            self.startsAt = String(try container.decode(Int.self, forKey: .startsAt))
        }
        
        if let ends = try? container.decode(String.self, forKey: .endsAt) {
            self.endsAt = ends
        } else {
            self.endsAt = String(try container.decode(Int.self, forKey: .endsAt))
        }
    }
}
