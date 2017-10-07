//
//  MoviesServiceSpec.swift
//  MoviesTests
//
//  Created by Khanh Pham on 10/7/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble

import Mockingjay
import SwiftyJSON

import RxSwift
import RxTest
import RxBlocking

@testable import Movies

class MoviesServiceSpec: QuickSpec {
    override func spec() {
        describe("MoviesServiceSpec") {
            var apiClient: ApiClientType!
            var moviesService: MoviesService!
            
            beforeEach {
                apiClient = ApiClient(baseUrl: "https://test.com", apiKey: "test")
                moviesService = MoviesService(apiClient: apiClient)
                
            }
            
            describe("fetchListMovies(page:)") {
                it("should return list of movies correctly") {
                    let fileUrl = Bundle(for: self.classForCoder).url(forResource: "fetch_movies_result", withExtension: "json")!
                    let jsonResponseData = try! Data(contentsOf: fileUrl)
                    let jsonResponseObj = JSON(data: jsonResponseData)
                    
                    self.stub(everything, jsonData(jsonResponseData))
                    
                    let movies = try! moviesService.fetchListMovies(page: 1)
                        .toBlocking(timeout: 1)
                        .toArray()[0]
                    
                    expect(movies.count).to(equal(jsonResponseObj["results"].array?.count))
                }
            }
            
            describe("fetchMovieDetailById(_:)") {
                it("should return movie detail correctly") {
                    let fileUrl = Bundle(for: self.classForCoder).url(forResource: "fetch_detail_result", withExtension: "json")!
                    let jsonResponseData = try! Data(contentsOf: fileUrl)
                    
                    self.stub(everything, jsonData(jsonResponseData))
                    
                    // Despite the movieID, we stubed the response to return from file
                    let model = try! moviesService.fetchMovieDetailById(1)
                        .toBlocking(timeout: 1)
                        .toArray()[0]
                    
                    expect(model.id).to(equal(328111))
                    expect(model.title).to(equal("The Secret Life of Pets"))
                    expect(model.posterPath).to(equal("/WLQN5aiQG8wc9SeKwixW7pAR8K.jpg"))
                    expect(model.popularity).to(equal(16.388586))
                }
            }
        }
    }
}
