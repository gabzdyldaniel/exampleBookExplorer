//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


struct Book: Identifiable {
    
    let id: String
    let title: String?
    let authors: [String]?
    let publishedDate: Date?
    let description: String?
    let smallThumbnailUrl: URL?
    let thumbnailUrl: URL?
}
