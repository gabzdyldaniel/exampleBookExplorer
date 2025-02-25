//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


protocol GetBooksUseCase {
    func callAsFunction(author: String) async throws -> [Book]
}


enum BookUseCase {
    
    struct GetBooks: GetBooksUseCase {
        
        let dataSource: VolumeDataSource
        
        func callAsFunction(author: String) async throws -> [Book] {
            return try await dataSource.volumes(author: author)
        }
    }
}
