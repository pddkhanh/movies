//
//  MovieModelSpec.swift
//  MoviesTests
//
//  Created by Khanh Pham on 10/7/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON

@testable import Movies

class MovieModelSpec: QuickSpec {
    override func spec() {
        describe("MovieModelSpec") {
            it("should init empty values") {
                let model = MovieModel()
                expect(model.id).to(beNil())
                expect(model.title).to(beNil())
                expect(model.posterPath).to(beNil())
                expect(model.popularity).to(beNil())
            }
            
            it("should init properly from JSON") {
                let fileUrl = Bundle(for: self.classForCoder).url(forResource: "movie_summary", withExtension: "json")!
                let jsonData = try! Data(contentsOf: fileUrl)
                let json = JSON(data: jsonData)
                
                let model = MovieModel(json: json)
                
                expect(model.id).to(equal(459123))
                expect(model.title).to(equal("Discolocos"))
                expect(model.posterPath).to(equal("/g0UdbPGwt7jz9UwudEQCtQXHvUL.jpg"))
                expect(model.popularity).to(equal(1.107237))
            }
        }
    }
}
