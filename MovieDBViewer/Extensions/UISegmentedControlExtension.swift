//
//  UISegmentedControlExtension.swift
//  MovieDBViewer
//
//  Created by Masipack Eletronica on 20/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    func ensureiOS12Style(selectedTextColor color: UIColor) {
        if #available(iOS 13, *) {
            let tintColorImage = UIImage(color: tintColor)
            setBackgroundImage(UIImage(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
            setBackgroundImage(UIImage(color: tintColor.withAlphaComponent(0.2)), for: .highlighted, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: [.highlighted, .selected], barMetrics: .default)
            setTitleTextAttributes([.foregroundColor: tintColor], for: .normal)
            setTitleTextAttributes([.foregroundColor: color], for: .selected)
            setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            layer.borderWidth = 1
            layer.borderColor = tintColor.cgColor
        }
    }
}
