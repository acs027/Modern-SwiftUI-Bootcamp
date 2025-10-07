# LocationApp

A modern SwiftUI sample demonstrating MapKit, SwiftData, CoreLocation, and App Intents. The app allows users to place a marker on the map, reverse‑geocode it into a readable address, save it as a favorite, view/manage favorites, and navigate to the closest favorite from the current location. It also exposes Siri/App Shortcuts for quick actions.

## Features
- Map experience using MapKit with `Map`, `MapReader`, `UserAnnotation`, `MapPolyline`, and camera control
- Live user location via `CoreLocation` and a lightweight `LocationManager`
- Reverse‑geocoding to address strings with async/await
- Save, list, and delete favorite locations using SwiftData (`@Model`, `@Query`)
- Draw walking route from current location to a selected favorite
- Toggle to enable manual marker placement by tapping the map
- Bottom CTA to save the selected coordinate as a favorite
- Favorite list presented as a sheet with tap‑to‑focus behavior
- App Intents / App Shortcuts:
  - “Open Favorite Locations”
  - “Show Closest Favorite Location” (focuses the nearest saved favorite)

## Tech Stack
- SwiftUI
- MapKit
- CoreLocation
- SwiftData
- AppIntents

## Using the App
- Toggle “Marker placement” ON and tap the map to drop a marker
- The address appears at the top after reverse‑geocoding completes
- Tap “Save to favorites” to persist
- Open the favorites sheet from the toolbar star button; tap a favorite to focus
- Selecting a favorite draws a walking route from your current location

## Siri/App Shortcuts
- “Open Favorite Locations” → opens the favorites sheet
- “Show Closest Favorite Location” → centers the map on the nearest saved favorite

