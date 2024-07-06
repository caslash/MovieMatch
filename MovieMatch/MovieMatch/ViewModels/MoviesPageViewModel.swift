//
//  MoviesPageViewModel.swift
//  MovieMatch
//
//  Created by Cameron Slash on 7/5/24.
//

import Foundation
import MovieKit
import Observation

@Observable
public class MoviesPageViewModel {
    private var likedMovies: [FavoriteWrapper<Movie>] = []
    private(set) var movies: [Movie] = []
    
    func fetchMovies() async {
        do {
            self.movies = Bundle.main.decode(MoviesResponse.self, from: "moviesresponse.json").results
        }
    }
    
    func didRemove(_ movie: Movie, isLiked: Bool) {
        self.movies.removeAll { $0.id == movie.id }
        if let index = self.likedMovies.firstIndex(where: { $0.model.id == movie.id }) {
            self.likedMovies[index] = FavoriteWrapper(model: movie, isFavorite: isLiked)
        }
    }
}
