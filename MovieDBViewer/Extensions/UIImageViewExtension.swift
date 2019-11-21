//
//  UIImageViewExtension.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 15/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

extension UIImageView {
    func swapImage(to image: UIImage?) {
        UIView.transition(with: self, duration: 0.5, options: [.transitionCrossDissolve],
                          animations: {[weak self] in
                            self?.image = image
            })
    }
}
