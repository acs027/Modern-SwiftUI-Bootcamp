//
//  MapView.swift
//  LocationApp
//
//  Created by ali cihan on 5.10.2025.
//

import SwiftUI
import MapKit
import SwiftData
import Combine


struct MapView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteLocation]
    @ObservedObject var locationManager: LocationManager
    @State var cameraPosition: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    @State var route: MKRoute?
    @State var address: String?
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    @State private var selectedFavoriteLocation: FavoriteLocation?
    
    @State var isFavoriteListShowing: Bool = false
    @State private var isManualMarker: Bool = false
    
    @State private var lastGeocodeTime: Date? = nil
    @State private var userAddress = ""
    
    private var offset: CGFloat {
        if selectedCoordinate != nil {
            0
        } else {
            200
        }
    }
    
    var body: some View {
        NavigationStack {
            mapContent
                .safeAreaInset(edge: .bottom) {
                    isManualMarkerToggleButton
                }
                .toolbar {
                    toolbarButton
                }
                .sheet(isPresented: $isFavoriteListShowing) {
                    FavoriteLocationListView() { location in
                        focusToFavoriteLocation(location: location)
                    }
                }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("OpenFavoritesIntent"))) { _ in
            isFavoriteListShowing = true
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ShowClosestIntent"))) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                findAndFocusClosestFavorite()
            }
        }
        .onChange(of: selectedFavoriteLocation) { oldValue, newValue in
            Task {
                if let route = await MapHelper.fetchRoute(from: locationManager.userLocation, to: newValue?.coordinate) {
                    self.route = route
                }
            }
        }
        .onChange(of: cameraPosition) { oldValue, newValue in
            cooldownForAddress()
        }
    }
    
    // MARK: View Components
    private var mapContent: some View {
        MapReader { proxy in
            Map(position: $cameraPosition, selection: $selectedFavoriteLocation) {
                UserAnnotation()
                favoriteLocations
                if let selectedCoordinate {
                    Marker(coordinate: selectedCoordinate) {
                        Label(address ?? "", systemImage: "star")
                    }
                }
                
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 4)
                }
            }
            .overlay(
                ZStack(alignment: .bottomTrailing) {
                    viewOverlay(proxy: proxy)
                    saveToFavoriteButton
                }
                    .overlay {
                        userLocationText
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
            )
            .mapControls {
                MapCompass()
                MapUserLocationButton()
            }
        }
    }
    
    @ViewBuilder
    private var userLocationText: some View {
        if let location = locationManager.userLocation {
            LocationCard(location: location, userAddress: userAddress)
        }
    }
    
    private var favoriteLocations: some MapContent {
        ForEach(favorites, id: \.id) { favorite in
            Annotation(favorite.name, coordinate: favorite.coordinate) {
                VStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.brown)
                        .font(.title2)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.brown, lineWidth: 2))
                }
            }
            .tag(favorite)
        }
    }
    
    private var isManualMarkerToggleButton: some View {
        VStack {
            Toggle(isOn: $isManualMarker) {
                Label("Marker placement: \(isManualMarker ? "ON" : "OFF")",
                      systemImage: isManualMarker ? "mappin.circle" : "mappin.slash.circle")
            }
            .fontWeight(.bold)
            .toggleStyle(.button)
            .background(.ultraThinMaterial)
        }
        .padding()
    }
    
    private var addressLabel: some View {
        VStack {
            Text(address ?? "")
                .fontWeight(.bold)
                .toggleStyle(.button)
                .background(.ultraThinMaterial)
        }
        .padding()
    }
    
    private var saveToFavoriteButton: some View {
        Button("Save to favorites", systemImage: "star") {
            saveToTheFavorites()
        }
        .buttonStyle(GlassButtonStyle())
        .padding()
        .offset(x: offset)
        .animation(.easeInOut, value: offset)
    }
    
    private var toolbarButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                isFavoriteListShowing.toggle()
            } label : {
                Label("Favorites", systemImage: "star.fill")
            }
        }
    }
    
    private func viewOverlay(proxy: MapProxy) -> some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    setAddress(from: coordinate)
                }
            }
            .allowsHitTesting(isManualMarker)
    }
    
    // MARK: Functions
    private func saveToTheFavorites() {
        if let selectedCoordinate,
           let address {
            let newFavorite = FavoriteLocation(name: address, latitude: selectedCoordinate.latitude, longitude: selectedCoordinate.longitude, category: "Favorite")
            modelContext.insert(newFavorite)
            self.selectedCoordinate = nil
            self.address = nil
        }
    }
    
    private func findAndFocusClosestFavorite() {
        guard let closestLocation = MapHelper.findClosestFavoriteLocation(favoriteLocations: favorites, userLocation: locationManager.userLocation) else { return }
        cameraPosition = .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: closestLocation.latitude, longitude: closestLocation.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }
    
    private func focusToFavoriteLocation(location: FavoriteLocation) {
        cameraPosition = .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }
    
    private func setAddress(from coordinate: CLLocationCoordinate2D?) {
        if let coordinate {
            self.selectedCoordinate = coordinate
            Task {
                self.address = try await MapHelper.reverseGeocodeAsync(lat: coordinate.latitude, lon: coordinate.longitude)
            }
        }
    }
    
    private func cooldownForAddress() {
        let now = Date()
        if let last = lastGeocodeTime, now.timeIntervalSince(last) < 15 {
            print(last)
            return
        }
        lastGeocodeTime = now
        getAddress(from: locationManager.userLocation)
    }
    
    private func getAddress(from coordinate: CLLocationCoordinate2D?) {
        if let coordinate {
            Task {
                guard let text = try await MapHelper.reverseGeocodeAsync(lat: coordinate.latitude, lon: coordinate.longitude) else { return }
                userAddress = text
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var locationManager = LocationManager()
    MapView(locationManager: locationManager)
}
