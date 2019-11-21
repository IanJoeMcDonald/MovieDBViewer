//
//  NumberAssets.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 02/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

enum CollectionViewSizes: Int {
    case lineSpacing = 8
    case sectionInsert = 0
    case itemCountTotal = 20000
    case itemCountMidPoint = 10000
}

enum RatingStars: Double {
    case minimum = 29.9
    case step = 20.0
}

enum Visibility: CGFloat {
    case visible = 1.0
    case hidden = 0.0
}
