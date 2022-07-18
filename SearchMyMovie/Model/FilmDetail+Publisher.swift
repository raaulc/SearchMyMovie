//
//  FilmDetail+Publisher.swift

import Foundation
import Combine

extension FilmDetail {
    
    // Publisher responsible for getting a single film detail.
    // | Parameters:
    //   - id: String id value to get the detail for..
    //   - store: In out store for subscriptions.
    //   - Returns: Publisher to sink responses with.
    
    static func publisher(id: String, store: inout[AnyCancellable]) -> AnyPublisher<FilmDetail, Error> {
        let publisher = PassthroughSubject<FilmDetail, Error>()
        let url = ServiceEndpoint.detail(id: id).url
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Self.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: { completed in publisher.send(completion: completed) },
                receiveValue: { result in publisher.send(result) })
            .store(in: &store)
        
        return publisher.eraseToAnyPublisher()
    }
}
