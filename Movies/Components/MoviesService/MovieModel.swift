//
//  MovieModel.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieModel {
    var id: Int?
    var title: String?
    var posterPath: String?
    var popularity: Double?
    var overview: String?
    var genres: [String]?
    var languages: [String]?
    var durationInMinutes: Int?
    
    init() {
        
    }
    
    init(json: JSON) {
        self.init()
        
        id = json["id"].int
        title = json["title"].string
        popularity = json["popularity"].double
        posterPath = json["poster_path"].string
        overview = json["overview"].string
        genres = json["genres"].array?.flatMap { $0["name"].string }
        languages = json["spoken_languages"].array?.flatMap { $0["name"].string }
        durationInMinutes = json["runtime"].int
    }
}
