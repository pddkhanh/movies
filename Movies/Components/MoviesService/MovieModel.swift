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
    
    init() {
        
    }
    
    init(json: JSON) {
        self.init()
        
        id = json["id"].int
        title = json["title"].string
        popularity = json["popularity"].double
        posterPath = json["poster_path"].string
    }
}
