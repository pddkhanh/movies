//
//  MoviesServiceType.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviesServiceType {
    
    /**
     Fetch list of movies from TMDb.
     
     - returns: List of summary of movies that release after 2016-12-31, sorted by release_date
     */
    func fetchListMovies(page: Int) -> Observable<[MovieModel]>
    
    /**
     Fetch movie details by Id
     */
    func fetchMovieDetailById(_ movieId: Int) -> Observable<MovieModel>
}
