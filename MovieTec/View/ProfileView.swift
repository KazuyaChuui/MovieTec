//
//  ProfileView.swift
//  MovieTec
//
//  Created by Furry Ruiz on 25/02/23.
//

import UIKit

class ProfileView: UIView {
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemsPerRow: CGFloat = 2
    
    private var viewModel: ProfileViewModel
    private let profile = UILabel()
    private var username = UILabel()
    private var profileImg = UIImageView()
    private let favorite = UILabel()
    private var collectionV: UICollectionView?

    
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.setup()
        self.styleViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionV!.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        self.collectionV!.delegate = self
        self.collectionV!.dataSource = self
        
        self.addSubview(self.profile)
        self.addSubview(self.username)
        self.addSubview(self.profileImg)
        self.addSubview(self.favorite)
        self.addSubview(self.collectionV!)
    }
    
    func styleViews() {
        self.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)

        self.collectionV!.backgroundColor = .clear
        self.profile.text = "Profile"
        self.profile.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        self.profile.font = .boldSystemFont(ofSize: 20)
        
        self.favorite.text = "Favorite Shows"
        self.favorite.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        self.favorite.font = .boldSystemFont(ofSize: 15)
        
        self.username.text = "Username"
        self.username.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        self.username.font = .systemFont(ofSize: UIFont.systemFontSize)
        
        let image = #imageLiteral(resourceName: "Logo")
        self.profileImg.layer.cornerRadius = 120 / 2
        self.profileImg.image = image
        self.profileImg.clipsToBounds = true
        self.profileImg.layer.masksToBounds = true
        self.profileImg.contentMode = .scaleAspectFill
        
        self.profile.translatesAutoresizingMaskIntoConstraints = false
        self.username.translatesAutoresizingMaskIntoConstraints = false
        self.profileImg.translatesAutoresizingMaskIntoConstraints = false
        self.favorite.translatesAutoresizingMaskIntoConstraints = false
        self.collectionV!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            self.profile.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.profile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.profileImg.topAnchor.constraint(equalTo: self.profile.bottomAnchor, constant: 50),
            self.profileImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.profileImg.heightAnchor.constraint(equalToConstant: 120),
            self.profileImg.widthAnchor.constraint(equalToConstant: 120)
        ])
        NSLayoutConstraint.activate([
            self.username.topAnchor.constraint(equalTo: self.profileImg.centerYAnchor),
            self.username.leadingAnchor.constraint(equalTo: self.profileImg.trailingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            self.favorite.topAnchor.constraint(equalTo: self.centerYAnchor),
            self.favorite.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.collectionV!.topAnchor.constraint(equalTo: self.favorite.bottomAnchor),
            self.collectionV!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collectionV!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionV!.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

// MARK: - Collection View Delegate
extension ProfileView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
