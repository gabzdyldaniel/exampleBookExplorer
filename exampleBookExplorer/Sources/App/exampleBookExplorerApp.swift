//
// Created with ❤️ by Daniel Gabzdyl.

import SwiftUI
import ComposableArchitecture


@main
struct BookExplorerApp: App {
    
    let store = Store(
        initialState: AppFeature.State(),
        reducer: { AppFeature() }
    )
    
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
