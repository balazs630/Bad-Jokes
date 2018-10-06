//
//  DateUtil.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 28..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class DateUtil {

    // MARK: Properties
    let defaults = UserDefaults.standard
    var localTimeZoneName: String { return TimeZone.current.identifier }
    let calendar = Calendar(identifier: .gregorian)

    // MARK: - Date/Time operations
    func getGeneratedNotificationTimeBetween(startDate: Date, endDate: Date) -> Date {
        let datePart = randomDatePartBetween(lower: startDate, upper: endDate)
        let timePart = randomTimeFromSettings()

        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())

        dateComponents.year = datePart.year
        dateComponents.month = datePart.month
        dateComponents.day = datePart.day

        dateComponents.hour = timePart.hour
        dateComponents.minute = timePart.minute

        return calendar.date(from: dateComponents)!
    }

    private func randomDatePartBetween(lower: Date, upper: Date) -> Date.DatePart {
        let startTimeStamp = UInt32(lower.timeIntervalSince1970)
        let endTimeStamp = UInt32(upper.timeIntervalSince1970)

        let randomTimeStamp = UInt32.random(in: startTimeStamp...endTimeStamp)
        let randomDate = Date(timeIntervalSince1970: TimeInterval(randomTimeStamp))

        let dateComponents = calendar.dateComponents([.year, .month, .day], from: randomDate)
        return dateComponents.datePart()
    }

    private func randomTimeFromSettings() -> Date.TimePart {
        var hours = Int()
        var minutes = Int.random(in: 0...59)

        if let timeSetting = defaults.string(forKey: UserDefaults.Key.Lbl.time) {
            switch timeSetting {
            case Time.random:
                hours = Int.random(in: Time.Hour.morningStart...Time.Hour.eveningEnd)
            case Time.morning:
                hours = Int.random(in: Time.Hour.morningStart...Time.Hour.morningEnd)
            case Time.afternoon:
                hours = Int.random(in: Time.Hour.afternoonStart...Time.Hour.afternoonEnd)
            case Time.evening:
                hours = Int.random(in: Time.Hour.eveningStart...Time.Hour.eveningEnd)
            case Time.atGivenTime:
                hours = defaults.integer(forKey: UserDefaults.Key.Pck.timeHours)
                minutes = defaults.integer(forKey: UserDefaults.Key.Pck.timeMinutes)
            default:
                debugPrint("Unexpected time identifier was given in: \(#file), line: \(#line)")
            }
        }

        return Date.TimePart(hour: hours, minute: minutes)
    }

    func getRecurranceNumber() -> Int {
        guard let recurrance = defaults.string(forKey: UserDefaults.Key.Lbl.recurrence)?.cutLastCharacter() else {
            return 1
        }

        return recurrance
    }

    func isPunctualTimeSet() -> Bool {
        let timeSetting = defaults.string(forKey: UserDefaults.Key.Lbl.time)
        return timeSetting == Time.atGivenTime
    }

    func incrementDateBasedOnPeriodSetting(date: Date) -> Date {
        let periodicitySetting = defaults.string(forKey: UserDefaults.Key.Lbl.periodicity)

        switch periodicitySetting {
        case Periodicity.daily:
            return date
        case Periodicity.weekly:
            return date.add(days: 6)
        case Periodicity.monthly:
            return date.add(days: 30)
        default:
            debugPrint("Unexpected periodicity identifier was given in: \(#file), line: \(#line)")
        }

        return date
    }

    func isNotificationCanBeSetFor(date: Date) -> Bool {
        if date.isToday() && (date > getLastNotificationTimeForToday()) {
            return false
        }

        return true
    }

    private func getLastNotificationTimeForToday() -> Date {
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        dateComponents.minute = 0

        if let timeSetting = defaults.string(forKey: UserDefaults.Key.Lbl.time) {
            switch timeSetting {
            case Time.random:
                dateComponents.hour = Time.Hour.eveningEnd
            case Time.morning:
                dateComponents.hour = Time.Hour.morningEnd
            case Time.afternoon:
                dateComponents.hour = Time.Hour.afternoonEnd
            case Time.evening:
                dateComponents.hour = Time.Hour.eveningEnd
            case Time.atGivenTime:
                dateComponents.hour = defaults.integer(forKey: UserDefaults.Key.Pck.timeHours)
                dateComponents.minute = defaults.integer(forKey: UserDefaults.Key.Pck.timeMinutes)
            default:
                debugPrint("Unexpected time identifier was given in: \(#file), line: \(#line)")
            }
        }

        return calendar.date(from: dateComponents)!
    }

}
