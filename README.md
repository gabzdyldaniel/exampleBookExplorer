# Book Explorer

An iOS application that allows users to search for books by author and view their details. Built with SwiftUI, utilizing Clean Architecture and MVVM.

## Features

- Search for books by author name
- View a list of books matching the search criteria (only Czech language books)
- See book details including cover image, title, author, description, and publication year
- Open books directly in the Google Play Store

## Screenshots

[Screenshots to be added]

## Technology Stack

- SwiftUI for the UI
- Minimum iOS target: 18.0
- Clean Architecture with MVVM presentation pattern
- Swinject for dependency injection
- Google Books API for data
- Localization support (English and Czech)
- Custom app icon and book icons created with Adobe Fresco and Adobe Illustrator

## Project Structure

The project follows Clean Architecture principles, organized into the following layers:

### Presentation
- Book
  - Views (BookCellView, BookDetailView, BookListView, etc.)
  - ViewModels

### Domain
- Book
  - Entity (Book.swift)
  - UseCase (GetBooksUseCase)

### Data
- Volume
  - DataSource
    - VolumeDataSource interfaces and implementations (Mock, Remote)
  - DTO
    - Data transfer objects for Book/Volume data

### Core
- Assembly - Dependency registration
- Extensions - Utility extensions
- Network - HTTP client implementation
- Protocols - Shared interfaces

### Configuration
- Config.xcconfig - Contains BOOK API URL

## Architecture Overview

The application is built using Clean Architecture principles, which separates concerns into distinct layers:

1. **Presentation Layer**: Contains UI components (views) and view models
2. **Domain Layer**: Contains business logic, use cases, and domain entities
3. **Data Layer**: Handles data operations and external API communication

The Repository layer was intentionally omitted (YAGNI principle).

## Navigation

The app uses the new SwiftUI `navigationTransition(.zoom)` for transitions between screens.

## Setup & Installation

1. Clone the repository
2. Open the project in Xcode
3. Build and run the application

## Testing

The project includes unit tests for the `GetBooks` use case. Run tests using Xcode's testing framework.

## Development Time

1 MD

## Requirements

- iOS 18.0+
- Xcode 16.0+
- Swift 5.9+

## Future Improvements

- Add more filtering options beyond author name
- Implement caching for offline use
- Add pagination for large result sets

## Notes

This project was developed as a coding task for an interview process. It demonstrates clean code structure, modern iOS development practices, and effective use of the Google Books API.
