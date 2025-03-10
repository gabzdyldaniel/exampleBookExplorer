//
// Created with ❤️ by Daniel Gabzdyl.

import ComposableArchitecture
import SwiftUI


struct BookListView: View {
    
    // MARK: - Store
    
    let store: StoreOf<BookListFeature>
    
    
    // MARK: - Namespace
    
    @Namespace private var namespace
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStackStore(
            self.store.scope(
                state: \.path,
                action: \.path
            )
        ) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                List {
                    Group {
                        if viewStore.viewState == .loaded {
                            ForEach(viewStore.books) { book in
                                Button {
                                    viewStore.send(.bookTapped(book))
                                } label: {
                                    BookCellView(book: book, namespace: namespace)
                                }
                            }
                        } else if case let .error(message) = viewStore.viewState {
                            Text(message)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollDismissesKeyboard(.immediately)
                .searchable(
                    text: viewStore.binding(
                        get: \.searchText,
                        send: { .searchTextChanged($0) }
                    ),
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("list.search.placeholder")
                )
                .overlay {
                    if viewStore.viewState == .initial {
                        ContentUnavailableView {
                            Label {
                                Text("list.state.initial.title")
                            } icon: {
                                Image(.book)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                            }
                        } description: {
                            Text("list.state.initial.description")
                        }
                    } else if viewStore.viewState == .noResults && !viewStore.searchText.isEmpty {
                        ContentUnavailableView.search(text: viewStore.searchText)
                    } else if viewStore.viewState == .loading {
                        ProgressView()
                    }
                }
                .navigationBarTitle("list.navigationTitle")
            }
        } destination: { bookDetailStore in
            BookDetailView(store: bookDetailStore)
                .navigationTransition(.zoom(sourceID: ViewStore(bookDetailStore, observe: { $0 }).book.id, in: namespace))
        }
    }
}


// MARK: - Previews

#Preview("Initial State") {
    BookListView(
        store: Store(
            initialState: BookListFeature.State()
        ) {
            BookListFeature()
        }
    )
}

#Preview("Loading State") {
    BookListView(
        store: Store(
            initialState: BookListFeature.State(
                searchText: "Rowling",
                isLoading: true
            )
        ) {
            BookListFeature()
        }
    )
}

#Preview("Loaded State") {
    BookListView(
        store: Store(
            initialState: BookListFeature.State(
                books: [
                    VolumeDTO.harryPotterAndThePhilosophersStone.toEntity()
                ],
                searchText: "Rowling"
            )
        ) {
            BookListFeature()
        }
    )
}

#Preview("No Results") {
    BookListView(
        store: Store(
            initialState: BookListFeature.State(
                books: [],
                searchText: "NonExistentAuthor"
            )
        ) {
            BookListFeature()
        }
    )
}

#Preview("Error State") {
    BookListView(
        store: Store(
            initialState: BookListFeature.State(
                searchText: "ErrorAuthor",
                errorMessage: "Network error occurred"
            )
        ) {
            BookListFeature()
        }
    )
}
