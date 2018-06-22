//
//  SchedulesTableQueries - DBManager Extension
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import FMDB

extension DBManager {

    // MARK: Run SQLite queries
    func getAllDeliveredSchedules() -> [Schedule] {
        var resultSet = [Schedule]()

        if isDatabaseOpen() {
            let query =
            """
            SELECT *
            FROM \(Table.schedules)
            WHERE datetime(\(Table.Schedules.time), 'unixepoch') < datetime('now')
            """

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let schedule = Schedule(jokeId: Int(results.int(forColumn: Table.Schedules.jokeId)),
                                            time: Int(results.int(forColumn: Table.Schedules.time)))

                    resultSet.append(schedule)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }

        return resultSet
    }

    func insertNewScheduledJoke(with jokeId: Int, on time: Int) {
        if isDatabaseOpen() {
            let query =
            """
            INSERT INTO \(Table.schedules)
                (\(Table.Schedules.jokeId), \(Table.Schedules.time))
            VALUES(\(jokeId), \(time))
            """

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }
    }

    func isSchedulesListEmpty() -> Bool {
        var count = 0
        if isDatabaseOpen() {
            let query =
            """
            SELECT count() as count
            FROM \(Table.schedules)
            """

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    count = Int(results.int(forColumn: "count"))
                }
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }

        return count == 0
    }

    func deleteScheduleWith(jokeId: Int) {
        if isDatabaseOpen() {
            let query =
            """
            DELETE
            FROM \(Table.schedules)
            WHERE \(Table.Schedules.jokeId) = \(jokeId)
            """

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }
    }

    func deleteAllSchedules() {
        if isDatabaseOpen() {
            let query =
            """
            DELETE
            FROM \(Table.schedules)
            """

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }
    }
}
