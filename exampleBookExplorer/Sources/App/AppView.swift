//
// Created with ❤️ by Daniel Gabzdyl.

import ComposableArchitecture
import SwiftUI


struct AppView: View {
    
    
    // MARK: - Store
    
    let store: StoreOf<AppFeature>
    
    
    // MARK: - Body
    
    var body: some View {
        BookListView(store: store.scope(
            state: \.bookList,
            action: \.bookList
        ))
    }
}
