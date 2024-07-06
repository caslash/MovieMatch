//
//  TVShowPage.swift
//  MovieMatch
//
//  Created by Cameron Slash on 7/5/24.
//

import SwiftUI

struct TVShowPage: View {
    @State private var viewModel: TVShowPageViewModel = TVShowPageViewModel()
    
    var body: some View {
        NavigationStack {
            WatchableCardStack(watchables: self.viewModel.shows) { show, isLiked in
                self.viewModel.didRemove(show, isLiked: isLiked)
            }
            .navigationTitle("TV")
            .task {
                await self.viewModel.fetchTVShows()
            }
        }
    }
}

#Preview {
    TVShowPage()
}
