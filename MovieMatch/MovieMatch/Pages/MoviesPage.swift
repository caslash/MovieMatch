//
//  MoviesPage.swift
//  MovieMatch
//
//  Created by Cameron Slash on 7/5/24.
//

import SwiftUI

struct MoviesPage: View {
    @State private var viewModel: MoviesPageViewModel = MoviesPageViewModel()

    var body: some View {
        NavigationStack {
            WatchableCardStack(watchables: self.viewModel.movies) { movie, isLiked in
                self.viewModel.didRemove(movie, isLiked: isLiked)
            }
            .navigationTitle("Movies")
            .task {
                await self.viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    MoviesPage()
}
