//
//  AppDelegate.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AppComponents.shared.setup()
        
//        let mainVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainNavigationController")
//        window?.rootViewController = mainVC
        
        return true
    }

}

