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
        DBManager.shared.deleteAllSchedules()

        let notificationTimes = self.jokeNotificationGenerator.generateNotificationTimes()

        for i in 0...notificationTimes.count - 1 {
            self.addJokeNotificationRequest(on: notificationTimes[i])
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
        DBManager.shared.insertNewScheduledJoke(with: jokeId, on: time.convertToUnixTimeStamp())
    }

    func setNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        let type = jokeNotificationGenerator.generateJokeType()
        let joke = DBManager.shared.getRandomJokeWith(type: type)
        content.body = joke.jokeText.formatLineBreaks()
        content.sound = UNNotificationSound.default()

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
        let scheduledJokesArray = DBManager.shared.getAllSchedules()

        for scheduledJoke in scheduledJokesArray {
            if TimeInterval(scheduledJoke.time).isInPast() {
                DBManager.shared.setJokeUsedAndDeliveredWith(jokeId: scheduledJoke.jokeId, deliveryTime: scheduledJoke.time)
                DBManager.shared.deleteScheduleWith(jokeId: scheduledJoke.jokeId)
            }
        }
    }

    func removeAllPendingNotificationRequests() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func isNotificationsEnabled(completed: @escaping (Bool) -> Void) {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { settings in
            completed(settings.authorizationStatus == .authorized)
        })
    }

    func isNotificationsPending(completed: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            completed(requests.count > 0)
        })
    }

}
