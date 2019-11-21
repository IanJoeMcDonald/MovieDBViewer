//
//  ShowCell.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 15/09/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

class ShowCell: UICollectionViewCell {
  
    //MARK: Outlets
    @IBOutlet weak var ShowImage: UIImageView!
    @IBOutlet weak var ShowTitle: UILabel!
    
    //MARK: Public Functions
    func configure(forMovie movie: Show) {
        ShowTitle.text = movie.title
        ShowImage.image = UIImage(asset: .placeholder)
        setupView()
    }
    
    func setImage(_ image: UIImage?) {
        ShowImage.swapImage(to: image)
    }
    
    private func setupView() {
        backgroundColor = UIColor.clear
        ShowTitle.textColor = UIColor(asset: .text)
        ShowTitle.backgroundColor = UIColor.clear
    }
}
