//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxSwift

class MoviesListViewModel {
    let moviesService: MoviesServiceType
    
    let movies = Variable<[MovieModel]>([])
    let isLoading = Variable<Bool>(false)
    let alertMessage = Variable<String>("")
    let currentPage = Variable<Int>(0)
    
    let disposeBag = DisposeBag()
    
    init(moviesService: MoviesServiceType) {
        self.moviesService = moviesService
    }
    
    /**
     Clear and fetch all movies to `movies` variable
     */
    func fetchMovies() {
        let page = 1
        let observable = moviesService
            .fetchListMovies(page: page)
            .shareReplay(1)
        
        // Turn on isLoading when start request and then turn off after completed
        observable.map { _ in false }.startWith(true)
            .catchErrorJustReturn(false)
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        observable
            .subscribe(
                onNext: { [unowned self] movies in
                    self.movies.value = movies
                    self.currentPage.value = page
                },
                onError: { [unowned self] (error) in
                    self.alertMessage.value = error.localizedDescription
                }
            )
            .disposed(by: disposeBag)
    }
    
    /**
     Fetch more movies and append to `movies`
     */
    func fetchMore() {
        
        if isLoading.value  {
            return
        }
        
        let page = currentPage.value + 1
        
        // From API, 1 <= page <= 1000
        if page > 1000 {
            return
        }
        
        let observable = moviesService
            .fetchListMovies(page: page)
            .shareReplay(1)
        
        // Turn on isLoading when start request and then turn off after completed
        observable.map { _ in false }.startWith(true)
            .catchErrorJustReturn(false)
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        observable
            .subscribe(
                onNext: { [unowned self] movies in
                    self.movies.value.append(contentsOf: movies)
                    self.currentPage.value = page
                },
                onError: { [unowned self] (error) in
                    self.alertMessage.value = error.localizedDescription
                }
            )
            .disposed(by: disposeBag)
    }
}
