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
        Date(timeIntervalSince1970: self).timeIntervalSinceNow.sign == .minus
    }
}
