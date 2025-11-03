//
//  FeedDetailsViewModel.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 03.11.2025.
//

import Foundation

@Observable
final class FeedDetailsViewModel {

    let character: CharacterResponse

    init(character: CharacterResponse) {
        self.character = character
    }
}
