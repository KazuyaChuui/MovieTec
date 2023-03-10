//
//  MoviesViewController.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

import UIKit
import Combine

class MoviesViewController: UIViewController, UINavigationControllerDelegate {

    private var selectedCell: MoviesView = MoviesView(viewModel: MoviesViewModel())
    private var cancellables = Set<AnyCancellable>()
    private var viewModel = MoviesViewModel()
    var success: Bool?
    
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
        
        setupBindings()
    }
    
    override func loadView() {
        self.view = self.selectedCell
    }
    
    func setupBindings(){
        self.selectedCell.$cell.sink { cell in
            if( cell != -1){
                let vc = DetailViewController()
                vc.id = cell
                self.present(vc, animated: true)
            }
        }.store(in: &cancellables)
    }
    
    @objc func didTapButton() {
        let alertView = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        let profile = UIAlertAction(title: "View Profile", style: .default) { (action) in
            let vc = ProfileViewController()
            self.present(vc,animated: true)
        }

        let logOut = UIAlertAction(title: "Log Out", style: .destructive) { (action) in
            UserDefaults.standard.set(false, forKey: "status")
            Switcher.updateRootVC()
            self.viewModel.deleteSession {
                self.success = self.viewModel.success
                DispatchQueue.main.async { [weak self] in
                    if(self!.success!){
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self!.view.window?.rootViewController?.present(loginVC, animated: true)
                    }
                }
               
            }
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
