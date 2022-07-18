//
//  Films+Publisher.swift

import Foundation
import Combine

extension Films {
    
    // Publisher responsible for making a film search.
    // | Parameters:
    //   - text: String value to search for.
    //   - store: In out store for subscriptions.
    //   - Returns: Publisher to sink responses with.
    
    static func publisher(text: String, store: inout [AnyCancellable]) -> AnyPublisher<[Film], Error> {
        let publisher = PassthroughSubject<[Film], Error>()
        let url = ServiceEndpoint.search(text: text).url
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Self.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: { completed in publisher.send(completion: completed) },
                receiveValue: { result in publisher.send(result.results) })
            .store(in: &store)
        return publisher.eraseToAnyPublisher()
    }
}
