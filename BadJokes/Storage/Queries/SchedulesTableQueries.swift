//
//  SchedulesTableQueries - DBManager Extension
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import FMDB

extension DBManager {

    func getAllSchedules() -> [Schedule] {
        var resultsArray = [Schedule]()

        if isDatabaseOpen() {
            let query = "SELECT * FROM schedules ORDER BY \(ColumnName.SchedulesTable.jokeId) ASC"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let schedule = Schedule(jokeId: Int(results.int(forColumn: ColumnName.SchedulesTable.jokeId)),
                                            time: Int(results.int(forColumn: ColumnName.SchedulesTable.time)))

                    resultsArray.append(schedule)
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        return resultsArray
    }

    func insertNewScheduledJoke(with jokeId: Int, on time: Int) {
        if isDatabaseOpen() {
            let query = "INSERT INTO schedules (\(ColumnName.SchedulesTable.jokeId), \(ColumnName.SchedulesTable.time)) VALUES(\(jokeId), \(time))"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func isSchedulesListEmpty() -> Bool {
        var count = 0
        if isDatabaseOpen() {
            let query = "SELECT count() as count FROM schedules"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    count = Int(results.int(forColumn: "count"))
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        return count == 0
    }

    func deleteScheduleWith(jokeId: Int) {
        if isDatabaseOpen() {
            let query = "DELETE FROM schedules WHERE \(ColumnName.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func deleteAllSchedules() {
        if isDatabaseOpen() {
            let query = "DELETE FROM schedules WHERE \(ColumnName.JokesTable.jokeId)>0"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }
}
