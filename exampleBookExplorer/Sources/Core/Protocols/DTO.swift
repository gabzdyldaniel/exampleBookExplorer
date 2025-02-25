//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


protocol DTO: Decodable {
    associatedtype Entity
    func toEntity() -> Entity
}
