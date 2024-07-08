//
//  Watchable.swift
//  MovieKit
//
//  Created by Cameron Slash on 7/4/24.
//

import Foundation

public protocol Watchable: Identifiable, Decodable, Equatable {
    var id: Int { get }
    var title: String? { get }
    var releaseDate: Date? { get }
    var posterPath: String? { get }
    var overview: String? { get }
}
