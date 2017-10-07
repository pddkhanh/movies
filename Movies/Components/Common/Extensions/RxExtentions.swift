//
//  RxExtentions.swift
//  Movies
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType {
    
    public func observeOnMain() -> RxSwift.Observable<Self.E> {
        return observeOn(MainScheduler.instance)
    }
    
    public func ignoreValue() -> Observable<Void> {
        return map { _ in () }
    }
    
    /**
     Create Observable that emmit element after delay dueTime
     */
    public static func just(_ element: Self.E, dueTime: RxTimeInterval, scheduler: SchedulerType = MainScheduler.instance) -> Observable<Self.E> {
        return Observable<Int>.timer(dueTime, scheduler: scheduler)
            .map { _ in element }
    }
    
    /**
     Create Observable that emmit error after delay dueTime
     */
    public static func error(_ error: Error, dueTime: RxTimeInterval, scheduler: SchedulerType = MainScheduler.instance) -> Observable<Self.E> {
        return Observable<Int>.timer(dueTime, scheduler: scheduler)
            .flatMap { _ in Observable<Self.E>.error(error) }
    }
    
}

extension ObserverType {
    public func onNextAndCompleted(_ element: Self.E) {
        onNext(element)
        onCompleted()
    }
}
