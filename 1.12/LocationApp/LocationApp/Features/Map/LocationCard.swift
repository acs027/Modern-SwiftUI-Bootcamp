//
//  LocationCard.swift
//  LocationApp
//
//  Created by ali cihan on 12.10.2025.
//

import SwiftUI
import CoreLocation

struct LocationCard: View {
    let location: CLLocationCoordinate2D
    let userAddress: String
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Text("Latitude: ")
                .bold()
            Text("\(location.latitude)")
            Text("Longitude: ")
                .bold()
            Text("\(location.longitude)")
            Text("Address: ")
                .bold()
            Text(userAddress)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .frame(width: 200)
    }
}

#Preview {
    let location = CLLocationCoordinate2D(latitude: 1, longitude: 1)
    let userAddress = "Lorem Ipsum"
    LocationCard(location: location, userAddress: userAddress)
        .padding()
}
