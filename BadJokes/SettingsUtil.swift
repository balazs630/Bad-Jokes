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
        let gregorian = Calendar(identifier: .gregorian)

        let now = Date()
        var startComponents = gregorian.dateComponents([.year, .month, .day], from: now)
        var endComponents = gregorian.dateComponents([.year, .month, .day], from: now)

        if let timeSettings = defaults.string(forKey: UserDefaults.Key.Lbl.time) {
            switch timeSettings {
            case Time.random:
                startComponents.hour = Time.Hour.morningStart
                endComponents.hour = Time.Hour.nightStart
            case Time.morning:
                startComponents.hour = Time.Hour.morningStart
                endComponents.hour = Time.Hour.afternoonStart
            case Time.afternoon:
                startComponents.hour = Time.Hour.afternoonStart
                endComponents.hour = Time.Hour.eveningStart
            case Time.evening:
                startComponents.hour = Time.Hour.eveningStart
                endComponents.hour = Time.Hour.nightStart
            default:
                print("Unexpected time identifier was given in: \(#file), line: \(#line)")
            }
        }

        return (gregorian.date(from: startComponents)!,
                gregorian.date(from: endComponents)!)
    }

    private func getRandomTimeBetweenTwoDate(_ startTime: Date, _ endTime: Date) -> Date {
        let intervalSeconds = endTime.timeIntervalSince(startTime)
        let randomTime: Date = startTime + TimeInterval(intervalSeconds.randomSec())

        return randomTime
    }
    
}
