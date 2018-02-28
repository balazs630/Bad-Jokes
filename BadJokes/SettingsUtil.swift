//
//  DateUtil.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 28..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class SettingsUtil {

    var localTimeZoneName: String { return TimeZone.current.identifier }
    let defaults = UserDefaults.standard

    func resolveNotificationTimeBasedOnSettings() -> Date {
        let time: Date
        if defaults.string(forKey: UserDefaults.Key.Lbl.time) == Time.atGivenTime {
            // At given time
            time = getGivenTimeFromSettings()
        } else {
            // Random time / morning / afternoon / evening
            let timeInterval = getTimeIntervalFromSettings()
            time = getRandomTimeBetweenTwoDate(timeInterval.0, timeInterval.1)
        }

        return time
    }

    private func getGivenTimeFromSettings() -> Date {
        // Get time from settings
        let calendar = Calendar(identifier: .gregorian)
        var timeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        timeComponents.timeZone = TimeZone(identifier: localTimeZoneName)

        timeComponents.hour = defaults.integer(forKey: UserDefaults.Key.Pck.timeHours)
        timeComponents.minute = defaults.integer(forKey: UserDefaults.Key.Pck.timeMinutes)

        let time = calendar.date(from: timeComponents)!
        
        return time
    }

    private func getTimeIntervalFromSettings() -> (Date, Date) {
        var startTime = Date()
        var endTime = Date()

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = TimeZone(identifier: localTimeZoneName)

        if let timeSettings = defaults.string(forKey: UserDefaults.Key.Lbl.time) {
            switch timeSettings {
            case Time.random:
                startTime = timeFormatter.date(from: Time.Hour.morningStart)!
                endTime = timeFormatter.date(from: Time.Hour.nightStart)!
            case Time.morning:
                startTime = timeFormatter.date(from: Time.Hour.morningStart)!
                endTime = timeFormatter.date(from: Time.Hour.afternoonStart)!
            case Time.afternoon:
                startTime = timeFormatter.date(from: Time.Hour.afternoonStart)!
                endTime = timeFormatter.date(from: Time.Hour.eveningStart)!
            case Time.evening:
                startTime = timeFormatter.date(from: Time.Hour.eveningStart)!
                endTime = timeFormatter.date(from: Time.Hour.nightStart)!
            default:
                print("Unexpected time identifier was given in: \(#file), line: \(#line)")
            }
        }

        return (startTime, endTime)
    }

    private func getRandomTimeBetweenTwoDate(_ startTime: Date, _ endTime: Date) -> Date {
        let intervalSeconds = endTime.timeIntervalSince(startTime)
        let randomTime: Date = startTime + TimeInterval(intervalSeconds.randomSec())

        return randomTime
    }
    
}
