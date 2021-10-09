//
//  AppDelegate.swift
//  YCNavigationBarSwiftDemo
//
//  Created by xushuifeng on 2020/2/23.
//  Copyright © 2020 alexiscn. All rights reserved.
//

import UIKit
import YCNavigationBarSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        YCNavigationBar.setup()
        
        YCNavigationBarStyle.backgroundColor = .secondarySystemBackground
        
        let rootViewController = RootViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

