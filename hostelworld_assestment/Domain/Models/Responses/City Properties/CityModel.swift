

import Foundation

struct CityModel: Decodable {
    let cityId: String
    let name: String
    let country: String
    let idCountry: String
    
    enum CodingKeys: String, CodingKey {
        case cityId = "id"
        case name
        case country
        case idCountry
    }
}

