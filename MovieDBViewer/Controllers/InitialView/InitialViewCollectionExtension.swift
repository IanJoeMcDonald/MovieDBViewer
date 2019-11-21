//
//  InitialViewCollectionExtension.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 15/09/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

/*//MARK: Extension: Collection View Delegate
extension InitialViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = currentSet[indexPath.row % currentSet.count]
        let storyboard = UIStoryboard(name: StoryboardNames.Detail.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:
            StoryboardNames.Detail.rawValue) as? DetailViewController  else {
            return
        }
        viewController.movie = movie
        viewController.genres = genres
        viewController.languages = languages
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
}*/

//MARK: Extension: Collection View Data Source
/*extension InitialViewController: UICollectionViewDataSource {
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
}*/
