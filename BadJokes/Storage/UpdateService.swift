//
//  UpdateService.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 06. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class UpdateService {

    // MARK: Properties
    static let migrationSqlScripts = [
        "1.2": "v1.2.sql"
    ]

    // MARK: Routines for app updates
    class func handleAppUpdates() {
        if UpdateService.isAppVersionChangedSinceLastLaunch() {
            UpdateService.runDatabaseMigration()
            UpdateService.runApplicationUpdateStatements()

            UpdateService.syncCurrentAppVersion()
        }
    }

    class func runDatabaseMigration() {
        let scripts = UpdateService.collectMigrationScripts(from: getLastAppVersion())
        for script in scripts {
            DBManager.shared.executeMigrationScript(fileNamed: script)
        }
    }

    class func runApplicationUpdateStatements() {
        let defaults = UserDefaults.standard
        let lastVersion = UpdateService.getLastAppVersion()

        if "1.2".isGreater(than: lastVersion) {
            // UserDefaults key name change
            let oldKey = "sldIT"
            let oldValue = defaults.integer(forKey: oldKey)

            defaults.set(oldValue, forKey: UserDefaults.Key.Sld.geek)
            defaults.removeObject(forKey: oldKey)
            defaults.synchronize()

            // Re-generate joke schedules
            if defaults.bool(forKey: UserDefaults.Key.Sw.globalOff) {
                let jokeNotificationHelper = JokeNotificationHelper()
                jokeNotificationHelper.setNewRepeatingNotifications()
            }
        }
    }
}

// MARK: Utility methods
extension UpdateService {
    class func collectMigrationScripts(from lastVersion: String) -> [String] {
        var scripts = [String]()
        for script in migrationSqlScripts {
            if script.key.isGreater(than: lastVersion) {
                scripts.append(script.value)
            }
        }

        return scripts
    }

    class func readMigrationScript(fileNamed: String) -> String {
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

    class func syncCurrentAppVersion() {
        let defaults = UserDefaults.standard
        defaults.set(getCurrentAppVersion(), forKey: UserDefaults.Key.appVersion)
        defaults.synchronize()
    }

    class func isAppVersionChangedSinceLastLaunch() -> Bool {
        return getCurrentAppVersion() != getLastAppVersion()
    }

    class func getCurrentAppVersion() -> String {
        guard let currentVersion = Bundle.main.infoDictionary?[Constant.shortVersionString] as? String else {
            return "1.1"
        }

        return currentVersion
    }

    class func getLastAppVersion() -> String {
        guard let lastVersion = UserDefaults.standard.string(forKey: UserDefaults.Key.appVersion) else {
            return "1.1"
        }

        return lastVersion
    }
}
