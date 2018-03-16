//
//  SettingsUtil.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 28..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class SettingsUtil {

    let defaults = UserDefaults.standard
    var localTimeZoneName: String { return TimeZone.current.identifier }
    let calendar = Calendar(identifier: .gregorian)

    func resolveDatePartBasedOnSettings(counter: Int) -> Date.DatePart {
        if let periodicitySetting = defaults.string(forKey: UserDefaults.Key.Lbl.periodicity) {
            switch periodicitySetting {
            case Periodicity.daily:
                return getDailyDatePart(counter: counter)
            case Periodicity.weekly:
                return getWeeklyDatePart(counter: counter)
            case Periodicity.monthly:
                return getMonthlyDatePart(counter: counter)
            default:
                print("Unexpected date identifier was given in: \(#file), line: \(#line)")
            }
        }
        return Date.DatePart()
    }

    func getDailyDatePart(counter: Int) -> Date.DatePart {
        let newDate = Date().add(days: counter)

        let dateComponents = calendar.dateComponents([.year, .month, .day], from: newDate)
        return dateComponents.datePart()
    }

    func getWeeklyDatePart(counter: Int) -> Date.DatePart {
        let newDate = Date().add(weeks: counter)

        let dateComponents = calendar.dateComponents([.year, .month, .day], from: newDate)
        return dateComponents.datePart()
    }

    func getMonthlyDatePart(counter: Int) -> Date.DatePart {
        let newDate = Date().add(months: counter)

        let dateComponents = calendar.dateComponents([.year, .month, .day], from: newDate)
        return dateComponents.datePart()
    }

    func resolveTimePartBasedOnSettings() -> Date.TimePart {
        if defaults.string(forKey: UserDefaults.Key.Lbl.time) == Time.atGivenTime {
            // At given time
            return getGivenTimeFromSettings()
        } else {
            // Random time / morning / afternoon / evening
            return getRandomTimeFromSettings()
        }
    }

    func getGivenTimeFromSettings() -> Date.TimePart {
        let hours = defaults.integer(forKey: UserDefaults.Key.Pck.timeHours)
        let minutes = defaults.integer(forKey: UserDefaults.Key.Pck.timeMinutes)

        return Date.TimePart(hour: hours, minute: minutes)
    }

    func getRandomTimeFromSettings() -> Date.TimePart {
        var hours = Int()
        var minutes = Int().randomNumberBetween(lower: 0, upper: 59)

        if let timeSetting = defaults.string(forKey: UserDefaults.Key.Lbl.time) {
            switch timeSetting {
            case Time.random:
                hours = Int().randomNumberBetween(lower: Time.Hour.morningStart, upper: Time.Hour.eveningEnd)
            case Time.morning:
                hours = Int().randomNumberBetween(lower: Time.Hour.morningStart, upper: Time.Hour.morningEnd)
            case Time.afternoon:
                hours = Int().randomNumberBetween(lower: Time.Hour.afternoonStart, upper: Time.Hour.afternoonEnd)
            case Time.evening:
                hours = Int().randomNumberBetween(lower: Time.Hour.eveningStart, upper: Time.Hour.eveningEnd)
            case Time.atGivenTime:
                hours = defaults.integer(forKey: UserDefaults.Key.Pck.timeHours)
                minutes = defaults.integer(forKey: UserDefaults.Key.Pck.timeMinutes)
            default:
                print("Unexpected time identifier was given in: \(#file), line: \(#line)")
            }
        }

        return Date.TimePart(hour: hours, minute: minutes)
    }

    func getDateIntervalForPartOfDaySettings() -> DateInterval {
        let dateNow = Date()
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: dateNow)
        var dateInterval = DateInterval()

        if let timeSetting = defaults.string(forKey: UserDefaults.Key.Lbl.time) {
            switch timeSetting {
            case Time.random:
                dateComponents.setValue(Time.Hour.morningStart, for: .hour)
                dateInterval.start = calendar.date(from: dateComponents)!

                dateComponents.setValue(Time.Hour.eveningEnd, for: .hour)
                dateInterval.end = calendar.date(from: dateComponents)!
            case Time.morning:
                dateComponents.setValue(Time.Hour.morningStart, for: .hour)
                dateInterval.start = calendar.date(from: dateComponents)!

                dateComponents.setValue(Time.Hour.morningEnd, for: .hour)
                dateInterval.end = calendar.date(from: dateComponents)!
            case Time.afternoon:
                dateComponents.setValue(Time.Hour.afternoonStart, for: .hour)
                dateInterval.start = calendar.date(from: dateComponents)!

                dateComponents.setValue(Time.Hour.afternoonEnd, for: .hour)
                dateInterval.end = calendar.date(from: dateComponents)!
            case Time.evening:
                dateComponents.setValue(Time.Hour.eveningStart, for: .hour)
                dateInterval.start = calendar.date(from: dateComponents)!

                dateComponents.setValue(Time.Hour.eveningEnd, for: .hour)
                dateInterval.end = calendar.date(from: dateComponents)!
            case Time.atGivenTime:
                dateComponents.setValue(defaults.integer(forKey: UserDefaults.Key.Pck.timeHours), for: .hour)
                dateInterval.start = calendar.date(from: dateComponents)!
                dateInterval.end = dateInterval.start
            default:
                print("Unexpected time identifier was given in: \(#file), line: \(#line)")
            }
        }

        return dateInterval
    }

    func getFreeTimeRatio() -> Double {
        let dateNow = Date()
        let dateInterval = getDateIntervalForPartOfDaySettings()
        var freeTimeRatio = Double()

        if dateNow > dateInterval.end || dateNow < dateInterval.start {
            freeTimeRatio = 1.0
        } else {
            let now = dateNow.timeIntervalSince1970
            let start = dateInterval.start.timeIntervalSince1970
            let end = dateInterval.end.timeIntervalSince1970
            freeTimeRatio = (end - now) / (end - start)
        }

        return freeTimeRatio
    }

    func getRecurranceNumber() -> Int {
        guard let recurranceSetting = defaults.string(forKey: UserDefaults.Key.Lbl.recurrence)?.cutLastCharacter() else {
            return 1
        }

        return recurranceSetting
    }

    func getRecurrenceNumberBasedOnFreeTimeRatio() -> Int {
        return Int((Double(getRecurranceNumber()) * getFreeTimeRatio()).rounded(.up))
    }

    func combineDatePartsToDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())

        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        dateComponents.hour = hour
        dateComponents.minute = minute

        return calendar.date(from: dateComponents)!
    }

}
