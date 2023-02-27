//
//  MoviesViewModel.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

import UIKit

class MoviesViewModel {
    var movieList: [Movies]?
    
    func getMovies(type: String, completion: @escaping () ->()) {
        var components = URLComponents()
        components.path = "tv/\(type)"
        components.queryItems = [URLQueryItem(name: "api_key", value: Routes.apiKey.rawValue)]
        let url = URL(string: Routes.baseURL.rawValue + components.string!)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                if let movieList = try? JSONDecoder().decode(MoviesCategory.self, from: data){
                    self?.movieList = movieList.results
                    completion()
                } else {
                    print("Invalid")
                }
            }
        }.resume()
    }
    
    
}
