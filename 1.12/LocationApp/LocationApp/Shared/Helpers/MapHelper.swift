//
//  ReverseGeocode.swift
//  LocationApp
//
//  Created by ali cihan on 6.10.2025.
//

import Foundation
import MapKit


struct MapHelper {
    
    static func fetchRoute(from start: CLLocationCoordinate2D?, to end: CLLocationCoordinate2D?) async -> MKRoute? {
        guard let start = start,
              let end = end else { return nil }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        
        do {
           let response = try await directions.calculate()
            let route = response.routes.first
            return route
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func reverseGeocodeAsync(lat: Double, lon: Double) async throws -> String? {
        let location = CLLocation(latitude: lat, longitude: lon)
        return try await withCheckedThrowingContinuation { cont in
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if let error = error { cont.resume(throwing: error); return }
                guard let p = placemarks?.first else { cont.resume(returning: nil); return }
                let lines = [
                    p.name,
                    p.thoroughfare,
                    p.subThoroughfare,
                    p.locality,
                    p.administrativeArea,
                    p.postalCode,
                    p.country
                ].compactMap { $0 }
                cont.resume(returning: lines.joined(separator: ", "))
            }
        }
    }
    
    static func findClosestFavoriteLocation(favoriteLocations: [FavoriteLocation], userLocation: CLLocationCoordinate2D?) -> FavoriteLocation? {
        guard !favoriteLocations.isEmpty else { return nil }
        guard let location = userLocation else { return nil }
        let userCLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        let closestLocation = favoriteLocations.min{ first, second in
            let firstDistance = CLLocation(latitude: first.latitude, longitude: first.longitude).distance(from: userCLLocation)
            let secondDistance = CLLocation(latitude: second.latitude, longitude: second.longitude).distance(from: userCLLocation)
            return firstDistance < secondDistance
        }
        
        return closestLocation
    }
}

