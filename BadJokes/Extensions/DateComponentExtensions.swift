//
//  DateComponentExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 05. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

extension DateComponents {
    func datePart() -> Date.DatePart {
        Date.DatePart(year: year!, month: month!, day: day!)
    }
}
