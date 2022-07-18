//
//  Film.swift

import Foundation

// Represents a model object for a single film search result.
struct Film: Decodable, Identifiable {
    var id: String
    var title: String
    var year: String
    var type: String
    var poster: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}
