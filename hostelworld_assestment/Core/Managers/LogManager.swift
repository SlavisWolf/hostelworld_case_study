

import Foundation


enum LogManager {
    static func safeLog(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        print(items, separator: separator, terminator: terminator)
        #endif
    }
}
