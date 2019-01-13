//
//  DBService.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import FMDB

class DBService {

    // MARK: Properties
    static let shared = DBService()

    let dbFileName = "jokesDB"
    let dbExtension = "db"

    var documentsDBPath: String!
    var resourcesDBPath: String!

    var database: FMDatabase!

    // MARK: Initializers
    private init() {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        documentsDBPath = documentsDirectory.appending("/\(dbFileName).\(dbExtension)")
        resourcesDBPath = Bundle.main.path(forResource: dbFileName, ofType: dbExtension)
    }

    // MARK: - Setup
    func isDatabaseOpen() -> Bool {
        if database == nil {
            initDatabase()
        }

        return database != nil && database.open()
    }

    private func initDatabase() {
        if isFirstLaunch() {
            copyDatabase(from: resourcesDBPath, to: documentsDBPath)
            database = FMDatabase(path: documentsDBPath)
        } else {
            database = FMDatabase(path: documentsDBPath)
            UpdateService.handleAppUpdates()
        }
    }

    private func isFirstLaunch() -> Bool {
        return !FileManager.default.fileExists(atPath: documentsDBPath)
    }

    private func copyDatabase(from source: String, to destination: String) {
        if !FileManager.default.fileExists(atPath: destination) {
            do {
                try FileManager.default.copyItem(atPath: source, toPath: destination)
            } catch {
                debugPrint(error)
            }
        } else {
            debugPrint("Database file already exist at: \(destination)")
        }
    }
}

// MARK: Execute SQLite queries from file
extension DBService {
    func executeMigrationScript(fileNamed: String) {
        if isDatabaseOpen() {
            let migrationScriptContent = UpdateService.readMigrationScript(fileNamed: fileNamed)

            debugPrint("Run migration script: \(fileNamed)")
            database.executeStatements(migrationScriptContent)
            database.close()
        }
    }
}
