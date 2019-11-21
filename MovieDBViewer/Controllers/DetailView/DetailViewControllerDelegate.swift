//
//  DetailViewControllerDelegate.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 29/10/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func getTabBarHeight() -> CGFloat?
    func getTabBarHeightWithoutSafeArea() -> CGFloat?
}
