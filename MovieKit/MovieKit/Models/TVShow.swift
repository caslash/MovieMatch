//
//  TVShow.swift
//  MovieKit
//
//  Created by Cameron Slash on 7/4/24.
//

import Foundation

public struct TVShow: Watchable {
    public var id               : Int
    public var adult            : Bool?     = nil
    public var backdropPath     : String?   = nil
    public var genreIds         : [Int]?    = []
    public var originCountry    : [String]? = []
    public var originalLanguage : String?   = nil
    public var originalName     : String?   = nil
    public var overview         : String?   = nil
    public var popularity       : Double?   = nil
    public var posterPath       : String?   = nil
    public var releaseDate      : String?   = nil
    public var title            : String?   = nil
    public var voteAverage      : Double?   = nil
    public var voteCount        : Int?      = nil
}

extension TVShow: Decodable {
    enum CodingKeys: String, CodingKey {
      case adult            = "adult"
      case backdropPath     = "backdrop_path"
      case genreIds         = "genre_ids"
      case id               = "id"
      case originCountry    = "origin_country"
      case originalLanguage = "original_language"
      case originalName     = "original_name"
      case overview         = "overview"
      case popularity       = "popularity"
      case posterPath       = "poster_path"
      case releaseDate      = "first_air_date"
      case title            = "name"
      case voteAverage      = "vote_average"
      case voteCount        = "vote_count"
    }

    public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
        
      self.id               = try values.decode(Int.self, forKey: .id)
      self.adult            = try values.decodeIfPresent(Bool.self     , forKey: .adult            )
      self.backdropPath     = try values.decodeIfPresent(String.self   , forKey: .backdropPath     )
      self.genreIds         = try values.decodeIfPresent([Int].self    , forKey: .genreIds         )
      self.originCountry    = try values.decodeIfPresent([String].self , forKey: .originCountry    )
      self.originalLanguage = try values.decodeIfPresent(String.self   , forKey: .originalLanguage )
      self.originalName     = try values.decodeIfPresent(String.self   , forKey: .originalName     )
      self.overview         = try values.decodeIfPresent(String.self   , forKey: .overview         )
      self.popularity       = try values.decodeIfPresent(Double.self   , forKey: .popularity       )
      self.posterPath       = try values.decodeIfPresent(String.self   , forKey: .posterPath       )
      self.releaseDate      = try values.decodeIfPresent(String.self   , forKey: .releaseDate      )
      self.title            = try values.decodeIfPresent(String.self   , forKey: .title            )
      self.voteAverage      = try values.decodeIfPresent(Double.self   , forKey: .voteAverage      )
      self.voteCount        = try values.decodeIfPresent(Int.self      , forKey: .voteCount        )
    }
}
