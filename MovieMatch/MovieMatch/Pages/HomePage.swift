//
//  HomePage.swift
//  MovieMatch
//
//  Created by Cameron Slash on 7/4/24.
//

import SwiftUI

struct HomePage: View {
    enum Tabs: Equatable, Hashable {
        case tv, movie, settings
    }
    
    @State private var selectedTab: Tabs = .movie
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("TV Shows", systemImage: "tv", value: .tv) {
                TVShowPage()
            }
            
            Tab("Movies", systemImage: "movieclapper", value: .movie) {
                MoviesPage()
            }
            
            Tab("Settings", systemImage: "gear", value: .settings) {
                Text("Settings")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    HomePage()
}
