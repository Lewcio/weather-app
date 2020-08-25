//
//  AppDelegate.swift
//  Weather
//
//  Created by m.lewandowski on 22/08/2020.
//  Copyright © 2020 michalewandowski.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow! = UIWindow()
    let router = AppCoordinator().strongRouter


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        router.setRoot(for: window)
        return true
    }

}

