//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


protocol VolumeDataSource {
    func volumes(author: String) async throws -> [Book]
}
