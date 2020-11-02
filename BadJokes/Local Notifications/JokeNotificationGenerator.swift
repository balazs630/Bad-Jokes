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
    private let dateUtil = DateUtil()

    private let maxLocalNotificationCount = 64
    private var jokeTimesToGenerateCount = 0
    private var recurranceSetting = 0
    private var isPunctualTimeSet = false
    private var notificationTimes: [Date] = []

    // MARK: Notification generate functions
    func generateNotificationTimes() -> [Date] {
        initBaseVariables()
        var endDate = Date().add(days: -1)

        while notificationTimes.count < jokeTimesToGenerateCount {
            let startDate = endDate.add(days: 1)
            endDate = dateUtil.incrementDateBasedOnPeriodSetting(date: startDate)

            isPunctualTimeSet
                ? addGivenNotificationTimeBetween(startDate, endDate)
                : addRandomNotificationTimeBetween(startDate, endDate)
        }

        return notificationTimes
    }

    private func initBaseVariables() {
        notificationTimes = []
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

    private func addGivenNotificationTimeBetween(_ startDate: Date, _ endDate: Date) {
        var recurranceIterator = recurranceSetting
        while recurranceIterator > 0 {
            if notificationTimes.count == jokeTimesToGenerateCount {
                break
            }

            let notificationTime = dateUtil.getGeneratedNotificationTimeBetween(startDate, endDate)
            if notificationTime.isInFuture() {
                notificationTimes.append(notificationTime)
                recurranceIterator -= 1
            } else {
                break
            }
        }
    }

    private func addRandomNotificationTimeBetween(_ startDate: Date, _ endDate: Date) {
        var recurranceIterator = recurranceSetting
        while recurranceIterator > 0 {
            if !dateUtil.isNotificationCanBeSetFor(date: endDate) {
                break
            }

            var notificationTime = Date()
            repeat {
                notificationTime = dateUtil.getGeneratedNotificationTimeBetween(startDate, endDate)
            } while notificationTime.isInPast()

            notificationTimes.append(notificationTime)
            recurranceIterator -= 1

            if notificationTimes.count == jokeTimesToGenerateCount {
                break
            }
        }
    }

    func generateAvailableJokeType(from types: [String]) -> String {
        var jokeType = types.randomElement()!
        var counter = 0
        let maxTrials = 20

        while true {
            if DBService.shared.isAllJokeUsedWith(type: jokeType) {
                jokeType = types.randomElement()!
                counter += 1
            } else {
                break
            }

            if counter == maxTrials {
                jokeType = getLeftOverJokeType()
                break
            }
        }

        return jokeType
    }

    func makeJokeTypeProbabilityArray() -> [String] {
        var sldProbabilities: [String] = []

        Constant.sliders.forEach { slider in
            let sliderValue = UserDefaults.standard.integer(forKey: slider.value)
            guard sliderValue > 0, let jokeType = Constant.jokeTypes[slider.value] else { return }

            (1...sliderValue).forEach { _ in
                sldProbabilities.append(jokeType)
            }
        }

        return sldProbabilities
    }

    private func getLeftOverJokeType() -> String {
        for jokeType in Constant.jokeTypes.values {
            if !DBService.shared.isAllJokeUsedWith(type: jokeType) {
                return jokeType
            }
        }

        return ""
    }
}
