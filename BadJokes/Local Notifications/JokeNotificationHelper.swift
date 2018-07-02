//
//  JokeNotificationHelper.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit
import UserNotifications

protocol JokeNotificationHelperDelegate: class {
    func notificationDidFire()
}

class JokeNotificationHelper: NSObject, UNUserNotificationCenterDelegate {

    // MARK: Properties
    let defaults = UserDefaults.standard
    var localTimeZoneName: String { return TimeZone.current.identifier }
    weak var delegate: JokeNotificationHelperDelegate?
    let jokeNotificationGenerator = JokeNotificationGenerator()
    var jokeTypes = [String]()

    // MARK: Initializers
    override init() {
        super.init()
        // Seeking permission of the user to display app notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (_, _) in }
        UNUserNotificationCenter.current().delegate = self
    }
}

// MARK: Notification operations
extension JokeNotificationHelper {
    func setNewRepeatingNotifications() {
        guard DBManager.shared.unusedJokesCount() > 0 else {
            return
        }

        removeAllScheduledNotification()
        let notificationTimes = jokeNotificationGenerator.generateNotificationTimes()

        jokeTypes = jokeNotificationGenerator.makeJokeTypeProbabilityArray()
        for index in 0...notificationTimes.count - 1 {
            self.addJokeNotificationRequest(on: notificationTimes[index])
        }
    }

    func removeAllScheduledNotification() {
        removeAllPendingNotificationRequests()
        DBManager.shared.deleteAllSchedules()
    }

    private func addJokeNotificationRequest(on time: Date) {
        let content = setNotificationContent()
        let trigger = setNotificationTrigger(on: time)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        guard let jokeId = content.userInfo["jokeId"] as? Int else {
            return
        }

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        DBManager.shared.insertNewScheduledJoke(with: jokeId, on: time.convertToUnixTimeStamp())
    }

    private func setNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        let type = jokeNotificationGenerator.generateAvailableJokeType(from: jokeTypes)
        let joke = DBManager.shared.getRandomJokeWith(type: type)
        content.body = joke.jokeText.formatLineBreaks()
        content.sound = UNNotificationSound.default()
        content.badge = incrementNotificationBadgeNumber(by: 1)

        var userInfo = [String: Int]()
        userInfo["jokeId"] = joke.jokeId
        content.userInfo = userInfo

        return content
    }

    private func setNotificationTrigger(on time: Date) -> UNCalendarNotificationTrigger {
        // Setting time for notification trigger
        var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
        dateCompenents.timeZone = TimeZone(identifier: localTimeZoneName)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)

        return trigger
    }

    func moveDeliveredJokesToJokeCollection() {
        let deliveredJokes = DBManager.shared.getAllDeliveredSchedules()

        for joke in deliveredJokes {
            DBManager.shared.setJokeUsedAndDeliveredWith(jokeId: joke.jokeId, deliveryTime: joke.time)
            DBManager.shared.deleteScheduleWith(jokeId: joke.jokeId)
        }
    }

    private func incrementNotificationBadgeNumber(by value: Int) -> NSNumber {
        let actualBadgeNumber = defaults.integer(forKey: UserDefaults.Key.badgeNumber)
        defaults.set(actualBadgeNumber + value, forKey: UserDefaults.Key.badgeNumber)
        return NSNumber(value: actualBadgeNumber + value)
    }
}

// MARK: UNUserNotificationCenter
extension JokeNotificationHelper {
    func removeAllPendingNotificationRequests() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func isNotificationsEnabled(completed: @escaping (Bool) -> Void) {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { settings in
            completed(settings.authorizationStatus == .authorized)
        })
    }

    func areNotificationsPending(completed: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            completed(requests.count > 0)
        })
    }
}
