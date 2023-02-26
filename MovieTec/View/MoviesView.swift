//
//  MoviesView.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

import UIKit

class MoviesView: UIView {
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemsPerRow: CGFloat = 2
    
    private var viewModel: MoviesViewModel
    private let navBar = UINavigationBar(frame: .zero)
    private let navItem = UINavigationItem(title: "TV Shows")
    private let navBtn = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: nil, action: #selector(didTapButton(_:)))
    private let segmentedCtrl = UISegmentedControl(items: ["Popular", "Top Rated", "On TV", "Airing Today"])
    private var collectionV: UICollectionView?
    private var navController: UINavigationController?
    
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
        //var vc = ProfileViewController()
        //self.inputViewController?.present(vc, animated: true)
        
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        
    }
    
    func setup() {
        self.navItem.rightBarButtonItem = navBtn
        //self.navBar.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        self.collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionV!.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        self.collectionV!.delegate = self
        self.collectionV!.dataSource = self
                
        //self.addSubview(self.navBar)
        self.addSubview(self.segmentedCtrl)
        self.addSubview(self.collectionV!)
        
        self.navBar.setItems([navItem], animated: false)
    }
    
    func styleViews() {
        self.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)
        
        self.navBar.barTintColor = #colorLiteral(red: 0.1882352941, green: 0.2156862745, blue: 0.2274509804, alpha: 1)
        self.navBar.tintColor = .white
        self.navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navBar.translatesAutoresizingMaskIntoConstraints = false
            
        self.segmentedCtrl.selectedSegmentIndex = 0
        self.segmentedCtrl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        self.segmentedCtrl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
        self.segmentedCtrl.selectedSegmentTintColor = .gray
        self.segmentedCtrl.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionV!.backgroundColor = .clear
        self.collectionV!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        
        
        NSLayoutConstraint.activate([
            self.segmentedCtrl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.segmentedCtrl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.segmentedCtrl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
        ])
        NSLayoutConstraint.activate([
            self.collectionV!.topAnchor.constraint(equalTo: self.segmentedCtrl.bottomAnchor, constant: 10),
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

// MARK: - Collection View Delegate
extension MoviesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    // MARK: - Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
