//
//  TV.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 23/10/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

class TV: Shows {
    //MARK: Public Vars
    var category1URLString = URLString.tvNowShowing
    var category2URLString = URLString.tvOnTheAir
    var category3URLString = URLString.tvTopRated
    var category1Title = String(asset: .nowShowing)
    var category2Title = String(asset: .onAir)
    var category3Title = String(asset: .topRated)
    
    //MARK: Static Vars
    static var title = String(asset: .tv)
    static var normalImage = UIImage(asset: .tv)
    static var selectedImage = UIImage(asset: .tvDark)
    
}
