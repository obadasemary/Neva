//
//  CharacterView.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 28.10.2025.
//

import SwiftUI

struct CharacterView: View {
    
    let character: CharacterResponse
    
    var body: some View {
        HStack(alignment: .top) {
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
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(Constants.cornerRadius)
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
                    .font(.title)
                    .foregroundStyle(.primary)
                Text(character.species ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background {
            Color.gray.opacity(0.05)
        }
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

#Preview {
    CharacterView(
        character: CharacterResponse(
            id: 1,
            name: "Obada",
            species: "Human",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
    )
}
