//
//  TVShowsResponse.swift
//  MovieKit
//
//  Created by Cameron Slash on 7/5/24.
//

import Foundation

public struct TVShowsResponse: WatchableListResponse {
    public var page: Int
    public var results: [TVShow]
    public var totalPages: Int
    public var totalResults: Int
}

extension TVShowsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case page, results, totalPages = "total_pages", totalResults = "total_results"
    }
    
    public init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.page = try values.decode(Int.self, forKey: .page)
        self.results = try values.decode([TVShow].self, forKey: .results)
        self.totalPages = try values.decode(Int.self, forKey: .totalPages)
        self.totalResults = try values.decode(Int.self, forKey: .totalResults)
    }
}
