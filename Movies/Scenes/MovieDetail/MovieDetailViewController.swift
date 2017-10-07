//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift

class MovieDetailViewController: UIViewController, BindableType {
    typealias ViewModelType = MovieDetailViewModel
    
    var viewModel: MovieDetailViewModel!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    
    
    func bindViewModel() {
        viewModel.movie
            .asObservable()
            .observeOnMain()
            .bind { [unowned self] (movie) in
                self.updateView(with: movie)
            }
            .disposed(by: disposeBag)
        
        // Fetch data when appear
        rx.viewWillAppear
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.fetchDetail()
            })
            .disposed(by: disposeBag)
        
        // Show alert if any
        ToastHelper
            .bindWith(viewModel.alertMessage.asObservable())
            .disposed(by: disposeBag)
        
        // Show indicator when loading
        bindAnimateWith(variable: viewModel.isLoading)
            .disposed(by: disposeBag)
        
        // Actions
        bookButton.rx.tap
            .asObservable()
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind {
                UIApplication.shared.open(URL(string: "https://www.cathaycineplexes.com.sg/")!)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateView(with movie: MovieModel) {
        if let posterPath = movie.posterPath, let imgUrl = URL(string: Configs.apiBaseFilePath)?.appendingPathComponent(posterPath) {
            
            if bgImageView.image == nil {
                bgImageView.sd_setShowActivityIndicatorView(true)
                bgImageView.sd_setIndicatorStyle(.gray)
                bgImageView.sd_setImage(with: imgUrl)
            }
            
        }
        
        if let title = movie.title {
            titleLabel.text = title
        } else {
            titleLabel.text = ""
        }
        
        if let popularity = movie.popularity {
            popularityLabel.text = "Popularity: \(popularity)"
        } else {
            popularityLabel.text = "Popularity: "
        }
        
        if let overview = movie.overview {
            overviewLabel.text = overview
        } else {
            overviewLabel.text = ""
        }
        
        if let genres = movie.genres, !genres.isEmpty {
            genresLabel.text = "Genres: \(genres.joined(separator: ", "))"
        } else {
            genresLabel.text = "Genres: "
        }
        
        if let languages = movie.languages, !languages.isEmpty {
            languageLabel.text = "Languages: \(languages.joined(separator: ", "))"
        } else {
            languageLabel.text = "Languages: "
        }
        
        if let duration = movie.durationInMinutes {
            durationLabel.text = "Duration: \(duration.hourMinuteFormatted)"
        } else {
            durationLabel.text = "Duration: "
        }
    }
}


