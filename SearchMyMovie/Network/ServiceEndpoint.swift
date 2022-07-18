//
//  ServiceEndpoint.swift

import Foundation

// Handles constructing URLs for remote server calls.
enum ServiceEndpoint {

    case search(text: String)
    case detail(id: String)

    // Returns a URL instance based on the endpoint request type.
    var url: URL {
        switch self {
        case .search(let text):
            return buildURL(key: "s", value: text)
        case .detail(let id):
            return buildURL(key: "i", value: id)
    }

    // Builds a URL for the remote request type.
    
    // | Parameters:
    //   - key: Query string key name.
    //   - value: Query string key value.
    //   - Returns: URL instance.
    private func buildURL(key: String, value: String) -> URL {

        // The API calls to the OMDB API are all GET requests where
        // the search and item calls are only differentiated by a
        // single query string parameter: "s" for searching and "i"
        // for detailed information calls.
        //
        // All calls require an API Key obtained from OMDB directly.
        // The FREE account allows up to 1000 requests per day.

        var components = URLComponents(string: baseURL.absoluteString)!
        components.queryItems = [
            .init(name: key, value: value),
            .init(name: "apikey", value: apiKey)
        ]
        return components.url!
    }

    private var baseURL: URL { URL(string: "https://www.omdbapi.com/")! }

    // My personal API Key has been hidden from source control by adding
    // a template Constants file, which was initially tracked, and then
    // I've removed tracking with the command:
    //
    //  `git update-index --skip-worktree <file>`
    //
    // Where I removed the Constants file from the index and can now update
    // freely locally without the changes being tracked.
    private var apiKey: String { Constants.apiKey }
}
