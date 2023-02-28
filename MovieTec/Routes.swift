//
//  Routes.swift
//  MovieTec
//
//  Created by Furry Ruiz on 26/02/23.
//
import UIKit

public enum Routes: String {
    case baseURL = "https://api.themoviedb.org/3/"
    case apiKey = "36c08d47a147b7cf92b3217b18fe6405"
    case imgBaseURL = "https://image.tmdb.org/t/p/w500"
    case createToken = "authentication/token/new"
    case sessionLogin = "authentication/token/validate_with_login"
    case sessionDelete = "authentication/session"
    case sessionIni = "authentication/session/new"
}

extension UIImageView {
    func load(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}

class Switcher {
    static func updateRootVC(){
    
        let status = UserDefaults.standard.bool(forKey: "status")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print(status)
        if( status ){
            appDelegate.window?.rootViewController = UINavigationController(rootViewController: MoviesViewController())
        } else {
            appDelegate.window?.rootViewController = LoginViewController()
        }
                        
    }
}
