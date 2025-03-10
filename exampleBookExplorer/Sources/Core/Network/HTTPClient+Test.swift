//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


extension HTTPClient {
    
    static var testValue: HTTPClient {
        guard
            let urlString = Bundle.main.infoDictionary?["GOOGLE_BOOKS_API_URL"] as? String,
            let url = URL(string: urlString)
        else {
            fatalError("Missing or invalid GOOGLE_BOOKS_API_URL in Info.plist")
        }
        
        return HTTPClient(baseURL: url)
    }
}
