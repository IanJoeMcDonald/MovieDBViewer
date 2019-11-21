//
//  AppDelegate.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 15/09/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Tab Bar Initialization
        if let tabVC = window?.rootViewController as? UITabBarController {
            if let movieVC = tabVC.viewControllers?[0] as? InitialViewController {
                movieVC.shows = Movies()
                movieVC.tabBarItem = Movies.setupTabBar()
            }
            
            if let tvVC = tabVC.viewControllers?[1] as? InitialViewController {
                tvVC.shows = TV()
                tvVC.tabBarItem = TV.setupTabBar()
            }
            
            if #available(iOS 13.0, *) {
                let appearance = tabVC.tabBar.standardAppearance
                appearance.shadowImage = nil
                appearance.shadowColor = nil
                appearance.configureWithTransparentBackground()
                tabVC.tabBar.standardAppearance = appearance
            } else {
                UITabBar.appearance().barTintColor = .clear
                UITabBar.appearance().shadowImage = UIImage()
                UITabBar.appearance().backgroundImage = UIImage()
            }
            UITabBar.appearance().tintColor = UIColor(asset: .selection)
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

