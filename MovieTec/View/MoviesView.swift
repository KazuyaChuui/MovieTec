//
//  MoviesView.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

import UIKit

class MoviesView: UIView {
    private var viewModel: MoviesViewModel
    private let navBar = UINavigationBar(frame: .zero)
    private let navItem = UINavigationItem(title: "TV Shows")
    private let navBtn = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: #selector(didTapButton(_:)))
    private var collectionV: UICollectionView?
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.setup()
        self.styleViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton(_ sender: UIBarButtonItem) {
        
    }
    
    func setup() {
        self.navItem.rightBarButtonItem = navBtn
        self.navBar.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        self.collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionV!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionV!.delegate = self
        self.collectionV!.dataSource = self
        
        self.addSubview(self.navBar)
        self.addSubview(self.collectionV!)
        
        self.navBar.setItems([navItem], animated: false)
    }
    
    func styleViews() {
        self.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)
        
        self.navBar.barTintColor = #colorLiteral(red: 0.1882352941, green: 0.2156862745, blue: 0.2274509804, alpha: 1)
        self.navBar.tintColor = .white
        self.navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navBar.translatesAutoresizingMaskIntoConstraints = false
                
        self.collectionV!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor )
        ])
        NSLayoutConstraint.activate([
            self.collectionV!.topAnchor.constraint(equalTo: self.navBar.bottomAnchor),
            self.collectionV!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionV!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionV!.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension MoviesView: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

extension MoviesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .systemBlue
        return cell
    }
    
    
}
