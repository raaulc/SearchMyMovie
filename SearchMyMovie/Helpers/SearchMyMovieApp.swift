//
//  SearchMyMovieApp.swift

import SwiftUI

@main
// App definition.

struct SearchMyMovieApp: App {
    // Environmental root level View Model for the main view.
    @StateObject var filmListViewModel: FilmListViewModel

    // Constructs the app including the root View Model as a 'State' object.
    init() {
        let viewModel = FilmListViewModel()
        _filmListViewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some Scene {
        WindowGroup {
            FilmListView()
                .environmentObject(filmListViewModel)
        }
    }
}
