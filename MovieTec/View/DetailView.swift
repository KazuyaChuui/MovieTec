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
    var movie: Movie?
    var finalPath = "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg"
    
    init(viewModel: DetailViewModel, id: Int) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.viewModel.getMovieWith(id: id) {
            self.movie = self.viewModel.movie
            
            DispatchQueue.main.async { [weak self] in
                self!.setup()
                self!.styleViews()
                self!.setupConstraints()
                self!.collectionV!.reloadData()

            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionV!.register(CompaniesViewCell.self, forCellWithReuseIdentifier: CompaniesViewCell.identifier)
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
        self.name.text = movie?.original_name ?? ""
        self.name.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        self.name.font = .boldSystemFont(ofSize: 20)
        
        self.rating.text = "★ \(movie?.vote_average ?? 0)"
        self.rating.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        self.rating.font = .boldSystemFont(ofSize: 15)
        
        styleLabel(releaseDate, text: movie?.first_air_date ?? "")
        styleLabel(genres, text: movie?.genres.map{$0.name}.joined(separator: ", ") ?? "")
        styleLabel(status, text: movie?.status ?? "")
        
        self.overview.text = movie?.overview ?? ""
        self.overview.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        self.overview.numberOfLines = 0
        self.overview.font = .systemFont(ofSize: UIFont.systemFontSize)
        self.overview.textAlignment = .justified
        
        if let imagePath = movie?.poster_path {
            finalPath = Routes.imgBaseURL.rawValue + imagePath
        }
        
        self.poster.load(from: URL(string: finalPath)!)
        
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
            self.name.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            self.name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
        NSLayoutConstraint.activate([
            self.favorite.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            self.favorite.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.favorite.heightAnchor.constraint(equalToConstant: 40),
            self.favorite.widthAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            self.rating.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 15),
            self.rating.leadingAnchor.constraint(equalTo: self.name.trailingAnchor, constant: 20),
            self.rating.widthAnchor.constraint(equalToConstant: self.rating.intrinsicContentSize.width)
        ])
        NSLayoutConstraint.activate([
            self.releaseDate.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 10),
            self.releaseDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.genres.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 5),
            self.genres.leadingAnchor.constraint(equalTo: self.releaseDate.trailingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.status.topAnchor.constraint(equalTo: self.releaseDate.bottomAnchor, constant: 5),
            self.status.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            self.overview.topAnchor.constraint(equalTo: self.status.bottomAnchor, constant: 10),
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
        return self.movie?.production_companies.compactMap{ $0.logo_path }.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompaniesViewCell.identifier, for: indexPath) as! CompaniesViewCell
        let logos = (self.movie?.production_companies.compactMap{ $0.logo_path })!
        cell.unwrappingSafe(imgPath: Routes.imgBaseURL.rawValue + logos[indexPath.row])
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
