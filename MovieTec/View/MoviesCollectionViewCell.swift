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
    private var synopsis = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.contentView.addSubview(self.poster)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.releaseDate)
        self.contentView.addSubview(self.rating)
        self.contentView.addSubview(self.synopsis)
    }
    
    func styleViews(){
        contentView.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1529411765, blue: 0.1764705882, alpha: 1)
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        self.poster.translatesAutoresizingMaskIntoConstraints = false
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.releaseDate.translatesAutoresizingMaskIntoConstraints = false
        self.rating.translatesAutoresizingMaskIntoConstraints = false
        self.synopsis.translatesAutoresizingMaskIntoConstraints = false
        
        self.poster.layer.cornerRadius = 15
        self.poster.image = #imageLiteral(resourceName: "Logo")
        self.poster.clipsToBounds = true
        styleLabel(self.name, text: "Hardcoded")
        styleLabel(self.releaseDate, text: "Hardcoded")
        styleLabel(self.rating, text: "★5")
        self.synopsis.font = .systemFont(ofSize: UIFont.systemFontSize-3)
        self.synopsis.textColor = .white
        self.synopsis.text = "Hardoced Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 15"
        self.synopsis.numberOfLines = 0
        
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
            self.synopsis.topAnchor.constraint(equalTo: self.rating.bottomAnchor),
            self.synopsis.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.synopsis.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.synopsis.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.synopsis.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
