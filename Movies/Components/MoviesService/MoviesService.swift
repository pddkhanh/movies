//
//  MoviesService.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RxSwift

class MoviesService: MoviesServiceType {
    let apiClient: ApiClientType
    
    init(apiClient: ApiClientType) {
        self.apiClient = apiClient
    }
    
    func fetchListMovies(page: Int) -> Observable<[MovieModel]> {
        let params: [String: Any] = [
            "primary_release_date.lte": "2016-12-31",
            "sort_by": "release_date.desc",
            "page": page
        ]
        return apiClient.requestJSON(.get, path: "/discover/movie", parameters: params)
            .map { (json) -> [MovieModel] in
                return json["results"]
                    .arrayValue
                    .flatMap { MovieModel(json: $0) }
        }
    }
    
    func fetchMovieDetailById(_ movieId: Int) -> Observable<MovieModel> {
        return apiClient.requestJSON(.get, path: "/movie/\(movieId)")
            .map { MovieModel(json: $0) }
    }
    
    
}
