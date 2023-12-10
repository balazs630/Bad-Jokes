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
    private let defaults = UserDefaults.standard
    private var localTimeZoneName: String { return TimeZone.current.identifier }
    private let calendar = Calendar(identifier: .gregorian)

    // MARK: - Date/Time operations
    func getGeneratedNotificationTimeBetween(_ startDate: Date, _ endDate: Date) -> Date {
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
        var hours = 0
        var minutes = Int.random(in: 0...59)

        if let timeSetting = defaults.string(forKey: UserDefaults.Key.Label.time),
            let timeRange = TimeRange(rawValue: timeSetting) {

            switch timeRange {
            case .random, .morning, .afternoon, .evening:
                hours = Int.random(in: timeRange.intervallum)
            case .atGivenTime:
                hours = defaults.integer(forKey: UserDefaults.Key.Picker.timeHours)
                minutes = defaults.integer(forKey: UserDefaults.Key.Picker.timeMinutes)
            }
        }

        return Date.TimePart(hour: hours, minute: minutes)
    }

    func getRecurranceNumber() -> Int {
        return defaults.string(forKey: UserDefaults.Key.Label.recurrence)?.digits() ?? 1
    }

    func isPunctualTimeSet() -> Bool {
        guard let timeSetting = defaults.string(forKey: UserDefaults.Key.Label.time),
              let timeRange = TimeRange(rawValue: timeSetting)
        else { return false }

        return timeRange == .atGivenTime
    }

    func incrementDateBasedOnPeriodSetting(date: Date) -> Date {
        guard let periodicitySetting = defaults.string(forKey: UserDefaults.Key.Label.periodicity),
              let periodicity = Periodicity(rawValue: periodicitySetting)
        else {
            return date
        }

        switch periodicity {
        case .daily:
            return date
        case .weekly:
            return date.add(days: 6)
        case .monthly:
            return date.add(days: 30)
        }
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

        if let timeSetting = defaults.string(forKey: UserDefaults.Key.Label.time),
            let timeRange = TimeRange(rawValue: timeSetting) {

            switch timeRange {
            case .random, .morning, .afternoon, .evening:
                dateComponents.hour = timeRange.intervallum.upperBound
            case .atGivenTime:
                dateComponents.hour = defaults.integer(forKey: UserDefaults.Key.Picker.timeHours)
                dateComponents.minute = defaults.integer(forKey: UserDefaults.Key.Picker.timeMinutes)
            }
        }

        return calendar.date(from: dateComponents)!
    }
}
