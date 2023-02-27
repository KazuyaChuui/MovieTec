//
//  Movie.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

struct Movie: Codable{
    let id: Int
    let original_title: String
    let poster_Path: String?
    let release_Date: String
    let overview: String
    let vote_average: Int
    let genres: [Genre]
    let status: String

    private enum MovieCodingKeys: String, CodingKey {
        case id
        case original_title
        case poster_Path
        case release_Date
        case overview
        case vote_average
        case genres
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        original_title = try container.decode(String.self, forKey: .original_title)
        poster_Path = try container.decode(String?.self, forKey: .poster_Path)
        release_Date = try container.decode(String.self, forKey: .release_Date)
        overview = try container.decode(String.self, forKey: .overview)
        vote_average = try container.decode(Int.self, forKey: .vote_average)
        genres = try container.decode([Genre].self, forKey: .genres)
        status = try container.decode(String.self, forKey: .status)
    }
}

struct Movies: Codable{
    let id: Int
    let original_title: String
    let poster_Path: String?
    let release_Date: String
    let overview: String
    let vote_average: Int
    
    private enum MoviesCodingKeys: String, CodingKey {
        case id
        case original_title
        case poster_Path
        case release_Date
        case overview
        case vote_average
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MoviesCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        original_title = try container.decode(String.self, forKey: .original_title)
        poster_Path = try container.decode(String?.self, forKey: .poster_Path)
        release_Date = try container.decode(String.self, forKey: .release_Date)
        overview = try container.decode(String.self, forKey: .overview)
        vote_average = try container.decode(Int.self, forKey: .vote_average)
    }
}

struct MoviesCategory: Codable {
    let results: [Movies]
    
    private enum MoviesCategoryCodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MoviesCategoryCodingKeys.self)
        results = try container.decode([Movies].self, forKey: .results)
    }
}


struct Genre: Codable {
    let name: String
    
    private enum GenreCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
}
