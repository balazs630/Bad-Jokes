//
//  JokeNotificationService.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit
import UserNotifications

protocol JokeNotificationServiceDelegate: class {
    func notificationDidFire()
}

class JokeNotificationService: NSObject, UNUserNotificationCenterDelegate {
    // MARK: Properties
    weak var delegate: JokeNotificationServiceDelegate?
    private var currentTimeZoneName: String { return TimeZone.current.identifier }
    private let jokeNotificationGenerator = JokeNotificationGenerator()
    private var jokeTypes: [String] = []
    private let notificationCenter = UNUserNotificationCenter.current()

    // MARK: Initializers
    override init() {
        super.init()
        requestNotificationCenterPermission()
    }
}

// MARK: Notification operations
extension JokeNotificationService {
    private func requestNotificationCenterPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (_, _) in }
        notificationCenter.delegate = self
    }

    func setNewRepeatingNotifications() {
        guard DBService.shared.unusedJokesCount() > 0 else { return }

        removeAllScheduledNotification()
        let notificationTimes = jokeNotificationGenerator.generateNotificationTimes()

        jokeTypes = jokeNotificationGenerator.makeJokeTypeProbabilityArray()
        guard !jokeTypes.isEmpty else { return }

        (0...notificationTimes.count - 1).forEach { index in
            addJokeNotificationRequest(on: notificationTimes[index])
        }
    }

    func removeAllScheduledNotification() {
        removeAllPendingNotificationRequests()
        DBService.shared.deleteAllSchedules()
    }

    private func addJokeNotificationRequest(on time: Date) {
        let content = setNotificationContent()
        let trigger = setNotificationTrigger(on: time)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        guard let jokeId = content.userInfo["jokeId"] as? Int else {
            return
        }

        notificationCenter.add(request, withCompletionHandler: nil)
        DBService.shared.insertNewScheduledJoke(with: jokeId, on: time.convertToUnixTimeStamp())
    }

    private func setNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        let type = jokeNotificationGenerator.generateAvailableJokeType(from: jokeTypes)
        let joke = generateRandomJoke(with: type)
        content.body = joke.jokeText.formatLineBreaks()
        content.sound = .default

        var userInfo: [String: Int] = [:]
        userInfo["jokeId"] = joke.jokeId
        content.userInfo = userInfo

        return content
    }

    private func setNotificationTrigger(on time: Date) -> UNCalendarNotificationTrigger {
        var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
        dateCompenents.timeZone = TimeZone(identifier: currentTimeZoneName)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)

        return trigger
    }

    func moveDeliveredJokesToJokeCollection() {
        let deliveredJokes = DBService.shared.getAllDeliveredSchedules()

        deliveredJokes.forEach { joke in
            DBService.shared.setJokeUsedAndDeliveredWith(jokeId: joke.jokeId, deliveryTime: joke.time)
            DBService.shared.deleteScheduleWith(jokeId: joke.jokeId)
        }
    }

    private func generateRandomJoke(with type: String) -> Joke {
        if let joke = DBService.shared.getRandomJoke(for: type) {
            return joke
        }

        let anyType = "%"
        return DBService.shared.getRandomJoke(for: anyType)!
    }
}

// MARK: UNUserNotificationCenter
extension JokeNotificationService {
    func removeAllPendingNotificationRequests() {
        notificationCenter.removeAllPendingNotificationRequests()
    }

    func isNotificationsEnabled(completed: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings(completionHandler: { settings in
            completed(settings.authorizationStatus == .authorized)
        })
    }
}
