//
//  Movies.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 23/10/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

class Movies : Shows {
    //MARK: Public Vars
    var category1URLString = URLString.moviesNowShowing
    var category2URLString = URLString.moviesUpcomming
    var category3URLString = URLString.moviesTopRated
    var category1Title = String(asset: .nowShowing)
    var category2Title = String(asset: .upComming)
    var category3Title = String(asset: .topRated)
    
    //MARK: Static Vars
    static var title = String(asset:.movies)
    static var normalImage = UIImage(asset: .movie)
    static var selectedImage = UIImage(asset: .movieDark)
}
