//
//  ApiClientType.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

protocol ApiClientType {
    
    init(baseUrl: String, apiKey: String)
    
    func requestJSON(_ method: Alamofire.HTTPMethod,
                     path: String,
                     parameters: [String: Any]?,
                     headers: [String: String]?) -> Observable<JSON>
}

extension ApiClientType {
    /**
     Provide default values for parameters and headers
     */
    func requestJSON(_ method: Alamofire.HTTPMethod,
                     path: String,
                     parameters: [String: Any]? = nil,
                     headers: [String: String]? = nil) -> Observable<JSON> {
        return requestJSON(method, path: path, parameters: parameters, headers: headers)
    }
}
