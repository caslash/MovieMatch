//
//  ContentView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 3/2/24.
//

import MovieKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("API KEY: \(Secrets.apiKey)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
