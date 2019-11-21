//
//  InitialViewController.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 15/09/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

final class InitialViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Public Vars
    var shows: Shows = Movies()
    var showCount = 0 {
        didSet {
            updateCollectionViewPosition()
        }
    }
    
    //MARK: Private Vars
    private var updating = false {
        didSet {
            if updating {
                activityIndicator.alpha = Visibility.visible.rawValue
                activityIndicator.startAnimating()
            } else {
                activityIndicator.alpha = Visibility.hidden.rawValue
                activityIndicator.stopAnimating()
            }
        }
    }
    private var scrollIndicationShown = false
    private var collectionViewClass: InitialCollectionViewClass!
    
    //MARK: Override Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewConnections()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionViewLayout()
    }
    
    //MARK: Private Funcs
    private func setupCollectionViewConnections() {
        collectionViewClass = InitialCollectionViewClass(collectionView, viewController: self)
        collectionView.dataSource = collectionViewClass
        collectionView.delegate = collectionViewClass
    }
    
    private func updateCollectionViewPosition() {
        let midIndexPath = collectionViewIndexPath()
        collectionView.scrollToItem(at: midIndexPath, at: .centeredHorizontally, animated: false)
        updating = false
        if !scrollIndicationShown {
            collectionViewScrollIndication()
        }
    }
    
    private func collectionViewScrollIndication() {
        let centerPath = IndexPath(row: showCount *
            CollectionViewSizes.itemCountMidPoint.rawValue, section: 0)
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 3, options: .curveLinear, animations: { [weak self] in
            self?.collectionView.scrollToItem(at: centerPath, at: .centeredHorizontally,
                                              animated: false)
        })
        scrollIndicationShown = true
    }
    
    private func collectionViewIndexPath() -> IndexPath {
        var midPoint = showCount * CollectionViewSizes.itemCountMidPoint.rawValue
        
        //if scrollview not shown yet load the cell 1 before for animation
        if !scrollIndicationShown {
            midPoint -= 1
        }
        
        return IndexPath(row: midPoint, section: 0)
    }
    
    //MARK: Actions
    @IBAction func segmentControlSelected(_ sender: UISegmentedControl) {
        updating = true
        collectionViewClass.currentlyShowing = segmentedControl.selectedSegmentIndex
    }
}
