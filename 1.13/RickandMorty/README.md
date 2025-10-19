# Rick and Morty iOS App

A SwiftUI-based iOS application that displays characters from the Rick and Morty universe using the [Rick and Morty API](https://rickandmortyapi.com/). Browse characters, view detailed information, and manage your favorites with a clean, modern interface.

## Features

- **Character List**: Browse all Rick and Morty characters with infinite scrolling
- **Search**: Filter while typing and api search on submit.
- **Character Details**: View comprehensive character information including status, species, gender, origin, and location
- **Favorites**: Save and manage your favorite characters locally
- **Pull to Refresh**: Update character data with pull-to-refresh gesture
- **Modern UI**: Clean SwiftUI interface with smooth animations and transitions
- **iOS Widget**: Home screen widget displaying random favorite characters with time/date
- **Interactive Widget**: Tap to switch between favorite characters

## Widget Features

### Home Screen Widget
- **Multiple Sizes**: Supports small, medium, and large widget sizes
- **Character Backgrounds**: Displays random favorite characters as background images
- **Time Display**: Shows current time and day of the week
- **Interactive**: Tap the refresh button to switch to a different favorite character
- **Auto-Update**: Updates every hour with new character data


## Screenshots

<p align="center">    
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/bbb5b4a5-0592-4307-9817-044080e0cb05" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/f7b1aba1-29ea-429b-8b21-16805f8bf532" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/ad245cb8-50cd-4634-937e-fe4197081039" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/97ac7c3f-7f49-45f7-a202-04511892f58c" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/96d37b2c-66b6-4047-9ce2-17dc7b59b7d3" />
<img width="300" alt="Image" src="https://github.com/user-attachments/assets/7ac843e3-1dce-46cd-82fc-9e87cce8b86a" />
</p>

### Key Components

- **APIService**: Handles network requests to Rick and Morty API
- **CacheService**: Manages local caching for offline support
- **CharacterListViewModel**: Manages character list state and operations
- **CharacterDetailViewModel**: Handles individual character details
- **Swift Data**: Persistent storage for favorites
- **RickandMortyWidget**: Home screen widget with character backgrounds and time display
- **CharacterLiveActivity**: Live Activity for Dynamic Island and Lock Screen
- **WidgetAPIService**: Dedicated API service for widget data fetching
- **SwitchCharacterIntent**: App Intent for interactive widget character switching


## Requirements

- iOS 18.0+
- Xcode 16.0+


