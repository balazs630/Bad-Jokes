//
//  JokeNotificationHelper.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UserNotifications

protocol JokeNotificationHelperDelegate: class {
    func notificationDidFire()
}

class JokeNotificationHelper: NSObject, UNUserNotificationCenterDelegate {
    let defaults = UserDefaults.standard
    var localTimeZoneName: String { return TimeZone.current.identifier }
    weak var delegate: JokeNotificationHelperDelegate?

    let dbManager = DBManager()
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

    func applyNewNotificationSettings() {
        setNewRepeatingNotifications()
    }

    private func setNewRepeatingNotifications() {
        removeAllPendingNotificationRequests()
        dbManager.deleteAllSchedules()
        
        let notificationTimes = jokeNotificationGenerator.generateNotificationTimes()

        for i in 0...notificationTimes.count - 1 {
            addJokeNotificationRequest(on: notificationTimes[i])
        }
    }

    private func addJokeNotificationRequest(on time: Date) {
        let content = setNotificationContent()
        let trigger = setNotificationTrigger(on: time)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        guard let jokeId = content.userInfo["jokeId"] as? Int else {
            return
        }

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        dbManager.insertNewScheduledJoke(with: jokeId, on: time.convertToUnixTimeStamp())
    }

    func setNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        let type = jokeNotificationGenerator.generateJokeType()
        let joke = dbManager.getRandomJokeWith(type: type)
        content.body = joke.jokeText.formatLineBreaks()

        if defaults.bool(forKey: UserDefaults.Key.Sw.notificationSound) {
            content.sound = UNNotificationSound.default()
        }

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

    func checkForDeliveredJokes() {
        let scheduledJokesArray = dbManager.getAllSchedules()

        for scheduledJoke in scheduledJokesArray {
            if TimeInterval(scheduledJoke.time).isInPast() {
                dbManager.setJokeUsedAndStoredWith(jokeId: scheduledJoke.jokeId)
                dbManager.deleteScheduleWith(jokeId: scheduledJoke.jokeId)
            }
        }
    }

    private func removeAllPendingNotificationRequests() {
        // Which are not delivered yet but scheduled
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func isNotificationsEnabled(completed: @escaping (Bool) -> ()) {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .authorized {
                completed(true)
            } else {
                completed(false)
            }
        })
    }

    func isNotificationsPending(completed: @escaping (Bool) -> ()) {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            if requests.count > 0 {
                completed(true)
            } else {
                completed(false)
            }

        })
    }

}
