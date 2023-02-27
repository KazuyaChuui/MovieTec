//
//  LoginViewModel.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

import UIKit
import Combine

class LoginViewModel {
    
    var token = ""
    var sessionID = ""
    
    func createRequestToken(completion: @escaping () ->()) {
        var components = URLComponents()
        components.path = Routes.createToken.rawValue
        components.queryItems = [URLQueryItem(name: "api_key", value: Routes.apiKey.rawValue)]
        let url = URL(string: Routes.baseURL.rawValue + components.string!)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                if let token = try? JSONDecoder().decode(AuthenticationToken.self, from: data){
                    self?.token = token.request_token
                    completion()
                } else {
                    print("Invalid")
                }
            }
            
        }.resume()
    }
    
    func createSessionWithLogin(username: String, password: String, token: String, completion: @escaping () ->()) {
        var components = URLComponents()
        components.path = Routes.sessionLogin.rawValue
        components.queryItems = [URLQueryItem(name: "api_key", value: Routes.apiKey.rawValue)]
        let body = ["username":username, "password":password, "request_token":token]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        let url = URL(string: Routes.baseURL.rawValue + components.string!)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print(token)

        URLSession.shared.uploadTask(with: request, from: bodyData) {[weak self] data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                if let session = try? JSONDecoder().decode(SessionResponse.self, from: data){
                    self?.sessionID = session.session_id
                    completion()
                } else {
                    print("Invalid")
                }
            }
        }.resume()
    }
    
    func createSession(token: String, completion: @escaping () ->()) {
        var components = URLComponents()
        components.path = Routes.sessionIni.rawValue
        components.queryItems = [URLQueryItem(name: "api_key", value: Routes.apiKey.rawValue)]
        let body = ["request_token":token]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        let url = URL(string: Routes.baseURL.rawValue + components.string!)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        URLSession.shared.uploadTask(with: request, from: bodyData) {[weak self] data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                if let session = try? JSONDecoder().decode(SessionResponse.self, from: data){
                    if(session.success) {
                        self?.sessionID = session.session_id
                        completion()
                    } else {
                        self?.sessionID = ""
                    }
                } else {
                    //print(response)
                    print("Invalid")
                }
            }
        }.resume()
    }
}
