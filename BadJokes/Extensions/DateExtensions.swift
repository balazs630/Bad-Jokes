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
        Calendar(identifier: .gregorian).isDateInToday(self)
    }

    func isInPast() -> Bool {
        self < Date()
    }

    func isInFuture() -> Bool {
        self > Date()
    }

    func add(minutes: Int) -> Date {
        Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }

    func add(hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }

    func add(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    func add(weeks: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: 7 * weeks, to: self)!
    }

    func add(months: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: months, to: self)!
    }

    func convertToUnixTimeStamp() -> Int {
        Int(timeIntervalSince1970)
    }
}
