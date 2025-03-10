//
// Created with ❤️ by Daniel Gabzdyl.

import ComposableArchitecture
import SwiftUI


@Reducer
struct BookDetailFeature {
    
    // MARK: - State
    
    @ObservableState
    struct State: Equatable {
        let book: Book
        var asyncImageId = UUID()
    }
    
    
    // MARK: - Action
    
    enum Action {
        case retryImageLoad
        case openInfoLink
    }
    
    
    // MARK: - Dependencies
    
    @Dependency(\.openURL) var openURL
    
    
    // MARK: - Reducer
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .retryImageLoad:
                state.asyncImageId = UUID()
                return .none
            case .openInfoLink:
                if let url = state.book.infoLinkUrl {
                    return .run { _ in
                        await openURL(url)
                    }
                }
                return .none
            }
        }
    }
}
