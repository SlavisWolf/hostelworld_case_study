


import Foundation
import SwiftUI

@Observable
final class Router {
    
    public enum Destination: Codable, Hashable {
        case propertiesDetail(id: String)
        case imageEnlarged(url: URL)
    }
    
    var navPath = NavigationPath()
        
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
}


