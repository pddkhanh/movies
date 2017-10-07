//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    private var model: MovieModel?
    
    func configure(withModel model: MovieModel) {
        self.model = model
        if let posterPath = model.posterPath, let imgUrl = URL(string: Configs.apiBaseFilePath)?.appendingPathComponent(posterPath) {
            bgImageView.sd_setShowActivityIndicatorView(true)
            bgImageView.sd_setIndicatorStyle(.gray)
            bgImageView.sd_setImage(with: imgUrl)
        }
        
        titleLabel.text = model.title
        let popularity: String = model.popularity != nil ? "Popularity: \(model.popularity!)" : ""
        popularityLabel.text = popularity
    }
}
