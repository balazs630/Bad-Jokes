//
//  SchedulesTableQueries - DBService Extension
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import FMDB

extension DBService {
    // MARK: Run SQLite queries
    func getAllDeliveredSchedules() -> [Schedule] {
        var resultSet: [Schedule] = []

        let query = """
            SELECT *
            FROM \(Table.schedules)
            WHERE datetime(\(Table.Schedules.time), 'unixepoch') < datetime('now')
        """

        databaseQueue.inTransaction { database, _ in
            if let results = database.executeQuery(query, withArgumentsIn: []) {
                while results.next() {
                    let schedule = Schedule(jokeId: Int(results.int(forColumn: Table.Schedules.jokeId)),
                                            time: Int(results.int(forColumn: Table.Schedules.time)))

                    resultSet.append(schedule)
                }
            }
        }

        return resultSet
    }

    func insertNewScheduledJoke(with jokeId: Int, on time: Int) {
        let query = """
            INSERT INTO \(Table.schedules)
                (\(Table.Schedules.jokeId), \(Table.Schedules.time))
            VALUES(\(jokeId), \(time))
        """

        databaseQueue.inTransaction { database, _ in
            database.executeUpdate(query, withArgumentsIn: [])
        }
    }

    func isSchedulesListEmpty() -> Bool {
        var count = 0

        let query = """
            SELECT count() as count
            FROM \(Table.schedules)
        """

        databaseQueue.inTransaction { database, _ in
            if let results = database.executeQuery(query, withArgumentsIn: []) {
                while results.next() {
                    count = Int(results.int(forColumn: "count"))
                }
            }
        }

        return count == 0
    }

    func schedulesCount() -> Int {
        var count = 0

        let query = """
            SELECT count() as count
            FROM \(Table.schedules)
        """

        databaseQueue.inTransaction { database, _ in
            if let results = database.executeQuery(query, withArgumentsIn: []) {
                while results.next() {
                    count = Int(results.int(forColumn: "count"))
                }
            }
        }

        return count
    }

    func deleteScheduleWith(jokeId: Int) {
        let query = """
            DELETE
            FROM \(Table.schedules)
            WHERE \(Table.Schedules.jokeId) = \(jokeId)
        """

        databaseQueue.inTransaction { database, _ in
            database.executeUpdate(query, withArgumentsIn: [])
        }
    }

    func deleteAllSchedules() {
        let query = """
            DELETE
            FROM \(Table.schedules)
        """

        databaseQueue.inTransaction { database, _ in
            database.executeUpdate(query, withArgumentsIn: [])
        }
    }
}
