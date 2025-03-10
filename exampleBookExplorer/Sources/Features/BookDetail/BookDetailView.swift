//
// Created with ❤️ by Daniel Gabzdyl.

import ComposableArchitecture
import SwiftUI


struct BookDetailView: View {
    
    // MARK: - Store
    
    let store: StoreOf<BookDetailFeature>
    
    
    // MARK: - View
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    AsyncImage(url: viewStore.book.thumbnailUrl) { phase in
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
                            if phase.error != nil {
                                viewStore.send(.retryImageLoad)
                            }
                        }
                    }
                    .id(viewStore.asyncImageId)
                }
                .listRowBackground(Color.clear)
                
                Section {
                    Text(viewStore.book.title ?? "N/A")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if let authors = viewStore.book.authors, !authors.isEmpty {
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
                    
                    if let publishedDate = viewStore.book.publishedDate {
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
                    
                    if let description = viewStore.book.description {
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
            .navigationTitle(viewStore.book.title ?? "N/A")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if viewStore.book.infoLinkUrl != nil {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: 0.6)
                            viewStore.send(.openInfoLink)
                        } label: {
                            HStack {
                                Image(systemName: "arrow.up.forward.app")
                            }
                        }
                    }
                }
            }
        }
    }
}


// MARK: - Preview


#Preview("Book Detail") {
    BookDetailView(
        store: Store(
            initialState: BookDetailFeature.State(
                book: VolumeDTO.harryPotterAndThePhilosophersStone.toEntity()
            ),
            reducer: {
                BookDetailFeature()
            }
        )
    )
}
