//
//  Shows.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 30/10/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

protocol Shows {
    //MARK: Public Vars
    var category1URLString: URLString {get}
    var category2URLString: URLString {get}
    var category3URLString: URLString {get}
    var category1Title: String {get}
    var category2Title: String {get}
    var category3Title: String {get}
    
    //MARK: Static Vars
    static var title: String {get}
    static var normalImage: UIImage? {get}
    static var selectedImage: UIImage? {get}
    
    //MARK: Public Functions
    func update(to currentlyShowing: Int, completion: @escaping ([Show])->Void)
    func setupSegmentedControl(_ segCtrl: inout UISegmentedControl)
    
    //MARK: Static Functions
    static func setupTabBar() -> UITabBarItem
    
}

//MARK: Extension: Default Implementation
extension Shows {
    //MARK: Public Functions
    func update(to currentlyShowing: Int, completion: @escaping ([Show])->Void ) {
        switch currentlyShowing {
        case ShowOptions.nowShowing.rawValue:
            NetworkManager.shared.fetchShows(from: category1URLString) { (result) in
                DispatchQueue.main.async {
                    if let shows = result.data {
                        completion(shows)
                    } else {
                        completion([Show]())
                    }
                }
            }
            
        case ShowOptions.upcomming.rawValue:
            NetworkManager.shared.fetchShows(from: category2URLString) { (result) in
                DispatchQueue.main.async {
                    if let shows = result.data {
                        completion(shows)
                    } else {
                        completion([Show]())
                    }
                }
                
            }
        default:
            NetworkManager.shared.fetchShows(from: category3URLString) { (result) in
                DispatchQueue.main.async {
                    if let shows = result.data {
                        completion(shows)
                    } else {
                        completion([Show]())
                    }
                }
            }
        }
    }
    
    func setupSegmentedControl(_ segCtrl:  inout UISegmentedControl) {
        segCtrl.setTitle(category1Title.localized(), forSegmentAt: ShowOptions.nowShowing.rawValue)
        segCtrl.setTitle(category2Title.localized(), forSegmentAt: ShowOptions.upcomming.rawValue)
        segCtrl.setTitle(category3Title.localized(), forSegmentAt: ShowOptions.topRated.rawValue)
    }
    
    //MARK: Static Functions
    static func setupTabBar() -> UITabBarItem {
        return UITabBarItem(title: title.localized(), image: normalImage,
                            selectedImage: selectedImage)
    }
    
    
    
}
