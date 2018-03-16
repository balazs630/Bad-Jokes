//
//  JokeNotificationGenerator.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 22..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation
import UserNotifications

class JokeNotificationGenerator {
    let defaults = UserDefaults.standard
    let maxLocalNotificationCount = 64

    let dbManager = DBManager()
    let settingsUtil = SettingsUtil()

    func generateNotificationTimes() -> [Date] {
        var notificationTimesArray = [Date]()

        var startDate = Date()
        var endDate = Date().add(days: -1)
        var cycleCounter = 0
        while notificationTimesArray.count < maxLocalNotificationCount {
            startDate = endDate.add(days: 1)
            endDate = settingsUtil.incrementDateBasedOnPeriodSetting(date: startDate)

            if settingsUtil.isPunctualTimeSet() {
                var recurranceValue = settingsUtil.getRecurranceNumber()
                while recurranceValue > 0 {
                    if notificationTimesArray.count == maxLocalNotificationCount {
                        break
                    }

                    let notificationTime = settingsUtil.getGeneratedNotificationTimeBetween(startDate: startDate, endDate: endDate)
                    if notificationTime.isInFuture() {
                        notificationTimesArray.append(notificationTime)
                        recurranceValue -= 1
                    } else {
                        break
                    }
                }
            } else {
                var recurranceValue = settingsUtil.getRecurrenceNumberBasedOnFreeTimeRatio()
                while recurranceValue > 0 {
                    if cycleCounter == 0 {
                        if !settingsUtil.isNotificationCanBeSetFor(date: endDate) {
                            break
                        }
                    }

                    var notificationTime = Date(timeIntervalSince1970: 0)
                    while notificationTime.isInPast() {
                        if notificationTimesArray.count == maxLocalNotificationCount {
                            break
                        }

                        notificationTime = settingsUtil.getGeneratedNotificationTimeBetween(startDate: startDate, endDate: endDate)
                        if notificationTime.isInFuture() {
                            notificationTimesArray.append(notificationTime)
                            recurranceValue -= 1
                        }
                    }

                    if notificationTimesArray.count == maxLocalNotificationCount {
                        break
                    }
                }
            }
            cycleCounter += 1
        }

        return notificationTimesArray
    }

    func setNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        content.badge = 1
        let type = generateJokeType()
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

    private func generateJokeType() -> String {
        // Get a joke type and check if the type has unused joke(s)
        var jokeType = getRandomJokeType()
        var n = 0
        while true {
            if dbManager.isAllJokeUsedWith(type: jokeType) {
                jokeType = getRandomJokeType()
                n += 1
            } else {
                break
            }

            // If it couldn't find a joke type from 100 tries that has unused jokes
            if n == 100 {
                if dbManager.isAllJokeUsed() {
                    dbManager.restoreUsedJokesAsNew()
                    // Recursion
                    jokeType = generateJokeType()
                } else {
                    jokeType = getLeftOverJokeType()
                }
                break
            }
        }

        return jokeType
    }

    private func getRandomJokeType() -> String {
        // Generate a joke type based on the sliders from the Settings screen
        var sldProbabilities = [String]()

        for slider in UserDefaults.sldDictionaty {
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

        for sld in UserDefaults.sldDictionaty.values {
            if dbManager.isAllJokeUsedWith(type: sld) == false {
                type = sld
                break
            }
        }

        return type
    }
}
