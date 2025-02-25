//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


extension String {
    
    func toDate() -> Date? {
        let formats = ["yyyy-MM-dd", "yyyy"]
        
        for format in formats {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.locale = Locale(identifier: "en_US_POSIX")
            
            if let date = formatter.date(from: self) {
                return date
            }
        }
        
        return nil
    }
}
