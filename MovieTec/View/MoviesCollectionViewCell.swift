//
//  MoviesCollectionViewCell.swift
//  MovieTec
//
//  Created by Furry Ruiz on 25/02/23.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    private var poster = UIImageView()
    private var name = UILabel()
    private var releaseDate = UILabel()
    private var rating = UILabel()
    private var overview = UILabel()
    var movieId: Int?
    var movie: Movies?
    var finalPath = "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg"
    var title = ""
    var average = ""
    var date = ""
    var over = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.contentView.addSubview(self.poster)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.releaseDate)
        self.contentView.addSubview(self.rating)
        self.contentView.addSubview(self.overview)
    }
    
    func styleViews(){
        contentView.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1529411765, blue: 0.1764705882, alpha: 1)
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        self.poster.translatesAutoresizingMaskIntoConstraints = false
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.releaseDate.translatesAutoresizingMaskIntoConstraints = false
        self.rating.translatesAutoresizingMaskIntoConstraints = false
        self.overview.translatesAutoresizingMaskIntoConstraints = false
        
        self.poster.layer.cornerRadius = 15
        self.poster.load(from: URL(string: finalPath)!)
        self.poster.clipsToBounds = true
        self.poster.contentMode = .scaleAspectFill
        styleLabel(self.name, text: title)
        styleLabel(self.releaseDate, text: date)
        styleLabel(self.rating, text: "★\(average)")
        self.overview.font = .systemFont(ofSize: UIFont.systemFontSize-3)
        self.overview.textColor = .white
        self.overview.text = over
        self.overview.numberOfLines = 0
        
    }
    
    func unwrappingSafe(movie: Movies?){
        if let imagePath = movie?.poster_path {
            finalPath = Routes.imgBaseURL.rawValue + imagePath
        }
        
        if let title = movie?.original_name {
            self.title = title
        }
        
        if let date = movie?.first_air_date {
            self.date = date
        }
        
        if let average = movie?.vote_average {
            self.average = "\(average)"
        }
        
        if let over = movie?.overview {
            self.over = over
        }
        setup()
        styleViews()
        setupConstraints()
    }
    
    func styleLabel(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = #colorLiteral(red: 0.5647058824, green: 0.8078431373, blue: 0.631372549, alpha: 1)
        label.font = .boldSystemFont(ofSize: UIFont.systemFontSize-2)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            self.poster.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.poster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.poster.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.poster.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 40)
        ])
        NSLayoutConstraint.activate([
            self.name.topAnchor.constraint(equalTo: self.poster.bottomAnchor),
            self.name.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.releaseDate.topAnchor.constraint(equalTo: self.name.bottomAnchor),
            self.releaseDate.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10)
        ])
        NSLayoutConstraint.activate([
            self.rating.topAnchor.constraint(equalTo: self.name.bottomAnchor),
            self.rating.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            self.overview.topAnchor.constraint(equalTo: self.rating.bottomAnchor),
            self.overview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.overview.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.overview.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.overview.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
