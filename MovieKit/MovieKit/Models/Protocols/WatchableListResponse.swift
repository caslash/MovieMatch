//
//  WatchableListResponse.swift
//  MovieKit
//
//  Created by Cameron Slash on 7/5/24.
//

import Foundation

public protocol WatchableListResponse: Decodable {
    associatedtype ModelType: Watchable
    
    var page: Int { get }
    var results: [ModelType] { get }
    var totalPages: Int { get }
    var totalResults: Int { get }
}
