//
//  ImageCache.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 20/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
    private var cache = Dictionary<String, UIImage>()
    
    func setImage(fromPath path: String, location: UIImageView) {
        if let image = cache[path] {
            location.swapImage(to: image)
        } else {
            NetworkManager.shared.fetchImage(from: path) { [weak self] (image) in
                self?.cache[path] = image
                DispatchQueue.main.async {
                    location.swapImage(to: image)
                }
            }
        }
    }
}
