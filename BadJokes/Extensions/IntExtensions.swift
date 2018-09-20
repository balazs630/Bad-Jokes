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
        let result = Int.random(in: lower...upper)
        return result
    }
}
