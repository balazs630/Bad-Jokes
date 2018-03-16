//
//  SchedulesTableQueries - DBManager Extension
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation
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
