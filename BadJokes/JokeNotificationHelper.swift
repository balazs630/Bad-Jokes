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
    func notificationDidFire()
}

class JokeNotificationHelper: NSObject, UNUserNotificationCenterDelegate {

    var localTimeZoneName: String { return TimeZone.current.identifier }

    weak var delegate: JokeNotificationHelperDelegate?

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
        delegate?.notificationDidFire()
    }

    func applyCurrentNotificationSettings() {
        // Schedule notification
        let content = jokeNotificationGenerator.setNotificationContent()
        let time = jokeNotificationScheduler.resolveNotificationTimeBasedOnSettings()
        let trigger = jokeNotificationScheduler.setNotificationTrigger(on: time)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        guard let jokeId = content.userInfo["jokeId"] as? Int else {
            return
        }

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        dbManager.insertNewScheduledJoke(with: jokeId, on: time.convertToUnixTimeStamp())
    }

    private func removeAllPendingNotificationRequests() {
        // Which are not delivered yet but scheduled
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

}
