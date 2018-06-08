//
//  UpdateService.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 06. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class UpdateService {
    class func handleDatabaseMigrationScripts() {
        let lastVersion = getLastAppVersion()
        let currentVersion = getCurrentAppVersion()

        if currentVersion != lastVersion {
            UpdateService.runMigrationScripts(from: lastVersion)
            syncCurrentAppVersion()
        }
    }

    class func runMigrationScripts(from lastVersion: String) {
        for script in DBManager.migrationScripts {
            if script.key.isGreater(than: lastVersion) {
                DBManager.shared.runMigrationScript(fileNamed: script.value)
            }
        }
    }
}

// MARK: Utility methods
extension UpdateService {
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

    class func getLastAppVersion() -> String {
        guard let lastVersion = UserDefaults.standard.string(forKey: UserDefaults.Key.appVersion) else {
            return "1.1"
        }

        return lastVersion
    }

    class func getCurrentAppVersion() -> String {
        guard let currentVersion = Bundle.main.infoDictionary?[Constant.shortVersionString] as? String else {
            return "1.1"
        }

        return currentVersion
    }
}
