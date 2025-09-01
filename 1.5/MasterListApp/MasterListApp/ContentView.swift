//
//  ContentView.swift
//  MasterListApp
//
//  Created by ali cihan on 1.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State var movies = [Movie]()
    @State var randomColor: Color = .blue
    
    @State var isMovieDetailShowing = false
    @State var selectedMovie: Movie?
    
    @State var isAddMovieShowing = false
        
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    Section(header: Text("Watched").bold()) {
                        ForEach(movies) { movie in
                            if movie.userWatched {
                                SwipeableRow(
                                    movie: movie,
                                    content: { rowLabel(movie: movie) },
                                    onDelete: {
                                        delete(movie: movie)
                                    },
                                    onWatchToggle:  {
                                        toggleWatch(movie: movie)
                                    }, navigate: {
                                        navigate(to: movie)
                                    }
                                )                            }
                        }
                    }
                    Section(header: Text("Unwatched").bold()) {
                        ForEach(movies) { movie in
                            if !movie.userWatched {
                                SwipeableRow(
                                    movie: movie,
                                    content: { rowLabel(movie: movie) },
                                    onDelete: {
                                        delete(movie: movie)
                                    },
                                    onWatchToggle:  {
                                        toggleWatch(movie: movie)
                                    }, navigate: {
                                        navigate(to: movie)
                                    }
                                )
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isMovieDetailShowing) {
                if let movie = self.selectedMovie  {
                    MovieDetail(movie: movie)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    addMovieButton
                }
            }
            .navigationTitle("Movie List")
            .sheet(isPresented: $isAddMovieShowing) {
                AddMovie(movies: $movies)
                    .presentationDetents([.height(300), .fraction(0.5)])
            }
        }
        .onAppear {
            fetchMovies()
            setRandomColor()
        }
    }
    
    var addMovieButton: some View {
        Button("Add movie", systemImage: "plus.app.fill") {
            isAddMovieShowing = true
        }
    }
    
    func navigate(to movie: Movie) {
        selectedMovie = movie
        isMovieDetailShowing = true
    }
    
    func rowLabel(movie: Movie) -> some View {
        HStack {
            Text(movie.title)
                .bold()
            Spacer()
            Text(movie.rating)
            Image(systemName: "star.fill")
        }
        .frame(height: 50)
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(randomColor.opacity(0.4)))
        .padding(.horizontal)
    }
    
    func delete(movie: Movie){
        
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies.remove(at: index)
        }
    }
    
    func toggleWatch(movie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies[index].userWatched.toggle()
        }
    }
    
    func fetchMovies() {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            print("File couldn't find.")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            var movies = try decoder.decode([Movie].self, from: data)
            for index in movies.indices {
                movies[index].userWatched = movies[index].rank < 5
            }
            self.movies = movies.sorted(by: { $0.rank < $1.rank
            }).filter({ $0.rank < 15 })
            
        } catch {
            print(error.localizedDescription)
        }
    }
        
    func setRandomColor() {
        let color = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
        self.randomColor = color
    }
}

#Preview {
    ContentView()
}
