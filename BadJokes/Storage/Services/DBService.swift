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
    lazy var databaseQueue = initDatabaseQueue()

    private let fileManager = FileManager.default
    private var documentsDBPath: String
    private var resourcesDBPath: String

    // MARK: Initializers
    private init() {
        do {
            documentsDBPath = try fileManager
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(Constant.databaseFileName)
                .appendingPathExtension(Constant.databaseFileExtension)
                .path
        } catch {
            fatalError("Couldn't find documents directory!")
        }

        resourcesDBPath = Bundle.main.path(
            forResource: Constant.databaseFileName,
            ofType: Constant.databaseFileExtension
        )!
    }

    // MARK: - Setup
    private func initDatabaseQueue() -> FMDatabaseQueue {
        if isFirstLaunch() {
            copyDatabase(from: resourcesDBPath, to: documentsDBPath)
            databaseQueue = FMDatabaseQueue(path: documentsDBPath)!
        } else {
            databaseQueue = FMDatabaseQueue(path: documentsDBPath)!
            AppUpdateService.checkUpdates()
        }

        return databaseQueue
    }

    private func isFirstLaunch() -> Bool {
        return !fileManager.fileExists(atPath: documentsDBPath)
    }

    private func copyDatabase(from source: String, to destination: String) {
        do {
            try fileManager.copyItem(atPath: source, toPath: destination)
        } catch {
            debugPrint(error)
        }
    }
}

// MARK: Execute SQLite queries from file
extension DBService {
    func executeSQLFile(named fileName: String) {
        guard let sqlStatements = AppUpdateService.readFile(named: fileName) else { return }

        debugPrint("Run script: \(fileName)")
        databaseQueue.inTransaction { database, _ in
            database.executeUpdate(sqlStatements, withArgumentsIn: [])
        }
    }
}
