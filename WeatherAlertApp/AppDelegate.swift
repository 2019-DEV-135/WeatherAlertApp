//
//  AppDelegate.swift
//  WeatherAlertApp
//
//  Created by Umar Yaqub on 05/02/2019.
//  Copyright © 2019 Umar Yaqub. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // set window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainController())
        window?.makeKeyAndVisible()
        return true
    }

}

