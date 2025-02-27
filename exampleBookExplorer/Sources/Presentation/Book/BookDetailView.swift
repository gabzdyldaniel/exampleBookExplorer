//
// Created with ❤️ by Daniel Gabzdyl.

import SwiftUI


struct BookDetailView: View {
    
    // MARK: - Input
    
    let book: Book
    
    
    // MARK: - State
    
    @State private var asyncImageId = UUID()
    
    
    // MARK: - Body
    
    var body: some View {
        Form {
            Section {
                AsyncImage(url: book.thumbnailUrl) { phase in
                    Group {
                        if let image = phase.image {
                            BookThumbnailView(type: .image(image, .normal))
                        } else if phase.error != nil {
                            BookThumbnailView(
                                type: .placeholder(
                                    Image(systemName: "arrow.circlepath"),
                                    .normal
                                )
                            )
                        } else {
                            BookThumbnailView(
                                type: .placeholder(
                                    Image(systemName: "book"),
                                    .normal
                                )
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onTapGesture {
                        retryIfPossible(phase: phase)
                    }
                }
                .id(asyncImageId)
            }
            .listRowBackground(Color.clear)
            
            Section {
                Text(book.title ?? "N/A")
                    .font(.title)
                    .fontWeight(.bold)
                
                if let authors = book.authors, !authors.isEmpty {
                    Text("detail.author")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .bold()
                    + Text(": ")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    + Text(authors.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let publishedDate = book.publishedDate {
                    Text("detail.publishedDate")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .bold()
                    + Text(": ")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    + Text(publishedDate.formatted(.dateTime.year()))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let description = book.description {
                    Text("detail.description")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .bold()
                    + Text(": ")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    + Text(description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
        .navigationTitle(book.title ?? "N/A")
        .navigationBarTitleDisplayMode(.inline)
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
    BookDetailView(
        book: VolumeDTO.harryPotterAndThePhilosophersStone.toEntity()
    )
}
