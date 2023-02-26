//
//  DetailView.swift
//  MovieTec
//
//  Created by Furry Ruiz on 26/02/23.
//

import UIKit

class DetailView: UIView {
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemsPerRow: CGFloat = 3
    
    private var viewModel: DetailViewModel
    private var name = UILabel()
    private var overview = UILabel()
    private var poster = UIImageView()
    private let favorite = UIButton()
    private var releaseDate = UILabel()
    private var genres = UILabel()
    private var status = UILabel()
    private var rating = UILabel()
    private var collectionV: UICollectionView?

    
    
    init(viewModel: DetailViewModel) {
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
        self.collectionV!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionV!.delegate = self
        self.collectionV!.dataSource = self
        
        self.addSubview(self.name)
        self.addSubview(self.overview)
        self.addSubview(self.poster)
        self.addSubview(self.favorite)
        self.addSubview(self.releaseDate)
        self.addSubview(self.genres)
        self.addSubview(self.status)
        self.addSubview(self.rating)
        self.addSubview(self.collectionV!)
    }
    
    func styleViews() {
        self.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)

        self.collectionV!.backgroundColor = .clear
        self.name.text = "DieHard"
        self.name.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        self.name.font = .boldSystemFont(ofSize: 20)
        
        styleLabel(releaseDate, text: "diehard")
        styleLabel(genres, text: "hard")
        styleLabel(status, text: "hard")
        styleLabel(rating, text: "★5")
        
        self.overview.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem"
        self.overview.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        self.overview.numberOfLines = 0
        self.overview.font = .systemFont(ofSize: UIFont.systemFontSize)
        self.overview.textAlignment = .justified
        
        let image = #imageLiteral(resourceName: "Logo")
        self.poster.image = image
        self.poster.contentMode = .scaleAspectFill
        
        styleBtn(favorite)
    }
    
    func styleLabel(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        label.font = .boldSystemFont(ofSize: 10)
    }
    
    func styleBtn(_ btn: UIButton) {
        btn.backgroundColor = .clear
        btn.tintColor = .red
        btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    func setupConstraints(){
        [
            name,
            overview,
            poster,
            favorite,
            releaseDate,
            genres,
            status,
            rating,
            collectionV!
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            self.poster.topAnchor.constraint(equalTo: self.topAnchor),
            self.poster.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.poster.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.poster.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            self.name.topAnchor.constraint(equalTo: self.poster.bottomAnchor, constant: 20),
            self.name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
        NSLayoutConstraint.activate([
            self.favorite.topAnchor.constraint(equalTo: self.poster.bottomAnchor, constant: 10),
            self.favorite.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.favorite.heightAnchor.constraint(equalToConstant: 40),
            self.favorite.widthAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            self.rating.topAnchor.constraint(equalTo: self.name.bottomAnchor),
            self.rating.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.rating.widthAnchor.constraint(equalToConstant: self.rating.intrinsicContentSize.width)
        ])
        NSLayoutConstraint.activate([
            self.releaseDate.topAnchor.constraint(equalTo: self.name.bottomAnchor),
            self.releaseDate.leadingAnchor.constraint(equalTo: self.rating.trailingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.genres.topAnchor.constraint(equalTo: self.name.bottomAnchor),
            self.genres.leadingAnchor.constraint(equalTo: self.releaseDate.trailingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.status.topAnchor.constraint(equalTo: self.name.bottomAnchor),
            self.status.leadingAnchor.constraint(equalTo: self.genres.trailingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.overview.topAnchor.constraint(equalTo: self.rating.bottomAnchor, constant: 10),
            self.overview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.overview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            self.collectionV!.topAnchor.constraint(equalTo: self.overview.bottomAnchor),
            self.collectionV!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collectionV!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionV!.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

// MARK: - Collection View Delegate
extension DetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        return cell
    }
    
    // MARK: - Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
