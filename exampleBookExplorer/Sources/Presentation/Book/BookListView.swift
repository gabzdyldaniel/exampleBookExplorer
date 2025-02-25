//
// Created with ❤️ by Daniel Gabzdyl.

import SwiftUI


struct BookListView: View {
    
    // MARK: - Namespace
    
    @Namespace private var namespace
    
    
    // MARK: - State
    
    @State private var viewModel = ViewModel()
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    switch viewModel.viewState {
                    case .loaded(let books):
                        listView(for: books)
                    case .error(let error):
                        Text(error.localizedDescription)
                    default:
                        EmptyView()
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollDismissesKeyboard(.immediately)
            .searchable(
                text: $viewModel.userInput,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("list.search.placeholder")
            )
            .overlay {
                if case .initial = viewModel.viewState {
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
                } else if case .loaded(let books) = viewModel.viewState, books.isEmpty, !viewModel.userInput.isEmpty {
                    ContentUnavailableView.search(text: viewModel.userInput)
                } else if case .loading = viewModel.viewState {
                    ProgressView()
                }
            }
            .navigationBarTitle("list.navigationTitle")
        }
    }
    
    private func listView(for books: [Book]) -> some View {
        ForEach(books) { book in
            NavigationLink {
                BookDetailView(book: book)
                    .navigationTransition(.zoom(sourceID: book.id, in: namespace))
            } label: {
                BookCellView(book: book, namespace: namespace)
            }
        }
    }
}


#Preview {
    BookListView()
}
