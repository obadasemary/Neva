//
//  FeedEntity.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 28.10.2025.
//

import Foundation

struct FeedEntity: Decodable, Sendable {
    let info: ResultPageInfo
    let results: [CharacterResponse]
}

struct ResultPageInfo: Decodable, Sendable {
    let count: Int
    let pages: Int
    
    init(count: Int, pages: Int) {
        self.count = count
        self.pages = pages
    }
}

struct CharacterResponse: Decodable, Identifiable, Equatable, Sendable {
    
    let id: Int
    let name: String
    let species: String?
    let image: URL?
    
    init(id: Int, name: String, species: String?, image: URL?) {
        self.id = id
        self.name = name
        self.species = species
        self.image = image
    }
}
