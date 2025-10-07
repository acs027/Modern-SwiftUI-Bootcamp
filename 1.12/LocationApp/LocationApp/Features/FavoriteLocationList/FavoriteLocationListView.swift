//
//  FavoriteLocationListView.swift
//  LocationApp
//
//  Created by ali cihan on 6.10.2025.
//

import SwiftUI
import SwiftData

struct FavoriteLocationListView: View {
    @Query private var favoriteLocations: [FavoriteLocation]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let function: (_ location: FavoriteLocation) -> Void
    
    var body: some View {
        List {
            Text("Favorite Locations")
                .bold()
                .font(.headline)
            ForEach(favoriteLocations, id:\.id) { favorite in
                Text(favorite.name)
                    .onTapGesture {
                        function(favorite)
                        dismiss()
                    }
            }
            .onDelete(perform: { indexSet in
                deleteFavorites(indexSet: indexSet)
            })
            .navigationTitle("Favorite Locations")
        }
    }
    
    private func deleteFavorites(indexSet: IndexSet) {
        for index in indexSet {
            let favorite = favoriteLocations[index]
            modelContext.delete(favorite)
        }
    }
}

//#Preview {
//    FavoriteLocationListView()
//}
