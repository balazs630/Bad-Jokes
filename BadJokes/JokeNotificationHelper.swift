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
    let jokeNotificationScheduler = JokeNotificationScheduler()
    let jokeNotificationGenerator = JokeNotificationGenerator()

    override init() {
        super.init()
        // Seeking permission of the user to display app notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {_, _ in })
        UNUserNotificationCenter.current().delegate = self
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // To display notifications when app is running in foreground
        completionHandler([.alert, .sound])
        delegate?.notificationDidFire(with: nextJokeId)
    }

    func applyCurrentNotificationSettings() {
        if defaults.string(forKey: UserDefaults.Key.Lbl.time) == Time.atGivenTime {
            // At given time
            let time = jokeNotificationScheduler.getGivenTime()
            scheduleNotification(for: time)
        } else {
            // Random time / morning / afternoon / evening
            let timeInterval = jokeNotificationScheduler.getTimeInterval()
            let notificationTime = jokeNotificationScheduler.generateNotificationTimeBetween(timeInterval.0, timeInterval.1)
            scheduleNotification(for: notificationTime)
        }
    }

    private func removeAllPendingNotificationRequests() {
        // Which are not delivered yet but scheduled
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    private func scheduleNotification(for time: Date) {
        let content = setNotificationContent()

        let trigger = jokeNotificationScheduler.setNotificationTrigger(on: time)
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    private func setNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        content.badge = 1
        let type = jokeNotificationGenerator.getJokeType()
        let joke = dbManager.getRandomJokeWith(type: type)
        content.body = joke.jokeText.formatLineBreaks()
        nextJokeId = joke.jokeId

        if defaults.bool(forKey: UserDefaults.Key.Sw.notificationSound) {
            content.sound = UNNotificationSound.default()
        }

        return content
    }

}
