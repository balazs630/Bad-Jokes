//
//  DateExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 05. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

extension Date {
    func isToday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.isDateInToday(self) ? true : false
    }

    func isInPast() -> Bool {
        return self < Date() ? true : false
    }

    func isInFuture() -> Bool {
        return self > Date() ? true : false
    }

    func add(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }

    func add(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }

    func add(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    func add(weeks: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: 7 * weeks, to: self)!
    }

    func add(months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: months, to: self)!
    }

    func convertToUnixTimeStamp() -> Int {
        return Int(self.timeIntervalSince1970)
    }
}
