//
//  MoviesListViewModelSpec.swift
//  MoviesTests
//
//  Created by Khanh Pham on 10/7/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Nimble
import Quick

import RxSwift

@testable import Movies

class MoviesListViewModelSpec: QuickSpec {
    override func spec() {
        describe("MoviesListViewModelSpec") {
            
            var moviesService: MockMoviesService!
            var viewModel: MoviesListViewModel!
            
            beforeEach {
                moviesService = MockMoviesService()
                viewModel = MoviesListViewModel(moviesService: moviesService)
            }
            
            describe("fetchMovies()") {
                
                context("success") {
                    var movies: [MovieModel] = []
                    
                    beforeEach {
                        var movie1 = MovieModel()
                        movie1.id = 1
                        
                        var movie2 = MovieModel()
                        movie2.id = 2
                        
                        movies = [movie1, movie2]
                        moviesService.stub_fetchListMovies = Observable.just(movies, dueTime: 0.5)
                        
                        viewModel.fetchMovies()
                    }
                    
                    it("should bind results to 'movies'") {
                        expect(checkMoviesEqual(lhs: viewModel.movies.value, rhs: movies)).toEventually(beTrue())
                    }
                    
                    it("should set currentPage = 1 after success") {
                        expect(viewModel.currentPage.value).toEventually(equal(1))
                    }
                }
                
                context("failed") {
                    beforeEach {
                        moviesService.stub_fetchListMovies = Observable.error(NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error"]), dueTime: 0.5)
                        
                        viewModel.fetchMovies()
                    }
                    
                    it("should bind value to alertMessage when got error") {
                        expect(viewModel.alertMessage.value).toEventually(equal("Test error"))
                    }
                }
            }
            
            describe("fetchMore()") {
                
                beforeEach {
                    var movie1 = MovieModel()
                    movie1.id = 1
                    
                    var movie2 = MovieModel()
                    movie2.id = 2
                    
                    viewModel.movies.value = [movie1, movie2]
                    viewModel.currentPage.value = 1
                }
                
                context("success") {
                    var movies: [MovieModel] = []
                    
                    beforeEach {
                        var movie3 = MovieModel()
                        movie3.id = 3
                        
                        var movie4 = MovieModel()
                        movie4.id = 4
                        
                        movies = [movie3, movie4]
                        moviesService.stub_fetchListMovies = Observable.just(movies, dueTime: 0.5)
                        
                    }
                    
                    it("should not fetch when isLoading = true") {
                        viewModel.isLoading.value = true
                        viewModel.fetchMore()
                        
                        expect(viewModel.movies.value).toNotEventually(haveCount(4))
                    }
                    
                    it("should append results to 'movies'") {
                        let oldValue = viewModel.movies.value
                        viewModel.fetchMore()
                        expect(checkMoviesEqual(lhs: viewModel.movies.value, rhs: (oldValue + movies))).toEventually(beTrue())
                    }
                    
                    it("should set increase currentPage") {
                        viewModel.fetchMore()
                        expect(viewModel.currentPage.value).toEventually(equal(2))
                    }
                }
                
                context("failed") {
                    beforeEach {
                        moviesService.stub_fetchListMovies = Observable.error(NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error"]), dueTime: 0.5)
                        
                    }
                    
                    it("should keep old 'movies' value") {
                        let oldValue = viewModel.movies.value
                        viewModel.fetchMore()
                        
                        expect(checkMoviesEqual(lhs: viewModel.movies.value, rhs: oldValue)).toNotEventually(beFalse())
                    }
                    
                    it("should bind value to alertMessage when got error") {
                        viewModel.fetchMore()
                        expect(viewModel.alertMessage.value).toEventually(equal("Test error"))
                    }
                }
            }
        }
    }
}

// MARK: - Helper

func checkMoviesEqual(lhs: [MovieModel], rhs: [MovieModel]) -> Bool {
    if lhs.count != rhs.count {
        return false
    }
    
    for i in 0..<lhs.count {
        if lhs[i].id != rhs[i].id {
            return false
        }
    }
    
    return true
}

