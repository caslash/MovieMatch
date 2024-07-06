//
//  WatchableCardStack.swift
//  MovieMatch
//
//  Created by Cameron Slash on 7/5/24.
//

import MovieKit
import SwiftUI

struct WatchableCardStack<Model>: View where Model: Watchable {
    let watchables: [Model]
    let onRemove: (_ watchable: Model, _ isLiked: Bool) -> Void
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(
                    Array(self.watchables.reversed().enumerated()),
                    id: \.element.id
                ) { index, watchable in
                    if (self.watchables.reversed().count - 3)...self.watchables.reversed().count ~= index {
                        WatchableCardView(watchable) { watchable, isLiked in
                            withAnimation(.spring()) {
                                onRemove(watchable, isLiked)
                            }
                        } backContent: {
                            Text(watchable.title ?? "Untitled")
                        }
                        .frame(
                            width: cardWidth(in: proxy, index: index),
                            height: Constants.cardHeight
                        )
                        .offset(x: 0, y: cardOffset(in: proxy, index: index))
                        .disabled(index != self.watchables.reversed().count - 1)
                    }
                }
            }
            .frame(width: proxy.size.width, alignment: .center)
        }
        .frame(height: Constants.cardHeight + 16.0)
        .transition(.scale)
        .padding(.horizontal)
        .shadow(radius: 10)
    }
    
    private func cardWidth(in geometry: GeometryProxy, index: Int) -> CGFloat? {
        let offset = cardOffset(in: geometry, index: index)
        
        let addedValue: CGFloat
        if geometry.size.width > 1536 {
            addedValue = 700
        } else if geometry.size.width > 1024 {
            addedValue = 400
        } else if geometry.size.width > 512 {
            addedValue = 100
        } else {
            addedValue = 0
        }
        
        let result = geometry.size.width - offset - addedValue
        
        if result <= 0 {
            return nil
        }
        return result
    }
    
    private func cardOffset(in geometry: GeometryProxy, index: Int) -> CGFloat {
        CGFloat(self.watchables.count - 1 - index) * 12
    }
}

private enum Constants {
    static let cardHeight: CGFloat = 450
}

#Preview("Movies Stack") {
    WatchableCardStack(watchables: Bundle.main.decode(MoviesResponse.self, from: "moviesresponse.json").results) { movie, isLiked in
        
    }
}

#Preview("TV Stack") {
    WatchableCardStack(watchables: Bundle.main.decode(TVShowsResponse.self, from: "tvshowresponse.json").results) { show, isLiked in
        
    }
}
