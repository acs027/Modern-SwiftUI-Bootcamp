# Pokedex iOS App

A modern SwiftUI-based Pokedex application that allows users to browse, search, and view detailed information about Pokemon using the PokeAPI.

## Features

- **Pokemon List**: Browse through a paginated list of Pokemon with infinite scrolling
- **Search & Suggestions**: Real-time search with intelligent suggestions from a local Pokemon database
- **Pokemon Details**: View comprehensive information including stats, abilities, types, and sprites
- **Modern UI**: Clean, native iOS design using SwiftUI and modern iOS design patterns
- **Offline Support**: Local Pokemon suggestions work without internet connection

<p align="center">    
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/a81a8805-6a02-4ba6-bc29-7b4efb225b0b" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/1252fced-50ba-4d63-b396-e6cad3113f86" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/92c02b89-29ff-4e56-a239-594b4ded82f4" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/07b89c06-6c19-43ca-b766-8b6bbb32705f" />
</p>

## Architecture

The app follows MVVM (Model-View-ViewModel) architecture with a clean separation of concerns:

```
Pokedex/
├── App/                    # App entry point
├── Features/               # Feature-based organization
│   ├── PokemonList/       # List view, viewmodel
│   └── PokemonDetail/     # Detail view and viewmodel
└── Shared/                # Shared components
    ├── Models/            # Data models
    ├── Services/          # Network and business logic
    ├── MockData/          # Test data and mock responses
    └── Resources/         # Assets and local data files
```

### Key Components

#### Models
- **Pokemon**: Complete Pokemon data model with all attributes from PokeAPI
- **PokemonListResponse**: Paginated response model for Pokemon lists
- **PokemonListItem**: Simplified Pokemon model for list display

#### Services
- **NetworkService**: Generic networking layer with async/await support
- **PokemonService**: Pokemon-specific API interactions and data fetching

#### Features
- **PokemonListView**: Main list interface with search and infinite scroll
- **PokemonListViewModel**: Business logic for list management and filtering
- **PokemonDetailView**: Detailed Pokemon information display
- **PokemonDetailViewModel**: Detail view business logic

## Technical Highlights

### Modern SwiftUI Patterns
- Uses `@Observable` macro for reactive state management
- Implements `NavigationStack` for iOS 16+ navigation
- Leverages `AsyncImage` for efficient image loading
- Utilizes `LazyVStack` and `LazyVGrid` for performance optimization

### Search Implementation
- Real-time filtering with `searchable` modifier
- Smart suggestions using local Pokemon database
- Search completion with `searchCompletion`
- Ability to add Pokemon to current list via search

### Networking
- Protocol-based architecture for testability
- Generic networking service supporting any Decodable type
- Proper error handling with custom NetworkError enum
- Async/await pattern for modern concurrency

### Performance Features
- Infinite scrolling with automatic pagination
- Lazy loading of Pokemon images
- Efficient list rendering with LazyVStack
- Local caching of Pokemon suggestions

## API Integration

The app integrates with [PokeAPI](https://pokeapi.co/) for Pokemon data:

- **List Endpoint**: `https://pokeapi.co/api/v2/pokemon/`
- **Detail Endpoint**: `https://pokeapi.co/api/v2/pokemon/{name-or-id}/`
- **Images**: High-quality sprites from Pokemon HOME collection

## Usage

### Browsing Pokemon
- Launch the app to see the initial list of Pokemon
- Scroll down to automatically load more Pokemon
- Tap any Pokemon to view detailed information

### Searching
- Use the search bar to filter the current list
- View suggestions as you type
- Tap a suggestion to add it to your current list
- Submit search to add the exact match to your list

### Pokemon Details
- View Pokemon ID, name, and type information
- See the Pokemon's sprite image
- Browse through all abilities in a grid layout
