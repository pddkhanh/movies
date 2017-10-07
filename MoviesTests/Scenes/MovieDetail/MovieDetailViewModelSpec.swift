//
//  MovieDetailViewModelSpec.swift
//  MoviesTests
//
//  Created by Khanh Pham on 10/7/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Nimble
import Quick

import RxSwift

@testable import Movies

class MovieDetailViewModelSpec: QuickSpec {
    override func spec() {
        describe("MovieDetailViewModelSpec") {
            
            var moviesService: MockMoviesService!
            var viewModel: MovieDetailViewModel!
            var movie: MovieModel!
            
            beforeEach {
                movie = MovieModel()
                movie.id = 1
                movie.title = "Test"
                
                moviesService = MockMoviesService()
                viewModel = MovieDetailViewModel(movie: movie, moviesService: moviesService)
            }
            
            describe("fetchDetail()") {
                
                context("success") {
                    beforeEach {
                        var movieRes: MovieModel! = movie
                        movieRes.overview = "Fetched"
                        
                        moviesService.stub_fetchMovieDetailById = Observable.just(movieRes, dueTime: 0.5)
                        viewModel.fetchDetail()
                    }
                    
                    it("should bind results to 'movie'") {
                        expect(viewModel.movie.value.overview).toEventually(equal("Fetched"))
                    }
                }
                
                context("failed") {
                    beforeEach {
                        moviesService.stub_fetchMovieDetailById = Observable.error(NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error"]), dueTime: 0.5)
                        
                        viewModel.fetchDetail()
                    }
                    
                    it("should bind value to alertMessage when got error") {
                        expect(viewModel.alertMessage.value).toEventually(equal("Test error"))
                    }
                }
            }
            
        }
    }
}

