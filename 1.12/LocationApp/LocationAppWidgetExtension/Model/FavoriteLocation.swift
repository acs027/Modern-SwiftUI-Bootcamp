//
//  FavoriteLocation.swift
//  LocationAppWidgetExtensionExtension
//
//  Created by ali cihan on 10.10.2025.
//

import SwiftData
import CoreLocation

@Model
final class FavoriteLocation: Identifiable {
    var id: UUID
    var name: String
    var latitude: Double
    var longitude: Double
    var category: String

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(id: UUID, name: String, latitude: Double, longitude: Double, category: String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
    }
    
    
    init(name: String, latitude: Double, longitude: Double, category: String) {
        self.id = UUID()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
    }
}

extension FavoriteLocation {
    static let mock = FavoriteLocation(id: UUID(), name: "Unknown", latitude: 100, longitude: 100, category: "City")
}
