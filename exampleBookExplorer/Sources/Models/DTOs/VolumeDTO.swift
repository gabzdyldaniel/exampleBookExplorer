//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


struct VolumeDTO: DTO {
    
    struct InfoDTO: Decodable {
        let title: String?
        let authors: [String]?
        let publishedDate: String?
        let description: String?
        let imageLinks: ImageLinksDTO?
        let infoLink: String?
    }
    
    struct ImageLinksDTO: Decodable {
        let smallThumbnail: String?
        let thumbnail: String?
    }
    
    let id: String
    let volumeInfo: InfoDTO
}


// MARK: - Mapping

extension VolumeDTO {
    
    func toEntity() -> Book {
        .init(
            id: id,
            title: volumeInfo.title,
            authors: volumeInfo.authors,
            publishedDate: volumeInfo.publishedDate?.toDate(),
            description: volumeInfo.description,
            smallThumbnailUrl: url(from: volumeInfo.imageLinks?.smallThumbnail),
            thumbnailUrl: url(from: volumeInfo.imageLinks?.thumbnail),
            infoLinkUrl: url(from: volumeInfo.infoLink)
        )
    }
    
    private func url(from string: String?) -> URL? {
        guard let string else {
            return nil
        }
        
        return URL(string: string)
    }
}
