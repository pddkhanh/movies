//
//  MockMoviesService.swift
//  MoviesTests
//
//  Created by Khanh Pham on 10/7/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxSwift

@testable import Movies

class MockMoviesService: MoviesServiceType {
    
    var stub_fetchListMovies: Observable<[MovieModel]>?
    func fetchListMovies(page: Int) -> Observable<[MovieModel]> {
        return stub_fetchListMovies ?? .empty()
    }
    
    var stub_fetchMovieDetailById: Observable<MovieModel>?
    func fetchMovieDetailById(_ movieId: Int) -> Observable<MovieModel> {
        return stub_fetchMovieDetailById ?? .empty()
    }
}
