//
//  UILocalizedLabel.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 02/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

class UILocalizedLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        text = text?.localized()
    }
}
