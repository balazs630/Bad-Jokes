//
//  JokeNotificationHelper.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation
import UserNotifications

protocol JokeNotificationHelperDelegate: class {
    func notificationDidFire(with jokeID: Int)
}

class JokeNotificationHelper: NSObject, UNUserNotificationCenterDelegate {

    var localTimeZoneName: String { return TimeZone.current.identifier }
    var nextJokeId = Int()
    
    weak var delegate: JokeNotificationHelperDelegate?

    let defaults = UserDefaults.standard
    let dbManager = DBManager()

    override init() {
        super.init()
        // Seeking permission of the user to display app notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {_, _ in })
        UNUserNotificationCenter.current().delegate = self
    }

    func applyCurrentNotificationSettings() {
        if defaults.string(forKey: UserDefaults.Key.Lbl.time) == Time.atGivenTime {
            // At given time
            let time = getGivenTime()
            setNotification(for: time)
        } else {
            // Random time / morning / afternoon / evening
            let timeInterval = getTimeInterval()
            let notificationTime = generateNotificationTimeBetween(timeInterval.0, timeInterval.1)
            setNotification(for: notificationTime)
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // To display notifications when app is running in foreground
        completionHandler([.alert, .sound])
        delegate?.notificationDidFire(with: nextJokeId)
    }

    private func setNotification(for time: Date) {
        // Setting content of the notification
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        content.badge = 1
        let type = getJokeType()
        let joke = dbManager.getRandomJokeWith(type: type)
        content.body = joke.jokeText.formatLineBreaks()
        nextJokeId = joke.id

        if defaults.bool(forKey: UserDefaults.Key.Sw.notificationSound) {
            content.sound = UNNotificationSound.default()
        }

        // Setting time for notification trigger
        var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
        dateCompenents.timeZone = TimeZone(identifier: localTimeZoneName)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
        print("setNotification fromSettings, trigger: \(trigger)\n")

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

        timeComponents.hour = defaults.integer(forKey: UserDefaults.Key.Pck.timeHours)
        timeComponents.minute = defaults.integer(forKey: UserDefaults.Key.Pck.timeMinutes)
        print("getGivenTime(): timeComponents: \(timeComponents)")

        let time = calendar.date(from: timeComponents)!
        print("getGivenTime(): \(time)\n")
        return time
    }

    private func getTimeInterval() -> (Date, Date) {
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

    private func generateNotificationTimeBetween(_ startTime: Date, _ endTime: Date) -> Date {
        let intervalSeconds = endTime.timeIntervalSince(startTime)
        let randomTime: Date = startTime + TimeInterval(intervalSeconds.randomSec())

        return randomTime
    }

    private func getJokeType() -> String {
        // Get a joke type and check if the type has unused joke(s)
        var jokeType = generateJokeType()
        var n = 0
        while true {
            if dbManager.isAllJokeUsedWith(type: jokeType) {
                jokeType = generateJokeType()
                n += 1
            } else {
                break
            }

            // If it couldn't find a joke type from 100 tries that has unused jokes
            if n == 100 {
                if dbManager.isAllJokeUsed() {
                    dbManager.restoreUsedJokesAsNew()
                    // Recursion
                    jokeType = getJokeType()
                } else {
                    jokeType = getLeftOverJokeType()
                }
                break
            }
        }

        print("getJokeType: \(jokeType)")
        return jokeType
    }

    private func generateJokeType() -> String {
        // Generate a joke type based on the sliders from the Settings screen
        var sldProbabilities = [String]()

        for slider in UserDefaults.Key.sldDictionaty {
            let sldValue = defaults.integer(forKey: slider.key)

            // Skip joke types with value 0
            if sldValue > 0 {
                for _ in 1...sldValue {
                    // Add the joke type to the array as many times as it's slider value (1-10)
                    sldProbabilities.append(slider.value)
                }
            }
        }

        // Retuns a random element from the array
        guard let randomItem = sldProbabilities.randomItem() else {
            return "Empty array!"
        }

        return randomItem
    }

    private func getLeftOverJokeType() -> String {
        // Goes through each joke type and returns the first joke type that contains unused joke(s)
        var type = String()

        for sld in UserDefaults.Key.sldDictionaty.values {
            if dbManager.isAllJokeUsedWith(type: sld) == false {
                type = sld
                break
            }
        }

        return type
    }
}
