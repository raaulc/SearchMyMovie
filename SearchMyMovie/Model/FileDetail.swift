//
//  FileDetail.swift

import Foundation

// Represents a model object for a single movie detail result.
struct FilmDetail: Decodable, Identifiable {
    var id: String
    var title: String
    var year: String
    var type: String
    var plot: String
    var director: String
    var rating: String
    var votes: String
    var poster: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case plot = "Plot"
        case director = "Director"
        case rating = "imdbRating"
        case votes = "imdbVotes"
        case poster = "Poster"
    }
}
