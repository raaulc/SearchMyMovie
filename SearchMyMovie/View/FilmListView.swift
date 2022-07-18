//
//  FilmListView.swift

import SwiftUI

// Movies' List.

struct FilmListView: View {
    @EnvironmentObject private var viewModel: FilmListViewModel
    @State private var searchText: String = ""
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

    var recentsList: some View {
        List {
            Section(
                header: Text("Old Searches")
                    .font(.title3).textCase(nil)
            ) {
                ForEach(viewModel.recents, id: \.self) { recent in
                    Button(recent) {
                        viewModel.find(text: recent)
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
                .onDelete(perform: { indexSet in
                    viewModel.removeRecents(in: indexSet)
                })
            }
            .padding(.top)
        }
        .listStyle(InsetGroupedListStyle())
    }

    var body: some View {
        NavigationView {
            VStack {
                searchTextField

                Spacer()

                if viewModel.hasFilms {
                    searchResultsList
                } else {
                    if viewModel.hasRecents {
                        recentsList
                    }
                }
            }
            .navigationTitle("Search My Movie")
        }
    }

    func resetView() {
        searchText.removeAll()
        viewModel.clear()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListView()
            .environmentObject(FilmListViewModel.example)
            .preferredColorScheme(.dark)
    }
}
