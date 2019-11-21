//
//  InitialCollectionViewClass.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 20/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

final class InitialCollectionViewClass: NSObject {
    //MARK: Public Vars
    var currentlyShowing = ShowOptions.nowShowing.rawValue {
        didSet {
            updateShowList()
        }
    }
    
    //MARK: Private Vars
    private var collectionView: UICollectionView?
    private(set) var viewController: UIViewController?
    private var currentSet = [Show]()
    private var genres = [Int: String]()
    private var languages = [String: String]()
    
    //MARK: Initializers
    init(_ collectionView: UICollectionView? = nil, viewController: UIViewController?) {
        super.init()
        self.collectionView = collectionView
        self.viewController = viewController
        startAsync()
        updateShowList()
    }
    
    //MARK: Private Functions
    private func startAsync() {
        DispatchQueue.global().sync {
            NetworkManager.shared.fetchGenres { [weak self] (results) in
                if let genres = results.data {
                    self?.genres = genres
                }
            }
            NetworkManager.shared.fetchLanguages{ [weak self] (results) in
                if let languages = results.data {
                    self?.languages = languages
                }
            }
        }
    }
    
    private func updateShowList() {
        guard let viewController = viewController as? InitialViewController else { return }
        viewController.shows.update(to: currentlyShowing) { [weak self] (results) in
            self?.updateCollectionView(with: results)
        }
    }
    
    private func updateCollectionView(with shows: [Show]) {
        currentSet.removeAll(keepingCapacity: true)
        currentSet = shows
        collectionView?.reloadData()
        if let viewController = viewController as? InitialViewController {
            viewController.showCount = currentSet.count
        }
    }
}

//MARK: Extension: Collection View Delegate
extension InitialCollectionViewClass: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = currentSet[indexPath.row % currentSet.count]
        let storyboard = UIStoryboard(name: StoryboardNames.Detail.rawValue, bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier:
            StoryboardNames.Detail.rawValue) as? DetailViewController  else {
                return
        }
        detailVC.movie = movie
        detailVC.genres = genres
        detailVC.languages = languages
        detailVC.tabBarHeight = viewController?.tabBarController?.tabBar.bounds.height ?? CGFloat(0)
        viewController?.present(detailVC, animated: true, completion: nil)
    }
}

//MARK: Extension: Collection View Data Source
extension InitialCollectionViewClass: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->
        Int {
            return currentSet.count * CollectionViewSizes.itemCountTotal.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellNames.Show.rawValue,
                                                          for: indexPath) as! ShowCell
            let movie = currentSet[indexPath.row % currentSet.count]
            cell.configure(forMovie: movie)
            if let posterPath = movie.posterPath {
                ImageCache.shared.setImage(fromPath: posterPath, location: cell.ShowImage)
            }
            
            return cell
    }
}
