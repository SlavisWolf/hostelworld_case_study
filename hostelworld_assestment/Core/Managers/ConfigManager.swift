

import Foundation


enum ConfigManager {
    
    enum Key: String {
        case BaseUrl
    }
    
    static func retrieveValue<T>(key: Key) -> T? {
        return Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? T
    }
}
