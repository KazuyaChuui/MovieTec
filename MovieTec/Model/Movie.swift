//
//  Movie.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

struct Movie: Codable{
    let id: Int
    let original_name: String
    let poster_path: String?
    let first_air_date: String
    let overview: String
    let vote_average: Float
    let genres: [Genre]
    let status: String
    let production_companies: [productionCompanies]
    
    private enum MovieCodingKeys: String, CodingKey {
        case id
        case original_name
        case poster_path
        case first_air_date
        case overview
        case vote_average
        case genres
        case status
        case production_companies
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        original_name = try container.decode(String.self, forKey: .original_name)
        poster_path = try container.decode(String?.self, forKey: .poster_path)
        first_air_date = try container.decode(String.self, forKey: .first_air_date)
        overview = try container.decode(String.self, forKey: .overview)
        vote_average = try container.decode(Float.self, forKey: .vote_average)
        genres = try container.decode([Genre].self, forKey: .genres)
        status = try container.decode(String.self, forKey: .status)
        production_companies = try container.decode([productionCompanies].self, forKey: .production_companies)
    }
}

struct productionCompanies: Codable {
    let logo_path: String?
    
    private enum productionCompaniesCodingKeys: String, CodingKey {
        case logo_path
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: productionCompaniesCodingKeys.self)
        logo_path = try container.decode(String?.self, forKey: .logo_path)
    }
}

struct Movies: Codable{
    let id: Int
    let original_name: String
    let poster_path: String?
    let first_air_date: String
    let overview: String
    let vote_average: Float
    
    private enum MoviesCodingKeys: String, CodingKey {
        case id
        case original_name
        case poster_path
        case first_air_date
        case overview
        case vote_average
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MoviesCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        original_name = try container.decode(String.self, forKey: .original_name)
        poster_path = try container.decode(String?.self, forKey: .poster_path)
        first_air_date = try container.decode(String.self, forKey: .first_air_date)
        overview = try container.decode(String.self, forKey: .overview)
        vote_average = try container.decode(Float.self, forKey: .vote_average)
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
