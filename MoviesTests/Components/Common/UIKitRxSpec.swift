//
//  UIKitRxSpec.swift
//  MoviesTests
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import Movies

class UIKitRxSpec: QuickSpec {
    override func spec() {
        describe("UIKitRxSpec") {
            describe("UIViewController") {
                
                var testScheduler: TestScheduler!
                var disposeBag: DisposeBag!
                var vc: UIViewController!
                
                beforeEach {
                    vc = UIViewController()
                    testScheduler = TestScheduler(initialClock: 0)
                    disposeBag = DisposeBag()
                }
                
                it("can observe viewDidLoad") {
                    let observable = vc.rx.viewDidLoad
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    observable.map { true }.subscribe(observer)
                        .disposed(by: disposeBag)
                    
                    testScheduler.scheduleAt(300, action: {
                        vc.viewDidLoad()
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true)])
                }
                
                it("can observe viewDidAppear") {
                    let observable = vc.rx.viewDidAppear
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    observable.subscribe(observer)
                        .disposed(by: disposeBag)
                    
                    testScheduler.scheduleAt(300, action: {
                        vc.viewDidAppear(true)
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true)])
                }
                
                it("can observe viewWillAppear") {
                    let observable = vc.rx.viewWillAppear
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    observable.subscribe(observer)
                        .disposed(by: disposeBag)
                    
                    testScheduler.scheduleAt(300, action: {
                        vc.viewWillAppear(true)
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true)])
                }
            }
            
        }
    }
}
