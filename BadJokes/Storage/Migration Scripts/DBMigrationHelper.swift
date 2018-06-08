//
//  DBMigrationHelper.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 06. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import FMDB

extension DBManager {

    // MARK: Properties
    static let migrationScripts = [
        "1.2": "v1.2.sql"
    ]

    // MARK: Run SQLite queries
    func runMigrationScript(fileNamed: String) {
        if isDatabaseOpen() {
            let migrationScript = UpdateService.readMigrationScript(fileNamed: fileNamed)

            debugPrint("Run migration script: \(fileNamed)")
            database.executeStatements(migrationScript)
            database.close()
        }
    }
}
