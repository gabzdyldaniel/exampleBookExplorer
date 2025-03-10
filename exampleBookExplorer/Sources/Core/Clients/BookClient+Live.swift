//
// Created with ❤️ by Daniel Gabzdyl.

import ComposableArchitecture
import Foundation


extension BookClient: DependencyKey {
    
    static var liveValue: Self {
        @Dependency(\.httpClient) var client
        
        return .init(
            getBooks: { author in
                let formattedAuthor = "\"\(author.replacingOccurrences(of: " ", with: "+"))\""
                let endpoint = "/volumes?q=inauthor:\(formattedAuthor)&langRestrict=cs"
                
                let responseDto: VolumesResponseDTO = try await client.fetch(endpoint)
                return responseDto.items?.compactMap { $0.toEntity() } ?? []
            }
        )
    }
}
