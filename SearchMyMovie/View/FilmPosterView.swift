//
//  FilmPosterView.swift

import Foundation
import SwiftUI
import Combine

// | Movie poster image in both:
//  - List Cells
//  - detail view.

// Image is loaded over the Network Asynchronously,
// if it isn't already in the Application Cache.

struct FilmPosterView: View {
    
    // Poster URL string.
    @State var posterURL: String

    @State private var posterImage: UIImage?
    @State private var subscriptions: [AnyCancellable] = []

    var body: some View {
        if posterImage == nil {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .padding()
                .onAppear(perform: loadPoster)
                .foregroundColor(.gray)
        } else {
            Image(uiImage: posterImage!)
                .resizable()
                .scaledToFit()
        }
    }

    private func loadPoster() {
        guard let url = URL(string: posterURL) else {
            return
        }

        if let data = cached(key: url.absoluteString) {
            posterImage = UIImage(data: data as Data)
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    self.posterImage = UIImage(data: $0)
                    cache(key: url.absoluteString, value: $0)
                }
            )
            .store(in: &subscriptions)
    }
}

struct FilmPosterView_Previews: PreviewProvider {
    static var previews: some View {
        FilmPosterView(posterURL: FilmViewModel.example.poster)
            .preferredColorScheme(.dark)
    }
}
