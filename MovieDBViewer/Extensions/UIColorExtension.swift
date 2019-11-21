//
//  UIColorExtension.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 15/09/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(asset: ColorAssets) {
        let rgbaValue = asset.rawValue
        let red = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue = CGFloat((rgbaValue >> 8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
