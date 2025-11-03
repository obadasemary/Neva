//
//  FeedDetailsViewModelTests.swift
//  NevaTests
//
//  Created by Abdelrahman Mohamed on 03.11.2025.
//

import Foundation
import Testing
@testable import Neva

@Test("FeedDetailsViewModel holds character data correctly")
func testCharacterData() {
    // Given
    let character = CharacterResponse(
        id: 1,
        name: "Rick Sanchez",
        species: "Human",
        image: nil
    )

    // When
    let viewModel = FeedDetailsViewModel(character: character)

    // Then
    #expect(viewModel.character.id == 1)
    #expect(viewModel.character.name == "Rick Sanchez")
    #expect(viewModel.character.species == "Human")
}

@Test("FeedDetailsViewModel stores complete character information")
func testCompleteCharacterInfo() {
    // Given
    let imageURL = URL(string: "https://example.com/image.jpg")
    let character = CharacterResponse(
        id: 42,
        name: "Morty Smith",
        species: "Human",
        image: imageURL
    )

    // When
    let viewModel = FeedDetailsViewModel(character: character)

    // Then
    #expect(viewModel.character.id == 42)
    #expect(viewModel.character.name == "Morty Smith")
    #expect(viewModel.character.species == "Human")
    #expect(viewModel.character.image == imageURL)
}

@Test("FeedDetailsViewModel handles optional species")
func testOptionalSpecies() {
    // Given
    let character = CharacterResponse(
        id: 100,
        name: "Unknown Character",
        species: nil,
        image: nil
    )

    // When
    let viewModel = FeedDetailsViewModel(character: character)

    // Then
    #expect(viewModel.character.species == nil)
    #expect(viewModel.character.name == "Unknown Character")
}
