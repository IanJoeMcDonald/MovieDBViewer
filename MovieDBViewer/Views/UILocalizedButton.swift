//
//  UILocalizedButton.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 02/11/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

class UILocalizedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let title = self.title(for: .normal)?.localized()
        setTitle(title, for: .normal)
    }
}
