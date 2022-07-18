//
//  FilmDetailView.swift

import SwiftUI

// Movie detailed information.

struct FilmDetailView: View {
    @ObservedObject var viewModel: FilmDetailViewModel

    var loadingView: some View {
        ProgressView(value: 0.0)
            .progressViewStyle(CircularProgressViewStyle())
    }

    var detailView: some View {
        VStack(alignment: .leading, spacing: 10) {
            FilmPosterView(posterURL: viewModel.poster)
                .ignoresSafeArea()

            // Header Group
            Group {
                Text(viewModel.title)
                    .font(.title)
                Text(viewModel.plot)
                Text(viewModel.type)
                    .foregroundColor(.secondary)
            }

            // Information Group
            Group {
                headerView(title: "Director")
                Text(viewModel.director)

                headerView(title: "Rating")
                HStack {
                    Text(viewModel.rating)
                    Text(viewModel.votes)
                        .foregroundColor(.secondary)
                }

                headerView(title: "Year")
                Text(viewModel.year)
            }

            Spacer()
        }
        .padding([.leading, .trailing, .bottom])
    }

    var body: some View {
        if !viewModel.isLoaded {
            loadingView
                .onAppear(perform: viewModel.load)
        } else {
            ScrollView {
                detailView
            }
            .navigationBarTitle("Details")
        }
    }

    func headerView(title: String) -> some View {
        Text(title)
            .fontWeight(.bold)
            .padding(.top)
    }
}

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FilmDetailView(viewModel: FilmDetailViewModel.example)
        }.preferredColorScheme(.dark)
    }
}
