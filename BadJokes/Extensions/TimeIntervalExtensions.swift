//
//  TimeIntervalExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 05. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

extension TimeInterval {
    func isInPast() -> Bool {
        let date = Date(timeIntervalSince1970: self)
        return date.timeIntervalSinceNow.sign == .minus ? true : false
    }
}
