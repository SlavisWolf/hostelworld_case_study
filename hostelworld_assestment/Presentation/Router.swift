


import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case propertiesDetail(id: String)
        case imageEnlarged(url: URL)
    }
    
   @Published var navPath = NavigationPath()
        
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
}


