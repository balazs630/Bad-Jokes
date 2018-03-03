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
    let maxLocalNotificationCount = 64

    weak var delegate: JokeNotificationHelperDelegate?

    let dbManager = DBManager()
    let jokeNotificationGenerator = JokeNotificationGenerator()
    let settingsUtil = SettingsUtil()

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
        setRepeatingNotifications()
    }

    private func setRepeatingNotifications() {
        let notificationTimes = generateNotificationTimes()

        guard notificationTimes.count == maxLocalNotificationCount else {
            return
        }

        for i in 0...maxLocalNotificationCount - 1 {
            addJokeNotificationRequest(on: notificationTimes[i])
        }
    }

    private func generateNotificationTimes() -> [Date] {
        var notificationTimesArray = [Date]()
        let gregorian = Calendar(identifier: .gregorian)

        for i in 0...maxLocalNotificationCount - 1 {
            var dateComponents = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: Date())

            let datePart = settingsUtil.resolveDatePartBasedOnSettings(counter: i)
            dateComponents.year = datePart.year
            dateComponents.month = datePart.month
            dateComponents.day = datePart.day

            let timePart = settingsUtil.resolveTimePartBasedOnSettings()
            dateComponents.hour = timePart.hour
            dateComponents.minute = timePart.minute

            let notificationTime = gregorian.date(from: dateComponents)!
            notificationTimesArray.append(notificationTime)
        }

        return notificationTimesArray
    }

    private func addJokeNotificationRequest(on time: Date) {
        let content = jokeNotificationGenerator.setNotificationContent()
        let trigger = setNotificationTrigger(on: time)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        guard let jokeId = content.userInfo["jokeId"] as? Int else {
            return
        }

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        dbManager.insertNewScheduledJoke(with: jokeId, on: time.convertToUnixTimeStamp())
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

}
