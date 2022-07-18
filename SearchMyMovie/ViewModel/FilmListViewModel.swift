//
//  FilmListViewModel.swift

import Foundation
import Combine

// View model - added as an environment object.
class FilmListViewModel: ObservableObject {
    private var subscriptions: [AnyCancellable] = []
    
    // A Collection of movies to render.
    @Published var films: [FilmViewModel] = []
    
    // A Collection of recent search strings.
    @Published var recents: [String] = []
    
    // Read-only field which returns 'true' if there are items to presents; otherwise, 'false'.
    var hasFilms: Bool {
        !films.isEmpty
    }
    
    // Read-only field which returns 'true' if there are recent items to present; otherwise, 'false'.
    var hasRecents: Bool {
        !recents.isEmpty
    }
    
    // Constructs a new view model, populating the recents list from user defaults.
    init() {
        _recents = Published(wrappedValue: UserDefaults.shared.recents)
    }
    
    // Attempts to find films from the remote API.
    // If the 'text' value is empty after trimming the search is abandoned. After the call
    // is complete, the published 'films' property is populated and signals the view to
    // reload.
    //   - Parameter text: String text to use as the basis of the search.
    
    func find(text: String) {
        let search = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard search.count > 0  else {
            return
        }

        Films.publisher(text: search, store: &subscriptions)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("failed to get films: \(error)")
                    }
                },
                receiveValue: {
                    self.films = $0.map(FilmViewModel.init)
                    self.appendRecent(value: text)
                }
            )
            .store(in: &subscriptions)
    }
    
    // Remove all search results.
    func clear() {
        films.removeAll()
    }
    
    // Add a new recent search to the list.
    //  - Parameter value: String value to add.
    func appendRecent(value: String) {
        guard !recents.contains(value) else { return }
        
        recents.insert(value, at: 0)
        if recents.count > UserDefaults.maxRecentItems {
            recents.removeLast()
        }
        UserDefaults.shared.addRecent(value: value)
    }
    
    // Remove items from the recent searches list.
    //  - Parameter offsets: 'IndexSet' elements to remove from the list.
    func removeRecents(in offsets: IndexSet) {
        recents.remove(atOffsets: offsets)
        UserDefaults.shared.removeRecents(in: offsets)
    }
    
    // Provides an example ViewModel for Previews.
    static var example: FilmListViewModel {
        let viewModel = FilmListViewModel()
        viewModel.films.append(
            .init(film: .init(id: "1", title: "Example 1", year: "2020", type: "movie", poster: "")))
        viewModel.films.append(
            .init(film: .init(id: "2", title: "Example 2", year: "2019", type: "movie", poster: "")))
        viewModel.films.append(
            .init(film: .init(id: "3", title: "Example 3", year: "2018", type: "movie", poster: "")))
        return viewModel
    }
}
