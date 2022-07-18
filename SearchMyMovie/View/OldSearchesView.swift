//
//  FilmListView.swift

import SwiftUI

// Movies' List.

struct OldSearchesView: View {
    @EnvironmentObject private var viewModel: FilmListViewModel
    @State private var searchText: String = ""
    @Binding var tabSelection: Int

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
                ForEach(viewModel.recents, id: \.self) { recent in
                    Button(recent) {
                        viewModel.find(text: recent)
                        resetView()
                        self.tabSelection = 1
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
                .onDelete(perform: { indexSet in
                    viewModel.removeRecents(in: indexSet)
                })
            }
        .listStyle(InsetGroupedListStyle())
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.hasRecents {
                    recentsList
                }
            }
            .navigationTitle("Old Searches")
        }
    }

    func resetView() {
        searchText.removeAll()
        viewModel.clear()
    }
}
