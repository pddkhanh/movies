//
//  ApiClient.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa
import SwiftyJSON

/**
 ApiClient to work with TMDb API
 */
class ApiClient: ApiClientType {
    
    private let baseUrl: String
    private let apiKey: String
    
    required init(baseUrl: String, apiKey: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }
    
    func requestJSON(_ method: HTTPMethod, path: String, parameters: [String : Any]?, headers: [String : String]?) -> Observable<JSON> {
        return handleRequestJSON(method, requestUrl(path), parameters: parameters, headers: headers)
    }
    
    private func requestUrl(_ relativePath: String) -> URL {
        var url = URL(string: baseUrl)!
        url.appendPathComponent(relativePath)
        return url
    }
    
    private func handleRequestJSON(_ method: Alamofire.HTTPMethod,
                     _ url: URLConvertible,
                     parameters: [String: Any]?,
                     headers: [String: String]?)
        -> Observable<JSON>
    {
        let callId = UUID().uuidString
        var requestParams: [String: Any] = parameters ?? [:]
        requestParams["api_key"] = apiKey
        let result = request(method, url, parameters: requestParams, encoding: URLEncoding.default, headers: headers)
            .flatMap({ req in
                return req
                    .logDebugRequest(callId: callId)
                    .validate().rx
                    .responseJSON()
            })
            .flatMap({ (response) -> Observable<JSON> in
                logDebug("Response \(callId): \(String(describing: response))")
                
                if let error = response.result.error {
                    logError("\(error)")
                    return .error(error)
                } else {
                    if let value = response.result.value {
                        return Observable.just(JSON(value))
                    } else {
                        return Observable.just(JSON([String: Any]())) // Just return empty JSON object
                    }
                }
            })
        
        
        
        return result
    }
}

extension Reactive where Base: DataRequest {
    func responseJSON() -> Observable<DataResponse<Any>> {
        return Observable.create({ (observer) -> Disposable in
            let request = self.base.responseJSON(completionHandler: { (response) in
                observer.onNext(response)
                observer.onCompleted()
            })
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
}

extension DataRequest {
    @discardableResult
    func logDebugRequest(callId: String) -> DataRequest {
        #if DEBUG
            logDebug("Request \(callId): \(self.debugDescription)")
        #endif
        return self
    }
}
