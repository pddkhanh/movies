//
//  UIKit+Rx.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


extension Reactive where Base: UIViewController {
    
    var viewDidLoad: Observable<Void> {
        return self.sentMessage(#selector(Base.viewDidLoad)).map { _ in () }
    }
    
    var viewDidAppear: Observable<Bool> {
        return self.sentMessage(#selector(Base.viewDidAppear(_:))).map { args in
            let animated = (args.first as? Bool) ?? false
            return animated
        }
    }
    
    var viewWillAppear: Observable<Bool> {
        return self.sentMessage(#selector(Base.viewWillAppear(_:))).map { args in
            let animated = (args.first as? Bool) ?? false
            return animated
        }
    }
}
