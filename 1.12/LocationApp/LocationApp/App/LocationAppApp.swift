//
//  LocationAppApp.swift
//  LocationApp
//
//  Created by ali cihan on 5.10.2025.
//

import SwiftUI
import MapKit
import SwiftData

@main
struct LocationAppApp: App {
    @StateObject var locationManager: LocationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            MapView(locationManager: locationManager)
                .onAppear {
                    locationManager.requestPermission()
                }
        }
        .modelContainer(for: FavoriteLocation.self)
    }
}
