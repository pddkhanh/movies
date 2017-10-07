//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailViewModel {
    
    let moviesService: MoviesServiceType!
    let movie: Variable<MovieModel>
    let isLoading = Variable<Bool>(false)
    let alertMessage = Variable<String>("")
    let disposeBag = DisposeBag()
    
    init(movie: MovieModel, moviesService: MoviesServiceType) {
        self.movie = Variable<MovieModel>(movie)
        self.moviesService = moviesService
    }
    
    func fetchDetail() {
        let observable = moviesService
            .fetchMovieDetailById(movie.value.id ?? 0)
            .shareReplay(1)
        
        // Turn on isLoading when start request and then turn off after completed
        observable.map { _ in false }.startWith(true)
            .catchErrorJustReturn(false)
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        observable
            .subscribe(
                onNext: { [unowned self] movie in
                    self.movie.value = movie
                },
                onError: { [unowned self] (error) in
                    self.alertMessage.value = error.localizedDescription
                }
            )
            .disposed(by: disposeBag)
    }
}
