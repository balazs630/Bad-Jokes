//
//  SettingsUtil.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 28..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class SettingsUtil {

    var localTimeZoneName: String { return TimeZone.current.identifier }
    let defaults = UserDefaults.standard

    func resolveDatePartBasedOnSettings(counter: Int) -> Date.DatePart {
        if let periodicitySettings = defaults.string(forKey: UserDefaults.Key.Lbl.periodicity) {
            switch periodicitySettings {
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

    private func getDailyDatePart(counter: Int) -> Date.DatePart {
        let dateNow = Date()
        let gregorian = Calendar(identifier: .gregorian)
        let newDate = dateNow.add(days: counter)

        let dateComponents = gregorian.dateComponents([.year, .month, .day], from: newDate)
        return dateComponents.datePart()
    }

    private func getWeeklyDatePart(counter: Int) -> Date.DatePart {
        let dateNow = Date()
        let gregorian = Calendar(identifier: .gregorian)
        let newDate = dateNow.add(weeks: counter)

        let dateComponents = gregorian.dateComponents([.year, .month, .day], from: newDate)
        return dateComponents.datePart()
    }

    private func getMonthlyDatePart(counter: Int) -> Date.DatePart {
        let dateNow = Date()
        let gregorian = Calendar(identifier: .gregorian)
        let newDate = dateNow.add(months: counter)

        let dateComponents = gregorian.dateComponents([.year, .month, .day], from: newDate)
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

    private func getGivenTimeFromSettings() -> Date.TimePart {
        let hours = defaults.integer(forKey: UserDefaults.Key.Pck.timeHours)
        let minutes = defaults.integer(forKey: UserDefaults.Key.Pck.timeMinutes)

        return Date.TimePart(hour: hours, minute: minutes)
    }

    private func getRandomTimeFromSettings() -> Date.TimePart {
        var hours = Int()
        let minutes = Int().randomNumberBetween(lower: 0, upper: 59)

        if let timeSettings = defaults.string(forKey: UserDefaults.Key.Lbl.time) {
            switch timeSettings {
            case Time.random:
                hours = Int().randomNumberBetween(lower: Time.Hour.morningStart, upper: Time.Hour.eveningEnd)
            case Time.morning:
                hours = Int().randomNumberBetween(lower: Time.Hour.morningStart, upper: Time.Hour.morningEnd)
            case Time.afternoon:
                hours = Int().randomNumberBetween(lower: Time.Hour.afternoonStart, upper: Time.Hour.afternoonEnd)
            case Time.evening:
                hours = Int().randomNumberBetween(lower: Time.Hour.eveningStart, upper: Time.Hour.eveningEnd)
            default:
                print("Unexpected time identifier was given in: \(#file), line: \(#line)")
            }
        }

        return Date.TimePart(hour: hours, minute: minutes)
    }

}
