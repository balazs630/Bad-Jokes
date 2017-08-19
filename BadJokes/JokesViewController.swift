//
//  JokesViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit
import UserNotifications

class JokesViewController: UIViewController, UNUserNotificationCenterDelegate, SettingsViewControllerDelegate {

    var newJokes = [NSMutableDictionary]()
    var usedJokes = [NSMutableDictionary]()

    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    var localTimeZoneName: String { return TimeZone.current.identifier }

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        readJokesFrom(fileName: "jokes", ext: "json")

        //Seeking permission of the user to display app notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {_, _ in })
        UNUserNotificationCenter.current().delegate = self

        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = TimeZone(identifier: localTimeZoneName)

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: localTimeZoneName)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //To display notifications when app is running  inforeground
        completionHandler([.alert, .sound])
    }

    func removeAllPendingNotificationRequests() {
        // Which are not delivered yet but scheduled
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func settingsDidClose() {
        applyCurrentNotificationSettings()
    }

    func applyCurrentNotificationSettings() {
        if defaults.string(forKey: UserDefaultsKeys.Lbl.time) == Time.atGivenTime {
            //Pontos időpontban
            let time = getGivenTime()
            if let recurranceString = defaults.string(forKey: UserDefaultsKeys.Lbl.recurrence) {
                let multiplier: Int = recurranceNumber(from: recurranceString)
                for i in 1...multiplier {
                    // Separate multiple notifications with 1 second difference
                    setNotification(for: time + TimeInterval(i))
                }
            }
        } else {
            //Véletlen időpontban, délelőtt, délután vagy este
            let timeInterval = getTimeInterval()
            let notificationTimes = generateNotificationTimesBetween(timeInterval.0, timeInterval.1)
            for time in notificationTimes {
                setNotification(for: time)
            }
        }
    }

    func getGivenTime() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var timeComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        timeComponents.timeZone = TimeZone(identifier: localTimeZoneName)

        timeComponents.hour = defaults.integer(forKey: UserDefaultsKeys.Pck.timeHours)
        timeComponents.minute = defaults.integer(forKey: UserDefaultsKeys.Pck.timeMinutes)
        print("getGivenTime(): timeComponents: \(timeComponents)")

        let time = calendar.date(from: timeComponents)!
        print("getGivenTime(): \(time)")
        print("")
        return time
    }

    func getTimeInterval() -> (Date, Date) {
        var startTime = Date()
        var endTime = Date()

        if let timeSettings = defaults.string(forKey: UserDefaultsKeys.Lbl.time) {
            switch timeSettings {
            case Time.random:
                startTime = timeFormatter.date(from: Time.Hour.morningStart)!
                endTime = timeFormatter.date(from: Time.Hour.nightStart)!
            case Time.morning:
                startTime = timeFormatter.date(from: Time.Hour.morningStart)!
                endTime = timeFormatter.date(from: Time.Hour.afternoonStart)!
            case Time.afternoon:
                startTime = timeFormatter.date(from: Time.Hour.afternoonStart)!
                endTime = timeFormatter.date(from: Time.Hour.eveningStart)!
            case Time.evening:
                startTime = timeFormatter.date(from: Time.Hour.eveningStart)!
                endTime = timeFormatter.date(from: Time.Hour.nightStart)!
            default:
                print("Unexpected time identifier was given in: \(#file), line: \(#line)")
            }
        }

        return (startTime, endTime)
    }

    func generateNotificationTimesBetween(_ startTime: Date, _ endTime: Date) -> [Date] {
        var notificationTimes = [Date]()

        if let recurranceString = defaults.string(forKey: UserDefaultsKeys.Lbl.recurrence) {
            let multiplier: Int = recurranceNumber(from: recurranceString)
            let intervalSeconds = endTime.timeIntervalSince(startTime)

            for _ in 1...multiplier {
                let randomSec = arc4random_uniform(UInt32(intervalSeconds))
                let randomTime: Date = startTime + TimeInterval(randomSec)
                notificationTimes.append(randomTime)
            }
        }

        return notificationTimes
    }

    func recurranceNumber(from value: String) -> Int {
        guard let recurranceNumber = Int(value.substring(to: value.index(before: value.endIndex))) else {
            return Int()
        }
        return recurranceNumber
    }

    func setNotification(for time: Date) {
        //Setting content of the notification
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        content.body = getRandomJoke()
        content.badge = 1

        if defaults.bool(forKey: UserDefaultsKeys.Sw.notificationSound) {
            content.sound = UNNotificationSound.default()
        }

        //Setting time for notification trigger
        var dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
        dateCompenents.timeZone = TimeZone(identifier: localTimeZoneName)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
        print("setNotification fromSettings, trigger: \(trigger)")
        print("")

        //Adding request
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func readJokesFrom(fileName: String, ext: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: ext) {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let options = JSONSerialization.ReadingOptions.mutableContainers
                    let jsonResult: NSMutableDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: options) as! NSMutableDictionary
                    newJokes = jsonResult["jokes"] as! [NSMutableDictionary]
                } catch {
                    print(error)
                }
            } catch {
                print(error)
            }
        }
    }

    func getRandomJoke() -> String {
        if isAllJokeUsed() == true {
            restoreUsedJokesAsNew()
        }

        let index: Int = Int(arc4random_uniform(UInt32(newJokes.count)))
        guard let randomJoke = newJokes[index].value(forKey: "joke") as? String else {
            //TODO: Add a default joke instead of a warning
            return "Error getting a random joke"
        }
        jokeDidUseWith(index)

        return randomJoke
    }

    func isAllJokeUsed() -> Bool {
        return newJokes.count == 0 ? true : false
    }

    func jokeDidUseWith(_ index: Int) {
        usedJokes.append(newJokes[index])
        newJokes.remove(at: index)
    }

    func restoreUsedJokesAsNew() {
        newJokes = usedJokes
        usedJokes.removeAll()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettingsSegue" {
            let destVC = segue.destination as! SettingsViewController
            destVC.delegate = self
        }
    }

}
