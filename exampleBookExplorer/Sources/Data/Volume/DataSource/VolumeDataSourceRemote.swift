//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


class VolumeDataSourceRemote: VolumeDataSource {
    
    private let client: HTTPClient
        
    init() {
        guard
            let urlString = Bundle.main.infoDictionary?["GOOGLE_BOOKS_API_URL"] as? String,
            let url = URL(string: urlString)
        else {
            fatalError("Missing or invalid GOOGLE_BOOKS_API_URL in Info.plist")
        }
        
        self.client = .init(baseURL: url)
    }
    
    func volumes(author: String) async throws -> [Book] {
        let responseDto: VolumesResponseDTO = try await client.fetch("/volumes?q=inauthor:\(processAuthorParameter(author))&langRestrict=cs")
        return responseDto.items?.compactMap { $0.toEntity() } ?? []
    }
}


// MARK: - Private helpers

private extension VolumeDataSourceRemote {
    
    func processAuthorParameter(_ author: String) -> String {
        "\"\(author.replacingOccurrences(of: " ", with: "+"))\""
    }
}
