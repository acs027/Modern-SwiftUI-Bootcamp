//
//  CharacterListViewModel.swift
//  RickandMorty
//
//  Created by ali cihan on 22.09.2025.
//

import Foundation
import Observation
import CoreData

@Observable
final class CharacterListViewModel {
    private let apiService: APIServiceProtocol
    private let dataService = PersistenceController.shared
    
    private(set) var charactersSet: Set<RMCharacter> = []
    var isAlertShowing: Bool = false
    var errorMessage: String? {
        didSet {
            isAlertShowing.toggle()
        }
    }
    var isLoading: Bool = false
    var nextPageURL: URL?
    var searchText: String = ""
    var characters: [RMCharacter] {
        if searchText.isEmpty {
            return charactersSet
                .sorted {
                $0.id < $1.id
            }
        }
        return charactersSet.filter({
            $0.name.localizedCaseInsensitiveContains(searchText)
        })
            .sorted {
            $0.id < $1.id
        }
    }
    
    var favorites: [Int] = []
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func loadFavorites() {
           let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        let context = dataService.container.viewContext
           if let results = try? context.fetch(request) {
               self.favorites = results.map { Int($0.id) }
           }
       }
    
    func fetchCharacters() async {
        isLoading = true
        await apiService.fetchCharacters { result in
            switch result {
            case .success(let response):
                self.charactersSet = Set(response.results)
                if let url = URL(string: response.info.next ?? "") {
                    self.nextPageURL = url
                }
                self.isLoading = false
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func fetchCharactersPage() async {
        isLoading = true
        await apiService.fetchCharactersPage(url: nextPageURL) { result in
            switch result {
            case .success(let response):
                self.charactersSet.formUnion(response.results)
                self.nextPageURL = URL(string: response.info.next ?? "")
                self.isLoading = false
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func fetchMissingFavoriteCharacters() async {
        let charIds = characters.map { $0.id }
        let ids = favorites.filter { id in
            !charIds.contains(id)
        }
        isLoading = true
        await apiService.fetchCharacters(by: ids) { result in
            switch result {
            case .success(let response):
                self.charactersSet.formUnion(response)
                self.isLoading = false
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func searchCharacter() async {
        let filter = CharacterFilter.name(searchText)
        isLoading = true
        await apiService.fetchCharacters(filters: [filter]) { result in
            switch result {
            case .success(let response):
                debugPrint(response.results)
                self.charactersSet.formUnion(response.results)
                self.isLoading = false
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func toggleFavorite(id: Int) {
        if isFavoriteCharacter(id: id) {
            dataService.removeFavorite(id: id)
        } else {
            dataService.addFavorite(id: id)
        }
        loadFavorites()
    }
    
    
    func fetchCharactersFromMockData() {
        let characters = MockDataService.fetchMockCharacters()
        charactersSet.formUnion(charactersSet)
    }
    
    func isFavoriteCharacter(id: Int) -> Bool {
        favorites.contains(where: {$0 == id})
    }
}

