//
//  AppComponents.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import Swinject

/**
 Container class that contains all components, services of application.
 */
class AppComponents {
    
    static let shared = AppComponents()
    
    private let container: Container
    
    private init() {
        container = Container()
    }
    
    /**
     Set up and config all needed components. Need to call this when app launch.
     */
    func setup() {
        registerDIComponents()
        
        LoggerManager.shared.configure()
    }
    
    lazy var apiClient: ApiClientType = { this in
        return this.container.resolve(ApiClientType.self)!
    }(self)
    
    lazy var moviesService: MoviesServiceType = { this in
        return this.container.resolve(MoviesServiceType.self)!
    }(self)
    
    private func registerDIComponents() {
        container.register(ApiClientType.self) { _ in
            return ApiClient(baseUrl: Configs.apiBaseUrl, apiKey: Configs.apiKey)
        }
        
        container.register(MoviesServiceType.self) { resolver in
            return MoviesService(apiClient: resolver.resolve(ApiClientType.self)!)
        }
        
    }
    
}
