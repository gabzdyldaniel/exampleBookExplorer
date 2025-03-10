//
// Created with ❤️ by Daniel Gabzdyl.

import ComposableArchitecture
import SwiftUI


@Reducer
struct AppFeature {
    
    // MARK: - State
    
    @ObservableState
    struct State: Equatable {
        var bookList = BookListFeature.State()
    }
    
    
    // MARK: - Action
    
    enum Action {
        case bookList(BookListFeature.Action)
    }
    
    
    // MARK: - Reducer
    
    var body: some ReducerOf<Self> {
        Scope(state: \.bookList, action: \.bookList) {
            BookListFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .bookList:
                return .none
            }
        }
    }
}
