//
//  FeedDetailsView.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 03.11.2025.
//

import SwiftUI

struct FeedDetailsView: View {

    @State var viewModel: FeedDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let imageURL = viewModel.character.image {
                    ImageLoaderView(url: imageURL)
                        .frame(height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    if let species = viewModel.character.species {
                        HStack {
                            Text("Species:")
                                .fontWeight(.semibold)
                            Text(species)
                                .foregroundStyle(.secondary)
                        }
                        .font(.title3)
                    }

                    HStack {
                        Text("ID:")
                            .fontWeight(.semibold)
                        Text("#\(viewModel.character.id)")
                            .foregroundStyle(.secondary)
                    }
                    .font(.title3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    NavigationStack {
        FeedDetailsView(
            viewModel: FeedDetailsViewModel(
                character: CharacterResponse(
                    id: 1,
                    name: "Rick Sanchez",
                    species: "Human",
                    image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
                )
            )
        )
    }
}
