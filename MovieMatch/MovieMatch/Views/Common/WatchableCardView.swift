//
//  WatchableCardView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 7/4/24.
//

import MovieKit
import SlashKit
import SwiftUI

struct WatchableCardView<Model, Content: View>: View where Model: Watchable {
    private enum Constants {
        static var swipThreshold: CGFloat { 0.25 }
    }
    
    private enum SwipeStatus {
        case like, dislike, none
    }
    
    @State private var isFlipped = false
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: SwipeStatus = .none
    
    private let watchable: Model
    private let onRemove: (_ watchable: Model, _ isLiked: Bool) -> Void
    private let backContent: () -> Content
    
    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(watchable.posterPath!)")) { image in
                if !isFlipped {
                    image
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            Color (
                                swipeStatus == .like ? .green.withAlphaComponent(0.4) :
                                    (swipeStatus == .dislike ? .red.withAlphaComponent(0.4) : .clear)
                            )
                        }
                        .overlay(
                            alignment: swipeStatus == .like ? .topLeading : (swipeStatus == .dislike ? .topTrailing : .top)
                        ) {
                            Image(
                                systemName: swipeStatus == .like ? "hand.thumbsup.circle" :
                                    (swipeStatus == .dislike ? "hand.thumbsdown.circle" : "hand.raised.circle")
                            )
                            .resizable()
                            .imageScale(.large)
                            .frame(width: 32, height: 32)
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(.thinMaterial)
                            .clipShape(Circle())
                            .padding(8)
                            .opacity(swipeStatus == .none ? 0.0 : 1.0)
                        }
                        .cornerRadius(10)
                } else {
                    backContent()
                        .frame(width: 300, height: 450)
                        .background(.thinMaterial)
                        .overlay {
                            Color (
                                swipeStatus == .like ? .green.withAlphaComponent(0.4) :
                                    (swipeStatus == .dislike ? .red.withAlphaComponent(0.4) : .clear)
                            )
                        }
                        .overlay(
                            alignment: swipeStatus == .like ? .topLeading : (swipeStatus == .dislike ? .topTrailing : .top)
                        ) {
                            Image(
                                systemName: swipeStatus == .like ? "hand.thumbsup.circle" :
                                    (swipeStatus == .dislike ? "hand.thumbsdown.circle" : "hand.raised.circle")
                            )
                            .resizable()
                            .imageScale(.large)
                            .frame(width: 32, height: 32)
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(.thinMaterial)
                            .clipShape(Circle())
                            .padding(8)
                            .opacity(swipeStatus == .none ? 0.0 : 1.0)
                        }
                        .cornerRadius(10)
                        .rotation3DEffect(
                            .degrees(180),
                            axis: (x: 0.0, y: 1.0, z: 0.0))
                }
            } placeholder: {
                ProgressView()
            }
            .frame(
                width: proxy.size.width,
                alignment: .center
            )
            .clipped()
            .offset(x: translation.width * (isFlipped ? -1 : 1), y: 0)
            .rotationEffect(
                .degrees(translation.width / proxy.size.width * 25.0 * (isFlipped ? -1 : 1)),
                anchor: .bottom
            )
            .rotation3DEffect(
                .degrees(isFlipped ? 180 : 0),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .gesture(dragGesture(on: proxy))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.isFlipped.toggle()
                }
            }
        }
    }
    
    init(
        _ watchable: Model,
        onRemove: @escaping (_ watchable: Model, _ isLiked: Bool) -> Void = { _, _ in },
        @ViewBuilder backContent: @escaping () -> Content
    ) {
        self.watchable = watchable
        self.onRemove = onRemove
        self.backContent = backContent
    }
    
    private func gestureFraction(
        in geometry: GeometryProxy,
        from gesture: DragGesture.Value
    ) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    private func dragGesture(on geometry: GeometryProxy) -> some Gesture {
        DragGesture()
            .onChanged { value in
                translation = value.translation
                
                switch gestureFraction(in: geometry, from: value) {
                case ...(-Constants.swipThreshold):
                    if swipeStatus != .dislike {
                        withAnimation(.spring()) {
                            swipeStatus = .dislike
                        }
                    }
                case Constants.swipThreshold...:
                    if swipeStatus != .like {
                        withAnimation(.spring()) {
                            swipeStatus = .like
                        }
                    }
                default:
                    if swipeStatus != .none {
                        withAnimation(.spring()) {
                            swipeStatus = .none
                        }
                    }
                }
            }
            .onEnded { value in
                if abs(gestureFraction(in: geometry, from: value)) > Constants.swipThreshold {
                    onRemove(watchable, swipeStatus == .like)
                }
                withAnimation(.spring()) {
                    translation = .zero
                    swipeStatus = .none
                }
            }
    }
}

#Preview("Movie Card", traits: .sizeThatFitsLayout) {
    WatchableCardView(Bundle.main.decode(Movie.self, from: "thedarkknight.json")) { _, _ in
        print("Hello, World")
    } backContent: {
        Text("Movie")
    }
        .frame(height: 450)
}

#Preview("TV Show Card", traits: .sizeThatFitsLayout) {
    WatchableCardView(Bundle.main.decode(TVShow.self, from: "theoffice.json")) {
        Text("TV Show")
    }
        .frame(height: 450)
}
