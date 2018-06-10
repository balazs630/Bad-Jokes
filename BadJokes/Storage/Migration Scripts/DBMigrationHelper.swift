//
//  DBMigrationHelper.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 06. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import FMDB

extension DBManager {

    // MARK: Run SQLite queries
    func executeMigrationScript(fileNamed: String) {
        if isDatabaseOpen() {
            let migrationScriptContent = UpdateService.readMigrationScript(fileNamed: fileNamed)

            debugPrint("Run migration script: \(fileNamed)")
            database.executeStatements(migrationScriptContent)
            database.close()
        }
    }
}
