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
    let dateUtil = DateUtil()
    let defaults = UserDefaults.standard

    let maxLocalNotificationCount = 64
    var jokeTimesToGenerateCount = Int()
    var recurranceSetting = Int()
    var isPunctualTimeSet = Bool()
    var notificationTimes = [Date]()

    // MARK: Notification generate functions
    func generateNotificationTimes() -> [Date] {
        initBaseVariables()
        var endDate = Date().add(days: -1)

        while notificationTimes.count < jokeTimesToGenerateCount {
            let startDate = endDate.add(days: 1)
            endDate = dateUtil.incrementDateBasedOnPeriodSetting(date: startDate)

            if isPunctualTimeSet {
                addGivenNotificationTime(startDate: startDate, endDate: endDate)
            } else {
                addRandomNotificationTime(startDate: startDate, endDate: endDate)
            }
        }

        return notificationTimes
    }

    private func addGivenNotificationTime(startDate: Date, endDate: Date) {
        var recurranceIterator = recurranceSetting
        while recurranceIterator > 0 {
            if notificationTimes.count == jokeTimesToGenerateCount {
                break
            }

            let notificationTime = dateUtil.getGeneratedNotificationTimeBetween(startDate: startDate,
                                                                                endDate: endDate)
            if notificationTime.isInFuture() {
                notificationTimes.append(notificationTime)
                recurranceIterator -= 1
            } else {
                break
            }
        }
    }

    private func addRandomNotificationTime(startDate: Date, endDate: Date) {
        var recurranceIterator = recurranceSetting
        while recurranceIterator > 0 {
            if !dateUtil.isNotificationCanBeSetFor(date: endDate) {
                break
            }

            var notificationTime = Date()
            repeat {
                notificationTime = dateUtil.getGeneratedNotificationTimeBetween(startDate: startDate,
                                                                                endDate: endDate)
            } while notificationTime.isInPast()

            notificationTimes.append(notificationTime)
            recurranceIterator -= 1

            if notificationTimes.count == jokeTimesToGenerateCount {
                break
            }
        }
    }

    func generateAvailableJokeType(from types: [String]) -> String {
        // Get a joke type and check if the type has unused joke(s)
        var jokeType = types.randomElement()!
        var counter = 0
        while true {
            if DBService.shared.isAllJokeUsedWith(type: jokeType) {
                jokeType = types.randomElement()!
                counter += 1
            } else {
                break
            }

            // If it couldn't find a joke type from 20 tries that has unused jokes
            if counter == 20 {
                jokeType = getLeftOverJokeType()
                break
            }
        }

        return jokeType
    }

    func makeJokeTypeProbabilityArray() -> [String] {
        var sldProbabilities = [String]()

        for slider in Constant.sliders {
            let sldValue = defaults.integer(forKey: Constant.sliders[slider.key]!)

            // Skip joke types with value 0
            if sldValue > 0 {
                for _ in 1...sldValue {
                    // Add the joke type to the array as many times as it's slider value (1-10)
                    sldProbabilities.append(Constant.jokeTypes[slider.value]!)
                }
            }
        }

        return sldProbabilities
    }

    private func getLeftOverJokeType() -> String {
        // Goes through each joke type and returns the first joke type that contains unused joke(s)
        var type = String()

        for sliderType in Constant.jokeTypes.values {
            if !DBService.shared.isAllJokeUsedWith(type: sliderType) {
                type = sliderType
                break
            }
        }

        return type
    }

    private func initBaseVariables() {
        notificationTimes = [Date]()
        isPunctualTimeSet = dateUtil.isPunctualTimeSet()
        recurranceSetting = dateUtil.getRecurranceNumber()
        setJokeTimesToGenerateCount()
    }

    private func setJokeTimesToGenerateCount() {
        let unusedJokeCount = DBService.shared.unusedJokesCount()

        if unusedJokeCount > maxLocalNotificationCount {
            jokeTimesToGenerateCount = maxLocalNotificationCount
        } else {
            jokeTimesToGenerateCount = unusedJokeCount
        }
    }
}
