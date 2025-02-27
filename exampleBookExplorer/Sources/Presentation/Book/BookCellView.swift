//
// Created with ❤️ by Daniel Gabzdyl.

import SwiftUI


struct BookCellView: View {
        
    // MARK: - Input
    
    let book: Book
    let namespace: Namespace.ID
    
    
    // MARK: - State
    
    @State private var asyncImageId = UUID()
    
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                AsyncImage(url: book.smallThumbnailUrl) { phase in
                    Group {
                        if let image = phase.image {
                            BookThumbnailView(type: .image(image, .small))
                        } else if phase.error != nil {
                            BookThumbnailView(
                                type: .placeholder(
                                    Image(systemName: "arrow.circlepath"),
                                    .small
                                )
                            )
                        } else {
                            BookThumbnailView(
                                type: .placeholder(
                                    Image(systemName: "book"),
                                    .small
                                )
                            )
                        }
                    }
                    .onTapGesture {
                        retryIfPossible(phase: phase)
                    }
                }
                .id(asyncImageId)
                .matchedTransitionSource(id: book.id, in: namespace)
                
                VStack(alignment: .leading) {
                    Text(book.title ?? "N/A")
                        .bold()
                        .lineLimit(2)
                    
                    if let authorsText = book.authors?.joined(separator: ", ") {
                        Text(authorsText)
                            .font(.caption)
                    }
                }
            }
            
            Spacer()
        }
    }
    
    
    // MARK: - Helper functions
    
    private func retryIfPossible(phase: AsyncImagePhase) {
        guard case .failure = phase else {
            return
        }
        
        asyncImageId = UUID()
    }
}


#Preview {
    @Previewable
    @Namespace
    var namespace
    
    BookCellView(
        book: VolumeDTO.harryPotterAndThePhilosophersStone.toEntity(),
        namespace: namespace
    )
}
