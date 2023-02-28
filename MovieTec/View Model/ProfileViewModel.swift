//
//  ProfileViewModel.swift
//  MovieTec
//
//  Created by Furry Ruiz on 25/02/23.
//

import UIKit

class ProfileViewModel {
    var account: Account?
    
    func getAccountInfo(completion: @escaping () ->()) {
        let sessionId = UserDefaults.standard.value(forKey: "sessionID")
        var components = URLComponents()
        components.path = "account"
        components.queryItems = [URLQueryItem(name: "api_key", value: Routes.apiKey.rawValue), URLQueryItem(name: "session_id", value: "\(sessionId!)")]
        let url = URL(string: Routes.baseURL.rawValue + components.string!)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                if let account = try? JSONDecoder().decode(Account.self, from: data){
                    self?.account = account
                    completion()
                } else {
                    print("Invalid")
                }
            }
            
        }.resume()
    }
}
