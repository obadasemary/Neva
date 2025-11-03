# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Neva is a SwiftUI iOS application that displays character data from the Rick and Morty API. The app follows Clean Architecture principles with MVVM pattern.

## Build and Test Commands

### Building
```bash
# Build the project
xcodebuild -project Neva.xcodeproj -scheme Neva build

# Or use Xcode: Cmd+B
```

### Testing
```bash
# Run all tests
xcodebuild test -project Neva.xcodeproj -scheme Neva -destination 'platform=iOS Simulator,name=iPhone 17'

# Or use Xcode: Cmd+U
```

Note: Tests use the Swift Testing framework (not XCTest), with `@Test` attribute instead of XCTest methods.

### Running
Open `Neva.xcodeproj` in Xcode and run the app (Cmd+R) on the iOS Simulator or device.

## Architecture

The app follows Clean Architecture with distinct layers:

### Layer Structure
```
View → ViewModel → UseCase → Repository → NetworkService
```

**View Layer (SwiftUI)**
- `FeedView`: Main feed screen with carousel and grid layouts
  - Contains navigation to `FeedDetailsView` via `NavigationLink`
  - Uses `@Environment(FeedDetailsBuilder.self)` for routing
- `FeedDetailsView`: Character details screen showing image, name, species, and ID
- `CarouselView`, `CharacterView`, `ProductCardView`: UI components with navigation support
- `ImageLoaderView`: Async image loading component

**Presentation Layer**
- `FeedViewModel`: Uses `@Observable` macro (Swift 5.9+) for state management
- `FeedDetailsViewModel`: Simple view model holding selected character data
- ViewModels are injected via `@State` property wrapper in views

**Domain Layer**
- `FeedUseCase`: Business logic for fetching feed data
- `FeedUseCaseProtocol`: Protocol for testability

**Data Layer**
- `FeedRepository`: Data access implementation
- `FeedRepositoryProtocol`: Protocol for dependency injection
- `NetworkService`: Generic network layer with async/await
- `FeedEntity`, `CharacterResponse`: Data models (Decodable, Sendable)

### Dependency Injection

The app uses the **Builder pattern** combined with **@Environment** for dependency injection:

```swift
// FeedBuilder assembles the dependency graph
let feedBuilder = FeedBuilder()
feedBuilder.buildFeedView(usingMock: false)
```

**Constructor Injection Pattern:**
- `FeedBuilder.buildFeedView(usingMock:)` creates the entire view hierarchy with dependencies
- Pass `usingMock: true` for SwiftUI previews or testing without network calls
- All service layer dependencies are constructor-injected following protocol-oriented design

**Environment-Based Injection (Swift 5.9+):**
- `FeedDetailsBuilder` is injected via `@Environment(FeedDetailsBuilder.self)`
- Uses `@Observable` macro which automatically enables environment injection
- No custom `EnvironmentKey` needed - the type itself is the key
- Injection example: `.environment(detailsBuilder)` in FeedBuilder
- Access example: `@Environment(FeedDetailsBuilder.self) private var feedDetailsBuilder` in views

**Navigation Pattern:**
- All navigation uses SwiftUI's `NavigationLink` with `NavigationStack`
- Routes are created by builders (e.g., `feedDetailsBuilder.buildFeedDetailsView(character:)`)
- Navigation destinations are injected via environment, keeping views decoupled from routing logic

### Testing Strategy

- Tests use Swift Testing framework with `@Test` attribute
- Mock implementations follow the protocol naming pattern: `Mock<Protocol>` (e.g., `MockFeedRepository`)
- ViewModels are tested with mocked UseCases that return `Result<T, Error>`
- Tests are marked `@MainActor` when testing view models that update UI state

Example test pattern:
```swift
@MainActor
@Test("Description")
func testName() async throws {
    let mockUseCase = MockFeedUseCase(result: .success(...))
    let viewModel = FeedViewModel(feedUseCase: mockUseCase)
    await viewModel.loadData()
    #expect(viewModel.characters == expectedResult)
}
```

### Navigation & Routing

The app uses **Builder-based routing** with environment injection:

**Implementation Pattern:**
```swift
// 1. Builder is injected via environment
@Environment(FeedDetailsBuilder.self) private var feedDetailsBuilder

// 2. NavigationLink uses builder to create destination
NavigationLink {
    feedDetailsBuilder.buildFeedDetailsView(character: character)
} label: {
    ProductCardView(character: character)
}

// 3. Buttons use .buttonStyle(.plain) to prevent NavigationLink highlighting
.buttonStyle(.plain)
```

**Navigation Flow:**
- `FeedView` → `FeedDetailsView`: User taps on character in carousel, grid, or list
- All navigation goes through `NavigationStack` in `FeedView`
- `CarouselView`, `ProductCardView`, and `CharacterView` all support navigation via `NavigationLink`
- Each view uses `@Environment(FeedDetailsBuilder.self)` to access the builder for routing

**Benefits:**
- Views remain decoupled from navigation logic
- Easy to test by mocking builders
- Centralized route creation through builders
- Type-safe navigation with compile-time checks

## Key Design Decisions

1. **Protocol-Oriented Programming**: All service layers use protocols (`*Protocol`) to enable testability and dependency injection
2. **@Observable Macro**: Uses Swift 5.9+ `@Observable` instead of `ObservableObject` for ViewModels and Builders
3. **Environment-Based DI**: Leverages `@Observable` macro for automatic environment injection without custom `EnvironmentKey`
4. **Builder Pattern for Navigation**: Builders create view hierarchies and are injected via `@Environment` for decoupled routing
5. **Async/Await**: All network calls and data operations use modern async/await (no callbacks or Combine)
6. **Sendable Conformance**: Entities conform to `Sendable` for safe concurrency
7. **Constants**: API URLs and UI constants are centralized in `Constants.swift`

## File Organization

Source files are organized in the `Neva/` directory with feature-based folders:

**Feature Folders:**
- `FeedView/`: Feed screen feature
  - `FeedView.swift`: Main feed view
  - `FeedViewModel.swift`: Feed view model
  - `FeedBuilder.swift`: Dependency injection builder
- `FeedDetailsView/`: Character details feature
  - `FeedDetailsView.swift`: Character details view
  - `FeedDetailsViewModel.swift`: Details view model
  - `FeedDetailsBuilder.swift`: Details builder for routing

**Shared Components (root level):**
- ViewModels and their protocols
- Repositories and their protocols
- UseCases and their protocols
- Mocks (prefixed with `Mock`)
- Reusable Views (SwiftUI components like `CarouselView`, `ProductCardView`, `CharacterView`)
- Entities (models like `CharacterResponse`, `FeedEntity`)

Test files are in `NevaTests/` directory.
