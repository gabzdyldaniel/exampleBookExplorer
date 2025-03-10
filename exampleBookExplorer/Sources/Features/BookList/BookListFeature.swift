//
// Created with ❤️ by Daniel Gabzdyl.

import ComposableArchitecture
import SwiftUI
import Foundation


@Reducer
struct BookListFeature {
    
    // MARK: - State
    
    @ObservableState
    struct State: Equatable {
        
        enum ViewState: Equatable {
            case initial
            case loading
            case loaded
            case noResults
            case error(String)
        }
        
        var path = StackState<BookDetailFeature.State>()
        var books: [Book] = []
        var searchText = ""
        var isLoading = false
        var errorMessage: String?
        
        var viewState: ViewState {
            if searchText.isEmpty {
                return .initial
            } else if isLoading {
                return .loading
            } else if !books.isEmpty {
                return .loaded
            } else if let errorMessage {
                return .error(errorMessage)
            } else {
                return .noResults
            }
        }
    }
    
    
    // MARK: - Action
    
    enum Action {
        case searchTextChanged(String)
        case searchDebounced
        case booksResponse(TaskResult<[Book]>)
        case bookTapped(Book)
        case path(StackAction<BookDetailFeature.State, BookDetailFeature.Action>)
    }
    
    
    // MARK: - Dependencies
    
    @Dependency(\.bookClient) var bookClient
    
    
    // MARK: - Cancellables
    
    private enum CancelID {
        case search
    }
    
    
    // MARK: - Reducer
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .searchTextChanged(text):
                state.isLoading = true
                state.searchText = text
                
                // Clear results if search is empty
                if text.isEmpty {
                    state.books = []
                    state.errorMessage = nil
                    return .cancel(id: CancelID.search)
                }
                
                // Debounce search requests to prevent too many API calls
                return .run { send in
                    try await Task.sleep(for: .milliseconds(300))
                    await send(.searchDebounced)
                }
                .cancellable(id: CancelID.search, cancelInFlight: true)
            case .searchDebounced:
                // Only search if there's text
                guard !state.searchText.isEmpty else {
                    return .none
                }
                
                state.errorMessage = nil
                
                return .run { [searchText = state.searchText] send in
                    await send(
                        .booksResponse(
                            TaskResult {
                                try await bookClient.getBooks(searchText)
                            }
                        )
                    )
                }
            case let .booksResponse(.success(books)):
                state.books = books
                state.isLoading = false
                return .none
            case let .booksResponse(.failure(error)):
                state.books = []
                state.isLoading = false
                state.errorMessage = error.localizedDescription
                return .none
            case let .bookTapped(book):
                state.path.append(
                    BookDetailFeature.State(book: book)
                )
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            BookDetailFeature()
        }
    }
}
