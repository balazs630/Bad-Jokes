//
//  DBManager.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import FMDB

class DBManager {

    // MARK: Properties
    static let shared = DBManager()

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

        if database != nil && database.open() {
            return true
        }
        return false
    }

    private func initDatabase() {
        if isFirstLaunch() {
            // Copy the db file to make a writable database in the app’s Documents directory
            copyDatabase(from: resourcesDBPath, to: documentsDBPath)
            database = FMDatabase(path: documentsDBPath)
        } else {
            // App already installed or updated to newer version
            database = FMDatabase(path: documentsDBPath)
            UpdateService.handleDatabaseMigration()
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
