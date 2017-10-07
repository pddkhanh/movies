//
//  Util.swift
//  Movies
//
//  Created by Khanh Pham on 10/7/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation

extension Int {
    var hourMinuteFormatted: String {
        let h = self / 60
        let m = self % 60
        if h > 0 {
            if m > 0 {
                return "\(h)h \(m)m"
            } else {
                return "\(h)h"
            }
        } else {
            return "\(m)m"
        }
    }
}
