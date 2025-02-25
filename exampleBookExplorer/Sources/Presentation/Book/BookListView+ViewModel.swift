//
// Created with ❤️ by Daniel Gabzdyl.

import SwiftUI
import Combine


extension BookListView {
    
    @Observable class ViewModel {
        
        enum ViewState {
            case initial
            case loading
            case loaded([Book])
            case error(Error)
        }
        
        // MARK: - UseCases
        
        private let getBooks = inject(GetBooksUseCase.self)
        
        
        // MARK: - Internal properties
        
        var viewState: ViewState = .initial
        
        var userInput = "" {
            didSet {
                searchTextSubject.send(userInput)
            }
        }
        
        
        // MARK: - Private properties
        
        private var searchText: String? = nil
        private let searchTextSubject = PassthroughSubject<String, Never>()
        private var cancellables = Set<AnyCancellable>()
        
        
        // MARK: - Init
        
        init() {
            registerSearchTextSubject()
        }
        
        
        // MARK: - Internal functions
        
        func getBooks() async {
            do {
                viewState = .loading
                let books = try await getBooks(author: userInput)
                viewState = .loaded(books)
            } catch {
                viewState = .error(error)
            }
        }
        
        
        // MARK: - Private functions
        
        private func registerSearchTextSubject() {
            searchTextSubject
                .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
                .sink { text in
                    guard !text.isEmpty else {
                        self.viewState = .initial
                        self.searchText = nil
                        return
                    }
                    
                    guard self.searchText != text else {
                        return
                    }
                    
                    self.searchText = text
                    
                    Task {
                        await self.getBooks()
                    }
                }
                .store(in: &cancellables)
        }
    }
}
