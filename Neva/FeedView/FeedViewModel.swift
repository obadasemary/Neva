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
    private(set) var errorMessage: String?
    
    init(feedUseCase: FeedUseCaseProtocol) {
        self.feedUseCase = feedUseCase
    }
    
    func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await fetchCharacter()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func fetchCharacter() async throws {
        guard let url = Constants.url else {
            throw FeedViewModelError.invalidURL
        }
        
        let response = try await feedUseCase.fetchFeed(url: url)
        characters = response.results
    }
    
    func shareFace() {
        // TODO: Implement Facebook sharing functionality
        print("shareFaceBook")
    }
    
    func tweetXTweet() {
        // TODO: Implement X (Twitter) sharing functionality
        print("tweetX")
    }
    
    func clearError() {
        errorMessage = nil
    }
}

enum FeedViewModelError: LocalizedError {
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL configuration. Please check the app settings."
        }
    }
}
