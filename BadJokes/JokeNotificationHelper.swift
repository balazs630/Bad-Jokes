//
//  JokeNotificationHelper.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation
import UserNotifications

class JokeNotificationHelper: NSObject, UNUserNotificationCenterDelegate {

    var localTimeZoneName: String { return TimeZone.current.identifier }

    let defaults = UserDefaults.standard
    let plistFileManager = PlistFileManager()

    override init() {
        super.init()
        // Seeking permission of the user to display app notifications

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {_, _ in })
        UNUserNotificationCenter.current().delegate = self
    }

    func applyCurrentNotificationSettings() {
        if defaults.string(forKey: UserDefaultsKeys.Lbl.time) == Time.atGivenTime {
            // At given time
            let time = getGivenTime()
            if let recurranceString = defaults.string(forKey: UserDefaultsKeys.Lbl.recurrence) {
                let multiplier: Int = recurranceNumber(from: recurranceString)
                for i in 1...multiplier {
                    // Separate multiple notifications with 1 second difference
                    setNotification(for: time + TimeInterval(i))
                }
            }
        } else {
            // Random time / morning / afternoon / evening
            let timeInterval = getTimeInterval()
            let notificationTimes = generateNotificationTimesBetween(timeInterval.0, timeInterval.1)
            for time in notificationTimes {
                setNotification(for: time)
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // To display notifications when app is running  inforeground
        completionHandler([.alert, .sound])
    }

    private func setNotification(for time: Date) {
        // Setting content of the notification
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        content.badge = 1
        let type = getJokeType()
        content.body = plistFileManager.getRandomJokeWith(type: type)

        if defaults.bool(forKey: UserDefaultsKeys.Sw.notificationSound) {
            content.sound = UNNotificationSound.default()
        }

        // Setting time for notification trigger
        var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
        dateCompenents.timeZone = TimeZone(identifier: localTimeZoneName)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
        print("setNotification fromSettings, trigger: \(trigger)")
        print("")

        // Adding request
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    private func removeAllPendingNotificationRequests() {
        // Which are not delivered yet but scheduled
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    private func getGivenTime() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var timeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        timeComponents.timeZone = TimeZone(identifier: localTimeZoneName)

        timeComponents.hour = defaults.integer(forKey: UserDefaultsKeys.Pck.timeHours)
        timeComponents.minute = defaults.integer(forKey: UserDefaultsKeys.Pck.timeMinutes)
        print("getGivenTime(): timeComponents: \(timeComponents)")

        let time = calendar.date(from: timeComponents)!
        print("getGivenTime(): \(time)")
        print("")
        return time
    }

    private func getTimeInterval() -> (Date, Date) {
        var startTime = Date()
        var endTime = Date()

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = TimeZone(identifier: localTimeZoneName)

        if let timeSettings = defaults.string(forKey: UserDefaultsKeys.Lbl.time) {
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

    private func generateNotificationTimesBetween(_ startTime: Date, _ endTime: Date) -> [Date] {
        var notificationTimes = [Date]()

        if let recurranceString = defaults.string(forKey: UserDefaultsKeys.Lbl.recurrence) {
            let multiplier: Int = recurranceNumber(from: recurranceString)
            let intervalSeconds = endTime.timeIntervalSince(startTime)

            for _ in 1...multiplier {
                let randomSec = arc4random_uniform(UInt32(intervalSeconds))
                let randomTime: Date = startTime + TimeInterval(randomSec)
                notificationTimes.append(randomTime)
            }
        }

        return notificationTimes
    }

    private func recurranceNumber(from value: String) -> Int {
        // Cut down the last letter, e.x. 10x -> 10
        guard let recurranceNumber = Int(value.substring(to: value.index(before: value.endIndex))) else {
            return Int()
        }
        return recurranceNumber
    }

    private func getJokeType() -> String {
        var jokeType = generateJokeType()
        var n = 0
        while true {
            if plistFileManager.isAllJokeUsedWith(type: jokeType) {
                jokeType = generateJokeType()
                n += 1
            } else {
                break
            }

            // If it couldn't find a joke type from 100 tries that has unused jokes
            if n == 100 {
                if plistFileManager.isAllJokeUsed() {
                    plistFileManager.restoreUsedJokesAsNew()
                    jokeType = generateJokeType()
                } else {
                    jokeType = getLeftOverJokeType()
                }
                break
            }
        }

        return jokeType
    }

    private func generateJokeType() -> String {
        // TODO: Generate a joke type based on the sliders from the Settings screen
        return ""
    }

    private func getLeftOverJokeType() -> String {
        // TODO: Goes through each joke type and returns the first joke type that contains unused joke(s)
        return ""
    }

}
