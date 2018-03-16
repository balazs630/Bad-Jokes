//
//  Extensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

extension String {
    func formatLineBreaks() -> String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }

    func cutLastCharacter() -> Int {
        // Cut down the last letter, e.x. 10x -> 10 and returns as an Int
        let splitIndex = index(before: endIndex)
        guard let number = Int(self.prefix(upTo: splitIndex)) else {
            return 1
        }

        return number
    }
}

extension UserDefaults {
    func printAllUserDefaulsKeysAndValues() {
        // For debug purpose
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        print("=========================================================")
    }
}

extension Array {
    func randomIndex() -> Int? {
        if self.isEmpty {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return index
    }

    func randomItem() -> Element? {
        if self.isEmpty {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension Int {
    func randomNumberBetween(lower: Int, upper: Int) -> Int {
        let result = Int(arc4random_uniform(UInt32(upper - lower)) + UInt32(lower))
        return result
    }
}

extension TimeInterval {
    func isInPast() -> Bool {
        let date = Date(timeIntervalSince1970: self)
        return date.timeIntervalSinceNow.sign == .minus ? true : false
    }
}

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

extension DateComponents {
    func datePart() -> Date.DatePart {
        return Date.DatePart(year: self.year!, month: self.month!, day: self.day!)
    }
}
