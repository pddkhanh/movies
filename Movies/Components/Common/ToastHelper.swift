//
//  ToastHelper.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import Toaster
import RxSwift

class ToastHelper {
    
    static func bindWith(_ observable: Observable<String>) -> Disposable {
        return observable
            .shareReplay(1)
            .observeOn(MainScheduler.instance)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { val in
                let toast = Toast(text: val)
                toast.show()
            })
    }
}
