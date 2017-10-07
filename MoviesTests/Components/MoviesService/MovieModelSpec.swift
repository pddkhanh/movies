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
            
            it("should init properly from JSON summary") {
                let fileUrl = Bundle(for: self.classForCoder).url(forResource: "movie_summary", withExtension: "json")!
                let jsonData = try! Data(contentsOf: fileUrl)
                let json = JSON(data: jsonData)
                
                let model = MovieModel(json: json)
                
                expect(model.id).to(equal(459123))
                expect(model.title).to(equal("Discolocos"))
                expect(model.posterPath).to(equal("/g0UdbPGwt7jz9UwudEQCtQXHvUL.jpg"))
                expect(model.popularity).to(equal(1.107237))
            }
            
            it("should init properly from JSON detail") {
                let fileUrl = Bundle(for: self.classForCoder).url(forResource: "movie_detail", withExtension: "json")!
                let jsonData = try! Data(contentsOf: fileUrl)
                let json = JSON(data: jsonData)
                
                let model = MovieModel(json: json)
                
                expect(model.id).to(equal(346364))
                expect(model.title).to(equal("It"))
                expect(model.posterPath).to(equal("/9E2y5Q7WlCVNEhP5GiVTjhEhx1o.jpg"))
                expect(model.popularity).to(equal(495.821171))
                expect(model.overview).to(equal("In a small town in Maine, seven children known as The Losers Club come face to face with life problems, bullies and a monster that takes the shape of a clown called Pennywise."))
                expect(model.genres).to(equal(["Adventure", "Drama", "Horror"]))
                expect(model.languages).to(equal(["English"]))
                expect(model.durationInMinutes).to(equal(135))
            }
        }
    }
}
