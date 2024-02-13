

import Foundation

extension ClosedRange {
    
    func notContains(_ value: Bound) -> Bool {
        return !self.contains(value)
    }
}
