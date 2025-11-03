//
//  FeedView.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 29.10.2025.
//

import SwiftUI

struct FeedView: View {
    
    @State var viewModel: FeedViewModel
    var colums = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CarouselView(characters: viewModel.characters)
                
                LazyVGrid(columns: colums, spacing: 20) {
                    ForEach(viewModel.characters, id: \.id) { character in
                        ProductCardView(character: character)
                    }
                    
                }
                .padding()
                
                LazyVStack {
                    ForEach(viewModel.characters, id: \.id) { character in
                        CharacterView(character: character)
                    }
                }
            }
            .task {
                await viewModel.loadData()
            }
            .navigationTitle("Feeds")
        }
    }
}

#Preview {
    let feedBuilder = FeedBuilder()
    feedBuilder.buildFeedView(usingMock: true)
}
