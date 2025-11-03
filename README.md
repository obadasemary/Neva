# Neva

A SwiftUI iOS application that displays character data from the Rick and Morty API, built with Clean Architecture and modern Swift concurrency.

## Features

- Browse Rick and Morty characters in multiple layouts (carousel, grid, list)
- View detailed character information (image, name, species, ID)
- Async image loading with caching
- Clean, modern SwiftUI interface
- Offline-capable architecture with mock data support

## Architecture

Neva follows **Clean Architecture** principles with MVVM pattern:

```
View → ViewModel → UseCase → Repository → NetworkService
```

### Key Components

**View Layer (SwiftUI)**
- `FeedView`: Main feed screen with carousel and grid layouts
- `FeedDetailsView`: Character details screen
- Reusable components: `CarouselView`, `ProductCardView`, `CharacterView`, `ImageLoaderView`

**Presentation Layer**
- `FeedViewModel`: State management with `@Observable` macro
- `FeedDetailsViewModel`: Details screen state

**Domain Layer**
- `FeedUseCase`: Business logic for fetching feed data
- Protocol-based design for testability

**Data Layer**
- `FeedRepository`: Data access implementation
- `NetworkService`: Generic network layer with async/await
- Models: `FeedEntity`, `CharacterResponse`

### Design Patterns

- **Builder Pattern**: Dependency injection and view construction
- **Protocol-Oriented**: All service layers use protocols for testability
- **Environment-Based DI**: SwiftUI environment for navigation and routing
- **Async/Await**: Modern Swift concurrency throughout

## Getting Started

### Prerequisites

- Xcode 15.0 or later
- iOS 17.0 or later
- Swift 5.9+

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd Neva
```

2. Open the project in Xcode:
```bash
open Neva.xcodeproj
```

3. Build and run the project:
- Press `Cmd+R` to run on iOS Simulator or device
- Or use: `xcodebuild -project Neva.xcodeproj -scheme Neva build`

### Running Tests

Run all tests using:
```bash
xcodebuild test -project Neva.xcodeproj -scheme Neva -destination 'platform=iOS Simulator,name=iPhone 17'
```

Or press `Cmd+U` in Xcode.

## Project Structure

```
Neva/
├── FeedView/              # Feed feature module
│   ├── FeedView.swift
│   ├── FeedViewModel.swift
│   └── FeedBuilder.swift
├── FeedDetailsView/       # Details feature module
│   ├── FeedDetailsView.swift
│   ├── FeedDetailsViewModel.swift
│   └── FeedDetailsBuilder.swift
├── ViewModels/            # Shared view models
├── Repositories/          # Data layer
├── UseCases/             # Business logic
├── Entities/             # Data models
├── Views/                # Reusable UI components
└── Mocks/                # Test mocks

NevaTests/                # Unit tests
```

## Tech Stack

- **SwiftUI**: Declarative UI framework
- **Swift Concurrency**: Async/await for asynchronous operations
- **Swift Testing**: Modern testing framework with `@Test` attribute
- **Sendable Protocol**: Thread-safe data models
- **@Observable Macro**: Swift 5.9+ observation framework

## Testing Strategy

Tests use the Swift Testing framework with:
- Mock implementations following `Mock<Protocol>` naming pattern
- Protocol-based dependency injection for easy mocking
- `@MainActor` tests for ViewModels that update UI state

Example:
```swift
@MainActor
@Test("Load characters successfully")
func testLoadCharacters() async throws {
    let mockUseCase = MockFeedUseCase(result: .success(...))
    let viewModel = FeedViewModel(feedUseCase: mockUseCase)
    await viewModel.loadData()
    #expect(viewModel.characters == expectedResult)
}
```

## API

This app uses the [Rick and Morty API](https://rickandmortyapi.com/) to fetch character data.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

[Add your license here]

## Acknowledgments

- Character data provided by [Rick and Morty API](https://rickandmortyapi.com/)
- Built with SwiftUI and modern Swift features
