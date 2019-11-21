//
//  DetailViewSetupExtension.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 02/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

extension DetailViewController {
    //MARK: Public Funcs
    func setupView() {
        setupBackgrounds()
        setupTitle()
        setupImage()
        setupOverview()
        setupDate()
        setupGenre()
        setupLanguage()
        setupRating()
        setupBackButton()
    }
    
    func setupImageShadow() {
        let height = MainImageView.frame.height
        let width = MainImageView.frame.width
        let shadowSize: CGFloat = 12
        let shadowDistance: CGFloat = 10
        let contactRect = CGRect(x: -shadowSize, y: height - (shadowSize * 0.4) + shadowDistance,
                                 width: width + shadowSize * 2, height: shadowSize)
        MainImageView.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        MainImageView.layer.shadowRadius = 5
        MainImageView.layer.shadowOpacity = 0.4
    }
    
    //MARK: Private Funcs
    private func setupBackgrounds() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(asset: .background).cgColor, UIColor(asset: .outline).cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupTitle() {
        TitleLabel.text = movie?.title
        TitleLabel.textColor = UIColor(asset: .text)
    }
    
    private func setupImage() {
        MainImageView.image = UIImage(asset: .placeholder)
        if let path = movie?.posterPath {
            ImageCache.shared.setImage(fromPath: path, location: MainImageView)
        }
    }
    
    private func setupOverview() {
        OverviewLabel.text = movie?.overview
        OverviewTitle.textColor = UIColor(asset: .text)
        OverviewLabel.textColor = UIColor(asset: .text)
    }
    
    private func setupDate() {
        DateTitle.text = String(asset: .releaseDate)
        DateLabel.text = movie?.date
        DateTitle.textColor = UIColor(asset: .text)
        DateLabel.textColor = UIColor(asset: .text)
    }
    
    private func setupGenre() {
        guard let genreIDs = movie?.genreIDs else {
            return
        }
        
        var genreArray = [String]()
        for genreID in genreIDs {
            guard let genre = genres[genreID] else {
                continue
            }
            genreArray.append(genre)
        }
        GenreLabel.text = genreArray.joined(separator: ",\n")
        GenreTitle.textColor = UIColor(asset: .text)
        GenreLabel.textColor = UIColor(asset: .text)
    }
    
    private func setupLanguage() {
        guard let languageID = movie?.language else {
            return
        }
        
        guard let language = languages[languageID] else {
            return
        }
        LanguageTitle.text = String(asset: .originalLanguage)
        LanguageLabel.text = language
        LanguageTitle.textColor = UIColor(asset: .text)
        LanguageLabel.textColor = UIColor(asset: .text)
    }
    
    private func setupRating() {
        guard let averageVote = movie?.averageVote else {
            return
        }
        
        let starText = Array(repeating: String(asset: .star),
                             count: Int((averageVote/RatingStars.step.rawValue).rounded())).joined()
        AverageVoteLabel.text = starText + " (\(Int(averageVote))%)"
        AverageVoteTitle.textColor = UIColor(asset: .text)
        AverageVoteLabel.textColor = UIColor(asset: .text)
    }
    
    func setupBackButton() {
        BackButton.backgroundColor = UIColor.clear
        BackButton.setTitleColor(UIColor(asset: .text), for: .normal)
        BackButtonHeightConstraint.constant = tabBarHeight
    }
}
