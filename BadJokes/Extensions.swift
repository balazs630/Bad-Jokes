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
    func randomDatePartBetween(lower: Date, upper: Date) -> Date.DatePart {
        let startTimeStamp = UInt32(lower.timeIntervalSince1970)
        let endTimeStamp = UInt32(upper.timeIntervalSince1970)

        let randomTimeStamp = arc4random_uniform(endTimeStamp - startTimeStamp) + startTimeStamp
        let randomDate = Date(timeIntervalSince1970: TimeInterval(randomTimeStamp))

        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: randomDate)
        return dateComponents.datePart()
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
