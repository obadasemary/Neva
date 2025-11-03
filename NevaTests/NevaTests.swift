//
//  NevaTests.swift
//  NevaTests
//
//  Created by Abdelrahman Mohamed on 28.10.2025.
//

import Testing
import Foundation
@testable import Neva

struct NevaTests {

    @MainActor
    @Test("Test Fetch Feed with Success")
    func fetchCharacters_onSuccess() async throws {
        let response = [
            CharacterResponse(
                id: 1,
                name: "Obada",
                species: "Human",
                image: nil
            ),
            CharacterResponse(
                id: 1,
                name: "Obada",
                species: "Human",
                image: nil
            )
        ]
        
        let makeSut = {
            MockFeedUseCase(
                result:
                        .success(
                            FeedEntity(
                                info: ResultPageInfo(count: 1, pages: 1),
                                results: response
                            )
                        )
            )
        }
        
        let viewModel = FeedViewModel(feedUseCase: makeSut())
        
        await viewModel.loadData()
        
        #expect(viewModel.characters == response)
    }
    
    @MainActor
    @Test("Test Fetch Feed with Failure")
    func fetchCharacters_onFailure() async throws {
        let makeSut = {
            MockFeedUseCase(result: .failure(MockError.stub))
        }
        
        let viewModel = FeedViewModel(feedUseCase: makeSut())
        
        await viewModel.loadData()
        
        #expect(viewModel.characters.isEmpty)
    }
}

private extension NevaTests {
    
    enum MockError: Error {
        case stub
    }
    
    final class MockFeedUseCase: FeedUseCaseProtocol {
        
        private let result: Result<FeedEntity, Error>
        
        init(result: Result<FeedEntity, Error>) {
            self.result = result
        }
        
        func fetchFeed(url: URL) async throws -> FeedEntity {
            switch result {
            case .success(let response):
                response
            case .failure(let error):
                throw error
            }
        }
    }
}
