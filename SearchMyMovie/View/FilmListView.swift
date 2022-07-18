//
//  FilmListView.swift

import SwiftUI

// Movies' List.
struct FilmListView: View {
    @EnvironmentObject private var viewModel: FilmListViewModel
    @State private var searchText: String = ""
    @Binding var tabSelection: Int

    var searchTextField: some View {
        HStack {
            TextField(
                "Search for a Movie",
                text: $searchText,
                onEditingChanged: { _ in },
                onCommit: {
                    viewModel.find(text: searchText)
                }
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())

            Button {
                resetView()
            } label: {
                Image(systemName: "xmark.circle")
            }
        }
        .padding()
    }

    var searchResultsList: some View {
        List {
            ForEach(viewModel.films) { film in
                NavigationLink(
                    destination: FilmDetailView(viewModel: FilmDetailViewModel(id: film.id)),
                    label: {
                        FilmListCellView(viewModel: film)
                    }
                )
            }
        }
        .listStyle(PlainListStyle())
    }

    var body: some View {
        NavigationView {
            VStack {
                searchTextField

                Spacer()

                if viewModel.hasFilms {
                    searchResultsList
                }
            }
            .navigationTitle("Search My Movie")
            .onAppear {
                searchText.removeAll()
            }

        }
    }


    func resetView() {
        searchText.removeAll()
        viewModel.clear()
    }
}
