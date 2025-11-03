//
//  ProductCardView.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 31.10.2025.
//

import SwiftUI

struct ProductCardView: View {
    
    let character: CharacterResponse
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: character.image) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(
                            width: 100,
                            height: 100
                        )
                case .success(let image):
                    image
                        .resizable()
                        .cornerRadius(20)
                        .frame(width: 180)
                        .scaledToFit()
                case .failure:
                    Image(systemName: "person.crop.rectangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .bold()
                    .foregroundStyle(.primary)
                Text(character.species ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(width: 180, alignment: .leading)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
        }
        .frame(width: 180, height: 250)
        .shadow(radius: 3)
    }
}

#Preview {
    ProductCardView(
        character: CharacterResponse(
            id: 1,
            name: "Obada",
            species: "Human",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
    )
}
