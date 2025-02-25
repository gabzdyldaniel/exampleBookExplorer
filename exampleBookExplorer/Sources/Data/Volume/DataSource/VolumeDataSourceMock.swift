//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


class VolumeDataSourceMock: VolumeDataSource {
    
    func volumes(author: String) async throws -> [Book] {
        try await Task.sleep(for: .seconds(0.3))
        return VolumeDTO.testData.map { $0.toEntity() }
    }
}
