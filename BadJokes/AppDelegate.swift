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
        let defaults = UserDefaults.standard

        if defaults.object(forKey: UserDefaults.Key.isAppAlreadyLaunchedOnce) == nil {
            DefaultSettings.firstTimeLaunchDefaults.forEach {
                defaults.set($0.value, forKey: $0.key)
            }
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
        guard let jokeId = response.notification.request.content.userInfo[Constant.notificationJokeIdKey] else {
            return
        }
        debugPrint("didReceive joke with id: \(jokeId)")

        completionHandler()
    }
}
