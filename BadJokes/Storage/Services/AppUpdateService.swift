//
//  AppUpdateService.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 06. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class AppUpdateService {
    // MARK: Properties
    public static var currentAppVersion: String {
        guard let currentVersion = Bundle.main.infoDictionary?[Constant.shortVersionString] as? String else {
            return "1.1"
        }

        return currentVersion
    }

    private static var lastAppVersion: String {
        guard let lastVersion = UserDefaults.standard.string(forKey: UserDefaults.Key.appVersion) else {
            return "1.1"
        }

        return lastVersion
    }

    // MARK: Routines for app updates
    static func checkUpdates() {
        guard isAppVersionChangedSinceLastLaunch() else { return }

        runDatabaseMigration()
        runApplicationUpdateStatements()

        syncCurrentAppVersion()
    }

    static func readFile(named fileName: String) -> String? {
        guard let file = Bundle.main.path(forResource: fileName, ofType: nil) else { return nil }
        return try? String(contentsOfFile: file, encoding: .utf8)
    }
}

// MARK: Utility methods
extension AppUpdateService {
    private static func isAppVersionChangedSinceLastLaunch() -> Bool {
        return currentAppVersion != lastAppVersion
    }

    private static func runDatabaseMigration() {
        [
            "1.2": "v1.2.sql",
            "1.3": "v1.3.sql",
            "1.4": "v1.4.sql",
            "1.5": "v1.5.sql",
            "1.6": "v1.6.sql",
            "1.7": "v1.7.sql"
        ]
        .filter { $0.key.isGreater(than: lastAppVersion) }
        .forEach { DBService.shared.executeSQLFile(named: $0.value) }
    }

    private static func runApplicationUpdateStatements() {
        if "1.2".isGreater(than: lastAppVersion) {
            renameUserDefaultsKey(from: "sldIT", to: "sldGeek")
        }

        if "1.3".isGreater(than: lastAppVersion) {
            renameUserDefaultsKey(from: "sldMoriczka", to: "sldMoricka")
        }

        if "1.3.1".isGreater(than: lastAppVersion) {
            let isActive = true
            UserDefaults.standard.set(isActive, forKey: UserDefaults.Key.StoreReviewTrigger.newUser)
            UserDefaults.standard.set(isActive, forKey: UserDefaults.Key.StoreReviewTrigger.oldUser)
            UserDefaults.standard.set(isActive, forKey: UserDefaults.Key.StoreReviewTrigger.copyJoke)
        }

        if "1.5".isGreater(than: lastAppVersion) {
            regenerateJokeSchedules()
        }

        if "1.6".isGreater(than: lastAppVersion) {
            regenerateJokeSchedules()
        }

        if "1.7".isGreater(than: lastAppVersion) {
            regenerateJokeSchedules()
        }
    }

    private static func syncCurrentAppVersion() {
        UserDefaults.standard.set(currentAppVersion, forKey: UserDefaults.Key.appVersion)
    }

    private static func renameUserDefaultsKey(from oldKey: String, to newKey: String) {
        let oldValue = UserDefaults.standard.double(forKey: oldKey)

        UserDefaults.standard.set(oldValue, forKey: newKey)
        UserDefaults.standard.removeObject(forKey: oldKey)
    }

    private static func regenerateJokeSchedules() {
        let jokeNotificationService = JokeNotificationService()
        jokeNotificationService.setNewRepeatingNotifications()
    }
}
