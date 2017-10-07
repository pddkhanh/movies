//
//  UtilSpec.swift
//  MoviesTests
//
//  Created by Khanh Pham on 10/7/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble

@testable import Movies

class UtilSpec: QuickSpec {
    override func spec() {
        describe("UtilSpec") {
            it("hourMinuteFormatted shoult work correctly") {
                expect(40.hourMinuteFormatted).to(equal("40m"))
                expect(60.hourMinuteFormatted).to(equal("1h"))
                expect(135.hourMinuteFormatted).to(equal("2h 15m"))
            }
        }
    }
}
