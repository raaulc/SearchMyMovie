//
//  FilmListCellView.swift

import SwiftUI

// Single row movies' list.

struct FilmListCellView: View {
    let viewModel: FilmViewModel

    var body: some View {
        HStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color.white.opacity(1))
                .frame(width: 70, height: 100)
                .overlay(FilmPosterView(posterURL: viewModel.poster))
                .border(Color.black, width: 0.5)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                /* .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 0.5)
                ) */
            
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.title2)
                Text(viewModel.year)
                    .font(.body)
                    .foregroundColor(.secondary)

                Spacer()

                Text(viewModel.type)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
            }
            .padding(.top, 4)
        }
        .padding([.top, .bottom], 6)
    }
}

struct FilmCellView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FilmListCellView(viewModel: FilmViewModel.example)
        }
        .listStyle(PlainListStyle())
        .preferredColorScheme(.dark)
    }
}
