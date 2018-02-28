//
//  JokeNotificationScheduler.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 22..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation
import UserNotifications

class JokeNotificationScheduler {

    var localTimeZoneName: String { return TimeZone.current.identifier }
    let defaults = UserDefaults.standard

    let dateUtil = DateUtil()

    func resolveNotificationTimeBasedOnSettings() -> Date {
        let time: Date
        if defaults.string(forKey: UserDefaults.Key.Lbl.time) == Time.atGivenTime {
            // At given time
            time = dateUtil.getGivenTime()
        } else {
            // Random time / morning / afternoon / evening
            let timeInterval = dateUtil.getTimeInterval()
            time = dateUtil.generateTimeBetween(timeInterval.0, timeInterval.1)
        }

        return time
    }

    func setNotificationTrigger(on time: Date) -> UNCalendarNotificationTrigger {
        // Setting time for notification trigger
        var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
        dateCompenents.timeZone = TimeZone(identifier: localTimeZoneName)

        // Adding request
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
        print("setNotification fromSettings, trigger: \(trigger)\n")

        return trigger
    }

}
