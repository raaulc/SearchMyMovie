//
//  SeriesHeatMapViewModel.swift

import Foundation
import Combine

// View Model - added when selecting a cell from the movie list.
class SeriesHeatMapViewModel: ObservableObject {
    private var id: String
    private var model: FilmDetail?

    private var subscriptions: [AnyCancellable] = []

    // Value monitored by the view to signal when data is loaded from the remote server.
    @Published var isLoaded: Bool = false

    // Constructs a Film Detail view model from a film ID.
    //   - Parameter id: Unique String identifier for a film.
    init(id: String) {
        self.id = id
    }

    // Poster URL string.
    var poster: String {
        model?.poster ?? ""
    }

    // Title for the film as a String.
    var title: String {
        model?.title ?? ""
    }

    // Plot details for the film as a String.
    var plot: String {
        model?.plot ?? "No details"
    }

    // Type of media; examples: "movie", "series", "game", or "None" if not applicable, as a String.
    // Capitalised automatically for presentation.
    var type: String {
        model?.type.capitalized ?? "None"
    }

    // Name of the director, or None if not applicable, as a String.
    var director: String {
        model?.director ?? "None"
    }

    // Rating for the item, formatting as  score out of 10 as a String e.g. 5/10
    var rating: String {
        "\(model?.rating ?? "0")/10"
    }

    // The number of votes, as a String, which contributed to the rating value.
    var votes: String {
        "(votes \(model?.votes ?? "0"))"
    }

    // The year the item was released, as a String, or "None" is not applicable.
    var year: String {
        model?.year ?? "None"
    }

    // Asynchronous call to get the item data from the remote server.
    // Uses the `FilmDetail` publisher to get the remote data, which when complete
    // sets the model cache and then signals the view with the `isLoaded` published field.
    func load() {
        FilmDetail.publisher(id: self.id, store: &subscriptions)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("failed to get film detail: \(error)")
                    }
                },
                receiveValue: {
                    self.model = $0
                    self.isLoaded = true
                }
            )
            .store(in: &subscriptions)
    }

    // Provides an example ViewModel for previews
    static var example: SeriesHeatMapViewModel {
        let viewModel = SeriesHeatMapViewModel(id: "")
        viewModel.model = .init(
            id: "",
            title: "Example Film Title",
            year: "2001",
            type: "movie",
            plot: "Simple text description",
            director: "The Man",
            rating: "5",
            votes: "2020",
            poster: "")
        viewModel.isLoaded = true
        return viewModel
    }
}

