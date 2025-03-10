//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


extension BookClient {
    
    static var previewValue: Self {
        .init(
            getBooks: { _ in
                try await Task.sleep(for: .milliseconds(500))
                return VolumeDTO.testData.map { $0.toEntity() }
            }
        )
    }
    
    static var testValue: Self {
        .init(
            getBooks: { _ in
                return []
            }
        )
    }
    
    static func failing(error: Error = NSError(domain: "BookClient", code: 1)) -> Self {
        .init(
            getBooks: { _ in
                throw error
            }
        )
    }
}
