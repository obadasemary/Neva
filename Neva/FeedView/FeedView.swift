//
//  FeedView.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 29.10.2025.
//

import SwiftUI

struct FeedView: View {

    @State var viewModel: FeedViewModel
    @Environment(FeedDetailsBuilder.self) private var feedDetailsBuilder
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]

    private var isShowingError: Binding<Bool> {
        Binding(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.clearError() }
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading && viewModel.characters.isEmpty {
                    // 🔸 Skeleton for carousel
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(0..<3, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 250, height: 150)
                                    .redacted(reason: .placeholder)
                                    .shimmer()
                            }
                        }
                        .padding()
                    }
                    
                    // 🔸 Skeleton for grid
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<6, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 200)
                                .redacted(reason: .placeholder)
                                .shimmer()
                        }
                    }
                    .padding()
                } else if viewModel.characters.isEmpty {
                    ContentUnavailableView(
                        "No Characters",
                        systemImage: "network.slash",
                        description: Text("Pull to refresh or check your connection")
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    CarouselView(characters: viewModel.characters)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            NavigationLink {
                                feedDetailsBuilder
                                    .buildFeedDetailsView(character: character)
                            } label: {
                                ProductCardView(character: character)
                            }
                            .buttonStyle(.plain)
                        }
                        
                    }
                    .padding()
                    
                    LazyVStack {
                        ForEach(viewModel.characters, id: \.id) { character in
                            NavigationLink {
                                feedDetailsBuilder
                                    .buildFeedDetailsView(character: character)
                            } label: {
                                CharacterView(character: character) { events in
                                    switch events {
                                    case .shareFacebook:
                                        viewModel.shareFace()
                                    case .tweetX:
                                        viewModel.tweetXTweet()
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .refreshable {
                await viewModel.loadData()
            }
            .task {
                await viewModel.loadData()
            }
            .navigationTitle("Feeds")
            .alert("Error", isPresented: isShowingError) {
                Button("OK") { }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
        }
    }
}

#Preview {
    let feedBuilder = FeedBuilder()
    feedBuilder.buildFeedView(usingMock: true)
}
