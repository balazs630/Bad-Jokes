//
//  IntExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 05. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

extension Int {
    func randomNumberBetween(lower: Int, upper: Int) -> Int {
        let result = Int(arc4random_uniform(UInt32(upper - lower)) + UInt32(lower))
        return result
    }
}
