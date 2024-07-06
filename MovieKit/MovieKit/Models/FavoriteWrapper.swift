//
//  FavoriteWrapper.swift
//  MovieKit
//
//  Created by Cameron Slash on 7/5/24.
//

import Foundation

public struct FavoriteWrapper<T> {
    public let model: T
    public var isFavorite: Bool?
    
    public init(model: T, isFavorite: Bool? = nil) {
        self.model = model
        self.isFavorite = isFavorite
    }
}
