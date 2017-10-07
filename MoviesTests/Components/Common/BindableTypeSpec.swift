//
//  BindableTypeSpec.swift
//  MoviesTests
//
//  Created by Khanh Pham on 10/6/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
@testable import Movies

class SampleBindableViewController: UIViewController, BindableType {
    typealias ViewModelType = NSObject
    var viewModel: NSObject!
    
    func bindViewModel() {
        bindViewModelCalled = true
    }
    
    private(set) var bindViewModelCalled = false
}

class BindableTypeSpec: QuickSpec {
    override func spec() {
        describe("BindableTypeSpec") {
            describe("UIViewController: bindViewModel(to:)") {
                
                var vc:SampleBindableViewController!
                var vm: NSObject!
                
                beforeEach {
                    vc = SampleBindableViewController()
                    vm = NSObject()
                    vc.bindViewModel(to: vm)
                }
                
                it("should call bindViewModel") {
                    expect(vc.bindViewModelCalled).to(beTrue())
                }
                
                it("should has viewModel property is the correct value") {
                    expect(vc.viewModel).notTo(beNil())
                    expect(vc.viewModel).to(equal(vm))
                }
            }
        }
    }
}
