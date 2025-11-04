//
//  CharacterView.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 28.10.2025.
//

import SwiftUI

struct CharacterView: View {
    
    let character: CharacterResponse
    let event: (CharacterViewEvents) -> Void
    
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
            
            HStack(alignment: .bottom, spacing: 8) {
                Button {
                    event(.shareFacebook)
                } label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .foregroundStyle(.blue)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .accessibilityLabel("Share on Facebook")

                Button {
                    event(.tweetX)
                } label: {
                    Image(systemName: "xmark.app.fill")
                        .foregroundStyle(.primary)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .accessibilityLabel("Share on X")
            }
        }
        .padding()
        .background {
            Color.gray.opacity(0.05)
        }
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

extension CharacterView {
    
    enum CharacterViewEvents {
        
        case shareFacebook
        case tweetX
    }
}

#Preview {
    CharacterView(
        character: CharacterResponse(
            id: 1,
            name: "Obada",
            species: "Human",
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        ), event: { _ in
            
        }
    )
}
