//
// Created with ❤️ by Daniel Gabzdyl.

import Foundation


struct VolumesResponseDTO: Decodable {
    
    let totalItems: Int
    let items: [VolumeDTO]?
}
