//
//  FeedViewModel.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 29.10.2025.
//

import Foundation

@Observable
final class FeedViewModel {
    
    private let feedUseCase: FeedUseCaseProtocol
    
    private(set) var characters: [CharacterResponse] = []
    private(set) var isLoading: Bool = false
    
    init(feedUseCase: FeedUseCaseProtocol) {
        self.feedUseCase = feedUseCase
    }
    
    func loadData() async {
        isLoading = true
        
        do {
//            try? await Task.sleep(for: .seconds(1))
            try await fetchCharacter()
        } catch {
            print("Error", error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func fetchCharacter() async throws {
        guard let url = Constants.url else { return }
        
        let response = try await feedUseCase.fetchFeed(url: url)
        characters = response.results
        
    }
}
