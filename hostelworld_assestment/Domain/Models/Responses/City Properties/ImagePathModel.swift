
import Foundation

struct ImagePathModel: Decodable {
    
    let suffix: String
    let prefix: String
    
    var original: String { prefix + suffix }
    var small: String { "\(prefix)_s\(suffix)" }
    var large: String { "\(prefix)_l\(suffix)" }
    
}
