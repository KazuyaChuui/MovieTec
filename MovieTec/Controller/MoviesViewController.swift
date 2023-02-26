//
//  MoviesViewController.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

import UIKit

class MoviesViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TV Shows"
        navigationController?.delegate = self
        let navBarApp = UINavigationBarAppearance()
        navBarApp.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navBarApp.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navBarApp.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.2156862745, blue: 0.2274509804, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navBarApp
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApp

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(didTapButton))
    }
    
    override func loadView() {
        self.view = MoviesView(viewModel: MoviesViewModel())
    }
    
    @objc func didTapButton() {
        let alertView = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        let profile = UIAlertAction(title: "View Profile", style: .default) { (action) in
            let vc = ProfileViewController()
            self.present(vc,animated: true)
        }

        let logOut = UIAlertAction(title: "Log Out", style: .destructive) { (action) in
            
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertView.addAction(profile)
        alertView.addAction(logOut)
        alertView.addAction(cancel)
        self.present(alertView, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
