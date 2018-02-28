//
//  DateUtil.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 28..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class DateUtil {

    var localTimeZoneName: String { return TimeZone.current.identifier }
    let defaults = UserDefaults.standard

    func getGivenTime() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var timeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        timeComponents.timeZone = TimeZone(identifier: localTimeZoneName)

        timeComponents.hour = defaults.integer(forKey: UserDefaults.Key.Pck.timeHours)
        timeComponents.minute = defaults.integer(forKey: UserDefaults.Key.Pck.timeMinutes)
        print("getGivenTime(): timeComponents: \(timeComponents)")

        let time = calendar.date(from: timeComponents)!
        print("getGivenTime(): \(time)\n")
        return time
    }

    func getTimeInterval() -> (Date, Date) {
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

    func generateTimeBetween(_ startTime: Date, _ endTime: Date) -> Date {
        let intervalSeconds = endTime.timeIntervalSince(startTime)
        let randomTime: Date = startTime + TimeInterval(intervalSeconds.randomSec())

        return randomTime
    }
    
}
