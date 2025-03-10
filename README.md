# Book Explorer

An iOS application that allows users to search for books by author and view their details. Built with SwiftUI and The Composable Architecture (TCA).

## Features

- Search for books by author name
- View a list of books matching the search criteria (only Czech language books)
- See book details including cover image, title, author, description, and publication year
- Open books directly in the Google Play Store

## Screenshots

### Initial
| Light | Dark |
| ------ | ------ |
| <img src="https://github.com/user-attachments/assets/cb7d3d94-887e-4738-a310-b1141bc00658" width="340"/> | <img src="https://github.com/user-attachments/assets/e4367590-72ba-4a75-a4c0-6b857edd79dc" width="340"/> |

### No Results
| Light | Dark |
| ------ | ------ |
| <img src="https://github.com/user-attachments/assets/b60ed609-0ec3-4650-b801-94e671cec8ea" width="340"/> | <img src="https://github.com/user-attachments/assets/a9730d3f-272f-449d-a46e-0b6c476d6810" width="340"/> |


### List

| Light | Dark |
| ------ | ------ |
| <img src="https://github.com/user-attachments/assets/08327e86-37d2-4e49-be7f-e635c1855e05" width="340"/> | <img src="https://github.com/user-attachments/assets/685a4943-38ba-416d-9fc0-5b3a1bb9848d" width="340"/> |

### Detail

| Light | Dark |
| ------ | ------ |
| <img src="https://github.com/user-attachments/assets/a60f47f6-c97f-4c68-bbf4-ecbcb40472c1" width="340"/> | <img src="https://github.com/user-attachments/assets/b709797c-8e4c-451c-a913-767b43453668" width="340"/> |

## Technology Stack

- SwiftUI for the UI
- Minimum iOS target: 18.0
- The Composable Architecture (TCA) for state management and business logic
- Google Books API for data
- Localization support (English and Czech)
- Custom app icon and book icons created with Adobe Fresco and Adobe Illustrator

## Project Structure

The project follows The Composable Architecture principles, organized into the following components:

### App
- `BookExplorerApp.swift` - Application entry point with TCA Store setup
- `AppFeature.swift` - Root feature containing the application state

### Features
- Book
  - `BookListFeature.swift` - State, actions, and reducer for book listing 
  - `BookDetailFeature.swift` - State, actions, and reducer for book details

### Core
- Clients
  - `BookClient.swift` - Interface for book data access
  - `BookClient+Live.swift` - Live implementation for API integration
  - `BookClient+Test.swift` - Test implementations for previews and tests
- Network
  - `HTTPClient.swift` - Base network client
  - `HTTPClient+Live.swift` - Live implementation
  - `HTTPClient+Test.swift` - Test implementations

### Models
- `Book.swift` - Domain model
- DTOs
  - `VolumeDTO.swift` - Data transfer objects for Book/Volume data
  - `VolumesResponseDTO.swift` - Response object for API

### UI
- Components
  - `BookCellView.swift` - Reusable cell for book list
  - `BookThumbnailView.swift` - Book thumbnail component

### Utilities
- Configuration
  - `Config.xcconfig` - Contains BOOK API URL
- Extensions

## Architecture Overview

The application is built using The Composable Architecture, which provides a consistent approach to state management, side effects, and UI updates:

1. **State**: Each feature has its own state that represents all the data needed for rendering UI and processing logic.
2. **Action**: Defines all possible events that can happen in a feature.
3. **Reducer**: Contains logic for handling actions, updating state, and managing side effects.
4. **View**: UI components that read from the store and send actions.

### Key TCA Concepts Used

- **Store**: Central source of truth that holds state and processes actions
- **Feature**: Modular units containing related state, actions, and reducer logic
- **Dependencies**: External services (BookClient, HTTPClient) injected via TCA's dependency system
- **Effects**: Asynchronous operations like API calls handled as TCA effects

## Navigation

The app uses TCA's `NavigationStackStore` with `StackState` for navigation between screens, combined with SwiftUI's `navigationTransition(.zoom)` for elegant transitions.

## Setup & Installation

1. Clone the repository
2. Open the project in Xcode
3. Build and run the application

## Refactor Time

0.5 MD

## Requirements

- iOS 18.0+
- Xcode 16.0+
- Swift 5.9+
- The Composable Architecture 1.8.0+

## Future Improvements

- Add more filtering options beyond author name
- Implement caching for offline use
- Add pagination for large result sets
- Migrate to `@ObservableState` for a more modern approach to SwiftUI integration

## Notes

This project demonstrates how to implement a clean, maintainable iOS application using The Composable Architecture. It showcases key TCA patterns like state management, dependency injection, and effect handling, all while maintaining a smooth and responsive user experience.
