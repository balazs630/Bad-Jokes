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
        "1.3": "v1.3.sql"
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
    class func checkUpdates() {
        if isAppVersionChangedSinceLastLaunch() {
            runDatabaseMigration()
            runApplicationUpdateStatements()

            syncCurrentAppVersion()
        }
    }

    class func readScript(fileNamed: String) -> String {
        guard let file = Bundle.main.path(forResource: fileNamed, ofType: nil) else {
            fatalError("Script: \(fileNamed) couldn't be found!")
        }

        var sqlContent = ""
        do {
            sqlContent = try String(contentsOfFile: file, encoding: .utf8)
        } catch {
            fatalError("Unexpected error: \(error) on parsing: \(fileNamed)")
        }

        return sqlContent
    }
}

// MARK: Utility methods
extension AppUpdateService {
    private class func isAppVersionChangedSinceLastLaunch() -> Bool {
        return currentAppVersion != lastAppVersion
    }

    private class func runDatabaseMigration() {
        let scripts = collectMigrationScripts()
        scripts.forEach {
            DBService.shared.executeScript(fileNamed: $0)
        }
    }

    private class func collectMigrationScripts() -> [String] {
        var scripts: [String] = []
        migrationSqlScripts.forEach { script in
            if script.key.isGreater(than: lastAppVersion) {
                scripts.append(script.value)
            }
        }

        return scripts
    }

    private class func runApplicationUpdateStatements() {
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
    }

    private class func syncCurrentAppVersion() {
        let defaults = UserDefaults.standard
        defaults.set(currentAppVersion, forKey: UserDefaults.Key.appVersion)
        defaults.synchronize()
    }

    private class func renameUserDefaultsKey(from oldKey: String, to newKey: String) {
        let defaults = UserDefaults.standard
        let oldValue = defaults.double(forKey: oldKey)

        defaults.set(oldValue, forKey: newKey)
        defaults.removeObject(forKey: oldKey)
        defaults.synchronize()
    }

    private class func regenerateJokeSchedules() {
        let defaults = UserDefaults.standard

        if !defaults.bool(forKey: UserDefaults.Key.Sw.globalOff) {
            let jokeNotificationService = JokeNotificationService()
            jokeNotificationService.setNewRepeatingNotifications()
        }
    }
}
