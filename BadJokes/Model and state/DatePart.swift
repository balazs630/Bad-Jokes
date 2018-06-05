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
        var year: Int = 1970
        var month: Int = 1
        var day: Int = 1

        init(year: Int, month: Int, day: Int) {
            self.year = year
            self.month = month
            self.day = day
        }
    }
}
