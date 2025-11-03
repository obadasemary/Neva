//
//  FeedUseCase.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 29.10.2025.
//

import Foundation

protocol FeedUseCaseProtocol {
    func fetchFeed(url: URL) async throws -> FeedEntity
}

final class FeedUseCase {
    private let feedRepository: FeedRepositoryProtocol
    
    init(feedRepository: FeedRepositoryProtocol) {
        self.feedRepository = feedRepository
    }
}

extension FeedUseCase: FeedUseCaseProtocol {
    
    func fetchFeed(url: URL) async throws -> FeedEntity {
        try await feedRepository.fetchFeed(url: url)
    }
}
