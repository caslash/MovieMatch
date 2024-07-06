//
//  TVShowPageViewModel.swift
//  MovieMatch
//
//  Created by Cameron Slash on 7/5/24.
//

import Foundation
import MovieKit
import Observation

@Observable
public class TVShowPageViewModel {
    private var likedShows: [FavoriteWrapper<TVShow>] = []
    private(set) var shows: [TVShow] = []
    
    func fetchTVShows() async {
        do {
            self.shows = Bundle.main.decode(TVShowsResponse.self, from: "tvshowresponse.json").results
        }
    }
    
    func didRemove(_ show: TVShow, isLiked: Bool) {
        self.shows.removeAll { $0.id == show.id }
        if let index = self.likedShows.firstIndex(where: { $0.model.id == show.id }) {
            self.likedShows[index] = FavoriteWrapper(model: show, isFavorite: isLiked)
        }
    }
}
