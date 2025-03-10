//
// Created with ❤️ by Daniel Gabzdyl.

import ComposableArchitecture
import Foundation


struct BookClient {
    var getBooks: @Sendable (String) async throws -> [Book]
}


extension DependencyValues {
    
    var bookClient: BookClient {
        get { self[BookClient.self] }
        set { self[BookClient.self] = newValue }
    }
}
