//
// Created with ❤️ by Daniel Gabzdyl.

import SwiftUI


struct BookCellImage: View {
    
    enum `Type` {
        
        enum Size {
            case small
            case normal
            
            var width: CGFloat {
                switch self {
                case .small:
                    return 64
                case .normal:
                    return 128
                }
            }
            
            var height: CGFloat {
                switch self {
                case .small:
                    return 96
                case .normal:
                    return 192
                }
            }
        }
        
        case image(Image, Size)
        case placeholder(Image, Size)
    }
    
    
    // MARK: - Input
    
    let type: Type
    
    
    // MARK: - Body
    
    var body: some View {
        switch type {
        case .image(let image, let size):
            image
                .resizable()
                .scaledToFit()
                .frame(width: size.width, height: size.height)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 4,
                        style: .continuous
                    )
                )
        case .placeholder(let image, let size):
            Color.placeholder
                .frame(width: size.width, height: size.height)
                .overlay {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 4,
                        style: .continuous
                    )
                )
        }
    }
}


#Preview("Image", traits: .sizeThatFitsLayout) {
    BookCellImage(type: .image(Image(.bookThumbnailPlaceholder), .normal))
}

#Preview("Placeholder", traits: .sizeThatFitsLayout) {
    BookCellImage(type: .placeholder(Image(.bookThumbnailPlaceholder), .normal))
}
