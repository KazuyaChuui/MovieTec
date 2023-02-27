//
//  DetailViewModel.swift
//  MovieTec
//
//  Created by Furry Ruiz on 26/02/23.
//

import Foundation

class DetailViewModel {
    var movie: Movie?
    
    func getMovieWith(id: Int, completion: @escaping () ->()) {
        var components = URLComponents()
        components.path = "tv/\(id)"
        components.queryItems = [URLQueryItem(name: "api_key", value: Routes.apiKey.rawValue)]
        let url = URL(string: Routes.baseURL.rawValue + components.string!)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                if let movie = try? JSONDecoder().decode(Movie.self, from: data){
                    self?.movie = movie
                    completion()
                } else {
                    print("Invalid")
                }
            }
        }.resume()
    }
}
