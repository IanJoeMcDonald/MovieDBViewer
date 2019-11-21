//
//  UIImageExtension.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 02/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init? (asset: ImageAssets) {
        self.init(named: asset.rawValue)
    }
    
    convenience init? (color: UIColor) {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
          context?.fill(rect)

          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }

        self.init(cgImage: cgImage)
    }
}
