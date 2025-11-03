//
//  FeedBuilder.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 29.10.2025.
//

import Foundation
import SwiftUI

@Observable
final class FeedBuilder {
    
    func buildFeedView(usingMock: Bool = false) -> some View {
        
        var feedRepository: FeedRepositoryProtocol
        
        if usingMock {
            feedRepository = MockFeedRepository()
        } else {
            let networkService = NetworkService(session: .shared)
            feedRepository = FeedRepository(
                networkService: networkService
            )
        }
        
        let feedUseCase = FeedUseCase(
            feedRepository: feedRepository
        )
        let feedViewModel = FeedViewModel(feedUseCase: feedUseCase)
        return FeedView(viewModel: feedViewModel)
    }
}
