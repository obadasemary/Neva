//
//  CarouselView.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 01.11.2025.
//

import SwiftUI

struct CarouselView: View {
    
    let characters: [CharacterResponse]
    
    @State private var currentIndex = 0
    
    var body: some View {
        Group {
            if characters.isEmpty {
                EmptyView()
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(Array(characters.enumerated()), id: \.1.id) { index, character in
                        CarouselCard(character: character)
                            .tag(index)
                            .padding(.horizontal)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding(.top)
            }
        }
    }
}

#Preview {
    CarouselView(
        characters: [
            CharacterResponse(
                id: 1,
                name: "Obada",
                species: "Human",
                image: URL(string: "https://picsum.photos/600/600")
            ),
            CharacterResponse(
                id: 2,
                name: "Sara",
                species: "Human",
                image: URL(string: "https://picsum.photos/600/600")
            ),
            CharacterResponse(
                id: 3,
                name: "Nazli",
                species: "Human",
                image: URL(string: "https://picsum.photos/600/600")
            )
        ]
    )
}
