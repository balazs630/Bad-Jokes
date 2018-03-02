//
//  DBManager.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation
import FMDB

class DBManager: NSObject {

    static let shared: DBManager = DBManager()

    let dbFileName = "jokesDB"
    let dbExtension = "db"

    var documentsDBPath: String!
    var resourcesDBPath: String!

    var database: FMDatabase!

    override init() {
        super.init()

        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        documentsDBPath = documentsDirectory.appending("/\(dbFileName).\(dbExtension)")
        resourcesDBPath = Bundle.main.path(forResource: dbFileName, ofType: dbExtension)
    }

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
        if !FileManager.default.fileExists(atPath: documentsDBPath) {
            // First launch... Copy the db to make a writable database in the app’s Documents directory
            copyDatabase(from: resourcesDBPath, to: documentsDBPath)
        }
        database = FMDatabase(path: documentsDBPath)
    }

    private func copyDatabase(from source: String, to destination: String) {
        if !FileManager.default.fileExists(atPath: destination) {
            do {
                try FileManager.default.copyItem(atPath: source, toPath: destination)
            } catch {
                print(error)
            }
        } else {
            print("Database file already exist at: \(destination)")
        }
    }

}
