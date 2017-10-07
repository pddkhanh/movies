//
//  LoadingIndicator.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import RxSwift

class LoadingIndicator {
    
    static let shared = LoadingIndicator()
    
    func show(color: UIColor? = .clear) {
        let actData = ActivityData(size: CGSize(width: 30, height: 30), color: color, backgroundColor: .clear)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(actData)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hide() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}


let loadingSize = CGSize(width: 30, height: 30)
let loadingColor = UIColor(white: 154.0/255, alpha: 1)

extension UIViewController {
    func bindAnimateWith(variable: Variable<Bool>, color: UIColor? = loadingColor) -> Disposable {
        
        return variable.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (loading) in
                if loading {
                    LoadingIndicator.shared.show(color: color)
                } else {
                    LoadingIndicator.shared.hide()
                }
            })
    }
}
