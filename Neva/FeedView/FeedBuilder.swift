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

        let feedRepository: FeedRepositoryProtocol

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
        let detailsBuilder = FeedDetailsBuilder()
        return FeedView(viewModel: feedViewModel)
            .environment(detailsBuilder)
    }
}
