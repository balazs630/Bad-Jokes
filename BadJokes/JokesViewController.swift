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

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        readJokesFrom(fileName: "jokes", ext: "json")

        //Seeking permission of the user to display app notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {_, _ in })
        UNUserNotificationCenter.current().delegate = self

        timeFormatter.dateFormat = "HH:mm"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        if defaults.string(forKey: UserDefaultsKeys.Lbl.time) == Time.atGivenTime {
            let time = getGivenTime()
            setNotification(for: time)
        } else {
            //Véletlen időpontban, délelőtt, délután vagy este
            let timeInterval = getTimeInterval()
            let notificationTimes = generateNotificationTimesBetween(timeInterval.0, timeInterval.1)
            for time in notificationTimes {
                setNotification(for: time)
            }
        }
    }

    @IBAction func sendNotification(_ sender: UIButton) {
        //Setting content of the notification
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        content.body = getRandomJoke()
        content.badge = 1

        if defaults.bool(forKey: UserDefaultsKeys.Sw.notificationSound) {
            content.sound = UNNotificationSound.default()
        }

        //Setting time for notification trigger
        let date = Date(timeIntervalSinceNow: 3)
        let dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)

        //Adding request
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func settingsDidClose() {
        //TODO
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

    func getGivenTime() -> Date {
        let gregorian = Calendar(identifier: .gregorian)
        var timeComponents = gregorian.dateComponents([.hour, .minute], from: Date())

        timeComponents.hour = defaults.integer(forKey: UserDefaultsKeys.Pck.timeHours)
        timeComponents.minute = defaults.integer(forKey: UserDefaultsKeys.Pck.timeMinutes)

        let time = gregorian.date(from: timeComponents)!
        return time
    }

    func getTimeInterval() -> (Date, Date) {
        var startTime = Date()
        var endTime = Date()

        if let timeSettings = defaults.string(forKey: UserDefaultsKeys.Lbl.time) {
            switch timeSettings {
            case Time.random:
                startTime = timeFormatter.date(from: Time.Hour.nine)!
                endTime = timeFormatter.date(from: Time.Hour.twentyone)!
            case Time.morning:
                startTime = timeFormatter.date(from: Time.Hour.nine)!
                endTime = timeFormatter.date(from: Time.Hour.noon)!
            case Time.afternoon:
                startTime = timeFormatter.date(from: Time.Hour.noon)!
                endTime = timeFormatter.date(from: Time.Hour.eighteen)!
            case Time.evening:
                startTime = timeFormatter.date(from: Time.Hour.eighteen)!
                endTime = timeFormatter.date(from: Time.Hour.twentyone)!
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
        let dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)

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

    func recurranceNumber(from value: String) -> Int {
        guard let recurranceNumber = Int(value.substring(to: value.index(before: value.endIndex))) else {
            return Int()
        }
        return recurranceNumber
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettingsSegue" {
            let destVC = segue.destination as! SettingsViewController
            destVC.delegate = self
        }
    }

}
