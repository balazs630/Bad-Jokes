//
//  JokeNotificationGenerator.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 22..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class JokeNotificationGenerator {

    let defaults = UserDefaults.standard
    let dbManager = DBManager()

    func getJokeType() -> String {
        // Get a joke type and check if the type has unused joke(s)
        var jokeType = generateJokeType()
        var n = 0
        while true {
            if dbManager.isAllJokeUsedWith(type: jokeType) {
                jokeType = generateJokeType()
                n += 1
            } else {
                break
            }

            // If it couldn't find a joke type from 100 tries that has unused jokes
            if n == 100 {
                if dbManager.isAllJokeUsed() {
                    dbManager.restoreUsedJokesAsNew()
                    // Recursion
                    jokeType = getJokeType()
                } else {
                    jokeType = getLeftOverJokeType()
                }
                break
            }
        }

        print("getJokeType: \(jokeType)")
        return jokeType
    }

    private func generateJokeType() -> String {
        // Generate a joke type based on the sliders from the Settings screen
        var sldProbabilities = [String]()

        for slider in UserDefaults.Key.sldDictionaty {
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

        for sld in UserDefaults.Key.sldDictionaty.values {
            if dbManager.isAllJokeUsedWith(type: sld) == false {
                type = sld
                break
            }
        }

        return type
    }
}
