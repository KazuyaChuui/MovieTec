//
//  MoviesView.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

import UIKit

class MoviesView: UIView {
    private var viewModel: MoviesViewModel
    private let navBar = UINavigationBar()
    private let navItem = UINavigationItem(title: "TV Shows")
    private let navBtn = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: #selector(didTapButton(_:)))
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton(_ sender: UIBarButtonItem) {
        
    }
    
    func setup() {
        self.navItem.rightBarButtonItem = navBtn
        
        self.addSubview(navBar)
        
        self.navBar.setItems([navItem], animated: false)
    }
    
    func styleViews() {
        
    }
}
