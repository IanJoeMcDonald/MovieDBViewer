//
//  InitialViewSetupExtension.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 02/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

extension InitialViewController {
    //MARK: Public Funcs
    func setupView() {
        setUpViewBackground()
        setUpSegmentedController()
        setupCollectionView()
    }
    
    func setupCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: collectionView.bounds.width,
                                     height: collectionView.bounds.height)
            layout.minimumLineSpacing = CGFloat(CollectionViewSizes.lineSpacing.rawValue)
            layout.sectionInset.left = CGFloat(CollectionViewSizes.sectionInsert.rawValue)
            layout.sectionInset.right = CGFloat(CollectionViewSizes.sectionInsert.rawValue)
        }
    }
    
    //MARK: Private Funcs
    private func setUpViewBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(asset: .background).cgColor, UIColor(asset: .outline).cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setUpSegmentedController() {
        shows.setupSegmentedControl(&segmentedControl)
        setupSegmentedControllerView()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor.clear
    }
    
    private func setupSegmentedControllerView() {
        segmentedControl.tintColor = UIColor(asset: .selection)
        if #available(iOS 13.0, *) {
            segmentedControl.ensureiOS12Style(selectedTextColor: UIColor(asset: .outline))
        }
    }
}
