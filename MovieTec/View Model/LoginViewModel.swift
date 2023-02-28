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
    var success = false
    
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
        let upDataModel = UploadData(username: username, password: password, request_token: token)
        guard let jsonData = try? JSONEncoder().encode(upDataModel) else {
            print("Error JSON data")
            return
        }
        
        let url = URL(string: Routes.baseURL.rawValue + components.string!)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                if let session = try? JSONDecoder().decode(SessionResponseNoID.self, from: data){
                    self?.success = session.success
                    completion()
                } else {
                    print("Invalid")
                }
            }
        }.resume()
    }
    
    func createSession(token: String, completion: @escaping () ->()) {
        print("token \(token)")
        var components = URLComponents()
        components.path = Routes.sessionIni.rawValue
        components.queryItems = [URLQueryItem(name: "api_key", value: Routes.apiKey.rawValue)]
        let upDataModel = UploadRequest(request_token: token)
        guard let jsonData = try? JSONEncoder().encode(upDataModel) else {
            print("Error JSON data")
            return
        }
        
        let url = URL(string: Routes.baseURL.rawValue + components.string!)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                if let session = try? JSONDecoder().decode(SessionResponse.self, from: data){
                    self?.success = session.success
                    self?.sessionID = session.session_id
                    completion()
                } else {
                    print("Invalid")
                }
            }
        }.resume()
    }
}
