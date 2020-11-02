//
//  AppDelegate.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

// swiftlint:disable line_length

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initUserDefaults()
        requestNotificationCenterPermission()
        return true
    }
}

// MARK: - UserDefaults setup
extension AppDelegate {
    private func initUserDefaults() {
        guard UserDefaults.standard.object(forKey: UserDefaults.Key.isAppAlreadyLaunchedOnce) == nil else { return }

        DefaultSettings.firstTimeLaunchDefaults.forEach {
            UserDefaults.standard.set($0.value, forKey: $0.key)
        }
    }
}

// MARK: UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    private func requestNotificationCenterPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
        UNUserNotificationCenter.current().delegate = self
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let jokeText = response.notification.request.content.body
        deeplinkToJokeReader(with: jokeText)

        completionHandler()
    }
}

// MARK: Deeplinking
extension AppDelegate {
    private func deeplinkToJokeReader(with jokeText: String) {
        guard let jokeReaderViewController = JokeReaderViewController.instantiate(with: jokeText) else {
            return
        }

        UIApplication.topMostViewController()?.present(jokeReaderViewController, animated: true)
    }
}
