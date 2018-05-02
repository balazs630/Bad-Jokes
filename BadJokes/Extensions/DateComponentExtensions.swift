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
        return Date.DatePart(year: self.year!, month: self.month!, day: self.day!)
    }
}
