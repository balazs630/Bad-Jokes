//
//  JokeNotificationGenerator.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 22..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class JokeNotificationGenerator {

    // MARK: Properties
    let defaults = UserDefaults.standard
    let maxLocalNotificationCount = 64
    var notificationTimes = [Date]()
    let dateUtil = DateUtil()

    // MARK: Notification generate functions
    func generateNotificationTimes() -> [Date] {
        notificationTimes = [Date]()

        var startDate = Date()
        var endDate = Date().add(days: -1)
        var cycleCounter = 0
        while notificationTimes.count < maxLocalNotificationCount {
            startDate = endDate.add(days: 1)
            endDate = dateUtil.incrementDateBasedOnPeriodSetting(date: startDate)

            if dateUtil.isPunctualTimeSet() {
                addGivenNotificationTime(startDate: startDate, endDate: endDate)
            } else {
                addRandomNotificationTime(startDate: startDate, endDate: endDate, cycleCounter: cycleCounter)
            }

            cycleCounter += 1
        }

        return notificationTimes
    }

    private func addGivenNotificationTime(startDate: Date, endDate: Date) {
        var recurranceValue = dateUtil.getRecurranceNumber()
        while recurranceValue > 0 {
            if notificationTimes.count == maxLocalNotificationCount {
                break
            }

            let notificationTime = dateUtil.getGeneratedNotificationTimeBetween(startDate: startDate,
                                                                                endDate: endDate)
            if notificationTime.isInFuture() {
                notificationTimes.append(notificationTime)
                recurranceValue -= 1
            }
        }
    }

    private func addRandomNotificationTime(startDate: Date, endDate: Date, cycleCounter: Int) {
        var recurranceValue = dateUtil.getRecurrenceNumberBasedOnFreeTimeRatio()
        while recurranceValue > 0 {
            if cycleCounter == 0 {
                if !dateUtil.isNotificationCanBeSetFor(date: endDate) {
                    break
                }
            }

            var notificationTime = Date(timeIntervalSince1970: 0)
            while notificationTime.isInPast() {
                if notificationTimes.count == maxLocalNotificationCount {
                    break
                }

                notificationTime = dateUtil.getGeneratedNotificationTimeBetween(startDate: startDate,
                                                                                endDate: endDate)
                if notificationTime.isInFuture() {
                    notificationTimes.append(notificationTime)
                    recurranceValue -= 1
                }
            }
        }
    }

    func generateJokeType() -> String {
        // Get a joke type and check if the type has unused joke(s)
        var jokeType = getRandomJokeType()
        var counter = 0
        while true {
            if DBManager.shared.isAllJokeUsedWith(type: jokeType) {
                jokeType = getRandomJokeType()
                counter += 1
            } else {
                break
            }

            // If it couldn't find a joke type from 100 tries that has unused jokes
            if counter == 100 {
                if DBManager.shared.isAllJokeUsed() {
                    DBManager.shared.restoreUsedJokesAsNew()
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
            if DBManager.shared.isAllJokeUsedWith(type: sld) == false {
                type = sld
                break
            }
        }

        return type
    }
}
