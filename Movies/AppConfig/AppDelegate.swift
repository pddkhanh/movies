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
        
        bindViewModelForInitialViewController()
        
        return true
    }
    
    private func bindViewModelForInitialViewController() {
        guard let navVC = window?.rootViewController as? UINavigationController else {
            return
        }
        
        guard let listVC = navVC.viewControllers.first as? MoviesListViewController else {
            return
        }
        
        let vm = MoviesListViewModel(moviesService: AppComponents.shared.moviesService)
        listVC.bindViewModel(to: vm)
    }

}

