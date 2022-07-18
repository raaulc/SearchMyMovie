//
//  FilmViewModel.swift

import Foundation

// View model - added when creating cell from the movie list.
class FilmViewModel: Identifiable {
    
    private var film: Film
    
    // Unique ID for the movie element as a String.
    var id: String {
        film.id
    }
    
    // Title for the movie as a String.
    var title: String {
        film.title
    }

    // Year the item was released, as a String, or "None" if is not applicable.
    var year: String {
        film.year
    }

    // Type of media; examples: "movie", "series", "game", or "None" if is not applicable, as a String.
    // Capitalized automatically for presentation.
    var type: String {
        film.type.capitalized
    }

    // Poster URL string.
    var poster: String {
        film.poster
    }

    // Constructs a new instance of the view model with a 'Film' model instance.
    //  - Parameter film: 'Film' model instance.
    init(film: Film) {
        self.film = film
    }
    
    // Provides an example View Model for previews
    static var example: FilmViewModel {
        .init(film: .init(id: "1", title: "Example 1", year: "2020", type: "movie", poster: ""))
    }
}
