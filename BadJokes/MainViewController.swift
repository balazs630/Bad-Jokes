//
//  MainViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController, UNUserNotificationCenterDelegate {

    var newJokes = [NSMutableDictionary]()
    var usedJokes = [NSMutableDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()

        readJokesFrom(fileName: "jokes", ext: "json")

        //Seeking permission of the user to display app notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {_, _ in })
        UNUserNotificationCenter.current().delegate = self
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //To display notifications when app is running  inforeground
        completionHandler([.alert, .sound])
    }

    func readJokesFrom(fileName: String, ext: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: ext) {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSMutableDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
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
        let randomJoke = newJokes[index].value(forKey: "joke") as! String
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

    @IBAction func sendNotification(_ sender: UIButton) {
        //Setting content of the notification
        let content = UNMutableNotificationContent()
        content.title = "Vicc:"
        content.body = getRandomJoke()
        content.badge = 1
        content.sound = UNNotificationSound.default()

        //Setting time for notification trigger
        let date = Date(timeIntervalSinceNow: 3)
        let dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)

        //Adding request
        let request = UNNotificationRequest(identifier: "timerdone", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}
