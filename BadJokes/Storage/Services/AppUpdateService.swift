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
    private static let migrationSqlScripts = [
        "1.2": "v1.2.sql",
        "1.3": "v1.3.sql",
        "1.4": "v1.4.sql"
    ]

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
        if isAppVersionChangedSinceLastLaunch() {
            runDatabaseMigration()
            runApplicationUpdateStatements()

            syncCurrentAppVersion()
        }
    }

    static func readScript(fileNamed: String) -> String? {
        if let file = Bundle.main.path(forResource: fileNamed, ofType: nil) {
            return try? String(contentsOfFile: file, encoding: .utf8)
        }

        return nil
    }
}

// MARK: Utility methods
extension AppUpdateService {
    private static func isAppVersionChangedSinceLastLaunch() -> Bool {
        return currentAppVersion != lastAppVersion
    }

    private static func runDatabaseMigration() {
        let scripts = collectMigrationScripts()
        scripts.forEach {
            DBService.shared.executeScript(fileNamed: $0)
        }
    }

    private static func collectMigrationScripts() -> [String] {
        return migrationSqlScripts
            .filter {
                $0.key.isGreater(than: lastAppVersion)
            }.map {
                $0.value
        }
    }

    private static func runApplicationUpdateStatements() {
        if "1.2".isGreater(than: lastAppVersion) {
            renameUserDefaultsKey(from: "sldIT", to: "sldGeek")
        }

        if "1.3".isGreater(than: lastAppVersion) {
            renameUserDefaultsKey(from: "sldMoriczka", to: "sldMoricka")
            regenerateJokeSchedules()
        }

        if "1.3.1".isGreater(than: lastAppVersion) {
            let isActive = true
            UserDefaults.standard.set(isActive, forKey: UserDefaults.Key.StoreReviewTrigger.newUser)
            UserDefaults.standard.set(isActive, forKey: UserDefaults.Key.StoreReviewTrigger.oldUser)
            UserDefaults.standard.set(isActive, forKey: UserDefaults.Key.StoreReviewTrigger.copyJoke)
        }

        if "1.4".isGreater(than: lastAppVersion) {
            regenerateJokeSchedules()
        }
    }

    private static func syncCurrentAppVersion() {
        let defaults = UserDefaults.standard
        defaults.set(currentAppVersion, forKey: UserDefaults.Key.appVersion)
        defaults.synchronize()
    }

    private static func renameUserDefaultsKey(from oldKey: String, to newKey: String) {
        let defaults = UserDefaults.standard
        let oldValue = defaults.double(forKey: oldKey)

        defaults.set(oldValue, forKey: newKey)
        defaults.removeObject(forKey: oldKey)
        defaults.synchronize()
    }

    private static func regenerateJokeSchedules() {
        let defaults = UserDefaults.standard

        if !defaults.bool(forKey: UserDefaults.Key.Sw.globalOff) {
            let jokeNotificationService = JokeNotificationService()
            jokeNotificationService.setNewRepeatingNotifications()
        }
    }
}
