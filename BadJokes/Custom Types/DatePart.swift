//
//  Date&Time.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

extension Date {
    class DatePart {
        var year: Int
        var month: Int
        var day: Int

        init(year: Int = 1970, month: Int = 1, day: Int = 1) {
            self.year = year
            self.month = month
            self.day = day
        }
    }
}
