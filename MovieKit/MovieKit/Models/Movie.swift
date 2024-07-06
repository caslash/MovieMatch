//
//  Movie.swift
//  MovieKit
//
//  Created by Cameron Slash on 7/4/24.
//

import Foundation

public struct Movie: Watchable {
    public var id               : Int
    public var adult            : Bool?   = nil
    public var backdropPath     : String? = nil
    public var genreIds         : [Int]?  = []
    public var originalLanguage : String? = nil
    public var originalTitle    : String? = nil
    public var overview         : String? = nil
    public var popularity       : Double? = nil
    public var posterPath       : String? = nil
    public var releaseDate      : String? = nil
    public var title            : String? = nil
    public var video            : Bool?   = nil
    public var voteAverage      : Double? = nil
    public var voteCount        : Int?    = nil
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
      case adult            = "adult"
      case backdropPath     = "backdrop_path"
      case genreIds         = "genre_ids"
      case id               = "id"
      case originalLanguage = "original_language"
      case originalTitle    = "original_title"
      case overview         = "overview"
      case popularity       = "popularity"
      case posterPath       = "poster_path"
      case releaseDate      = "release_date"
      case title            = "title"
      case video            = "video"
      case voteAverage      = "vote_average"
      case voteCount        = "vote_count"
    }

    public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
        
      self.id               = try values.decode(Int.self, forKey: .id)
      self.adult            = try values.decodeIfPresent(Bool.self   , forKey: .adult            )
      self.backdropPath     = try values.decodeIfPresent(String.self , forKey: .backdropPath     )
      self.genreIds         = try values.decodeIfPresent([Int].self  , forKey: .genreIds         )
      self.originalLanguage = try values.decodeIfPresent(String.self , forKey: .originalLanguage )
      self.originalTitle    = try values.decodeIfPresent(String.self , forKey: .originalTitle    )
      self.overview         = try values.decodeIfPresent(String.self , forKey: .overview         )
      self.popularity       = try values.decodeIfPresent(Double.self , forKey: .popularity       )
      self.posterPath       = try values.decodeIfPresent(String.self , forKey: .posterPath       )
      self.releaseDate      = try values.decodeIfPresent(String.self , forKey: .releaseDate      )
      self.title            = try values.decodeIfPresent(String.self , forKey: .title            )
      self.video            = try values.decodeIfPresent(Bool.self   , forKey: .video            )
      self.voteAverage      = try values.decodeIfPresent(Double.self , forKey: .voteAverage      )
      self.voteCount        = try values.decodeIfPresent(Int.self    , forKey: .voteCount        )
    }
}
