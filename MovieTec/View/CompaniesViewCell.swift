//
//  CompaniesViewCell.swift
//  MovieTec
//
//  Created by Furry Ruiz on 27/02/23.
//

import UIKit

class CompaniesViewCell: UICollectionViewCell {
    
    static let identifier = "CompaniesCollectionViewCell"
    private var poster = UIImageView()
    var finalPath = "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.contentView.addSubview(self.poster)
    }
    
    func styleViews(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        self.poster.translatesAutoresizingMaskIntoConstraints = false
        
        self.poster.layer.cornerRadius = 15
        self.poster.backgroundColor = .clear
        self.poster.load(from: URL(string: finalPath)!)
        self.poster.clipsToBounds = true
        
    }
    
    func unwrappingSafe(imgPath: String){
        finalPath = imgPath
        setup()
        styleViews()
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            self.poster.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.poster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.poster.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.poster.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
