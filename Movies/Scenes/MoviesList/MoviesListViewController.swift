//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MoviesListViewController: UIViewController, BindableType, UITableViewDelegate {
    
    typealias ViewModelType = MoviesListViewModel
    
    var refreshControl: UIRefreshControl!
    
    var viewModel: MoviesListViewModel!
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
//        let vm = MoviesListViewModel(moviesService: AppComponents.shared.moviesService)
//        bindViewModel(to: vm)
        
    }
    
    func bindViewModel() {
        // Bind data sources to table view
        viewModel.movies
            .asObservable()
            .observeOnMain()
            .bind(to: tableView.rx.items(cellIdentifier: "MovieCell", cellType: MovieTableViewCell.self)) { _, model, cell in
                cell.configure(withModel: model)
            }
            .disposed(by: disposeBag)
        
        // Fetch data when appear
        rx.viewWillAppear
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.fetchMovies()
            })
            .disposed(by: disposeBag)
        
        // Show alert if any
        ToastHelper
            .bindWith(viewModel.alertMessage.asObservable())
            .disposed(by: disposeBag)
        
        // Show indicator when loading
        bindAnimateWith(variable: viewModel.isLoading)
            .disposed(by: disposeBag)
        
        // Pull to refresh
        let refreshObservable = refreshControl.rx.controlEvent(.valueChanged)
            .asObservable()
            .shareReplay(1)
        
        refreshObservable
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.fetchMovies()
            })
            .disposed(by: disposeBag)
        
        refreshObservable
            .delay(0.2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (_) in
                self.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            guard let vc = segue.destination as? MovieDetailViewController else {
                return
            }
            
            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            
            let movies = viewModel.movies.value
            if indexPath.row < 0 || indexPath.row >= movies.count {
                return
            }
            
            let vm = MovieDetailViewModel(movie: movies[indexPath.row], moviesService: AppComponents.shared.moviesService)
            vc.bindViewModel(to: vm)
        }
    }
    
    // MARK: - Private
    
    private func setupViews() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        
        tableView.delegate = self
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movies.value.count - 1 {
            viewModel.fetchMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

