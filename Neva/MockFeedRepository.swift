//
//  MockFeedRepository.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 29.10.2025.
//

import Foundation

class MockFeedRepository: FeedRepositoryProtocol {
    
    func fetchFeed(url: URL) async throws -> FeedEntity {
        FeedEntity(
            info: ResultPageInfo.init(count: 1, pages: 1),
            results: [
                CharacterResponse.init(
                    id: 1,
                    name: "Obada",
                    species: "Human",
                    image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
                ),
                CharacterResponse.init(
                    id: 2,
                    name: "Sara",
                    species: "Human",
                    image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
                ),
                CharacterResponse.init(
                    id: 3,
                    name: "Nazli",
                    species: "Alien",
                    image: URL(string: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")
                ),
            ]
        )
    }
}
