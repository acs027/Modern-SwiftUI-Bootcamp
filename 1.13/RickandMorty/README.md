# Rick and Morty iOS App

A SwiftUI-based iOS application that displays characters from the Rick and Morty universe using the [Rick and Morty API](https://rickandmortyapi.com/). Browse characters, view detailed information, and manage your favorites with a clean, modern interface.

## Features

- **Character List**: Browse all Rick and Morty characters with infinite scrolling
- **Search**: Filter while typing and api search on submit.
- **Character Details**: View comprehensive character information including status, species, gender, origin, and location
- **Favorites**: Save and manage your favorite characters locally
- **Pull to Refresh**: Update character data with pull-to-refresh gesture
- **Modern UI**: Clean SwiftUI interface with smooth animations and transitions

## Screenshots

<p align="center">    
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/bbb5b4a5-0592-4307-9817-044080e0cb05" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/f7b1aba1-29ea-429b-8b21-16805f8bf532" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/ad245cb8-50cd-4634-937e-fe4197081039" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/97ac7c3f-7f49-45f7-a202-04511892f58c" />
</p>

## Architecture

The app follows MVVM (Model-View-ViewModel) architecture with a feature-based folder structure:

```
RickandMorty/
├── App/                    # App entry point
├── Features/
│   ├── CharacterList/      # Character listing feature
│   └── CharacterDetail/    # Character detail feature
└── Shared/
    ├── Data/              # Core Data persistence
    ├── Model/             # Data models
    ├── Services/          # API and networking services
    ├── MockData/          # Mock data for testing
    └── Resources/         # Assets and resources
```

### Key Components

- **APIService**: Handles network requests to Rick and Morty API
- **CacheService**: Manages local caching for offline support
- **CharacterListViewModel**: Manages character list state and operations
- **CharacterDetailViewModel**: Handles individual character details
- **Core Data**: Persistent storage for favorites

## Requirements

- iOS 18.0+
- Xcode 16.0+

## Installation

### Clone the repository
```bash
git clone https://github.com/acs027/Modern-SwiftUI-Bootcamp.git
```

### Navigate to specific project
```bash
cd Modern-SwiftUI-Bootcamp/1.11/RickandMorty
```

### Open the project
```bash
open RickandMorty.xcodeproj
```


