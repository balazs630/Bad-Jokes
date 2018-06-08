//
//  JokesTableQueries - DBManager Extension
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import FMDB

extension DBManager {

    // MARK: Run SQLite queries
    func getDeliveredJokes() -> [Joke] {
        var resultsArray = [Joke]()

        if isDatabaseOpen() {
            let query = "SELECT * FROM jokes WHERE \(ColumnName.JokesTable.deliveryTime) IS NOT NULL"
                                            + " ORDER BY \(ColumnName.JokesTable.deliveryTime) DESC"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: ColumnName.JokesTable.jokeId)),
                                    isUsed: Int(results.int(forColumn: ColumnName.JokesTable.isUsed)),
                                    deliveryTime: Int(results.int(forColumn: ColumnName.JokesTable.deliveryTime)),
                                    type: results.string(forColumn: ColumnName.JokesTable.type),
                                    jokeText: results.string(forColumn: ColumnName.JokesTable.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }

        return resultsArray
    }

    func getRandomJokeWith(type: String) -> Joke {
        var resultsArray = [Joke]()

        if isDatabaseOpen() {
            let query = "SELECT * FROM jokes WHERE \(ColumnName.JokesTable.type)=\"\(type)\""
                                                            + " AND \(ColumnName.JokesTable.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: ColumnName.JokesTable.jokeId)),
                                    isUsed: Int(results.int(forColumn: ColumnName.JokesTable.isUsed)),
                                    deliveryTime: Int(results.int(forColumn: ColumnName.JokesTable.deliveryTime)),
                                    type: results.string(forColumn: ColumnName.JokesTable.type),
                                    jokeText: results.string(forColumn: ColumnName.JokesTable.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }

        guard let randomIndex = resultsArray.randomIndex() else {
            restoreUsedJokesAsNew()
            return resultsArray[resultsArray.randomIndex()!]
        }

        return resultsArray[randomIndex]
    }

    func isAllJokeUsed() -> Bool {
        var count = 0
        if isDatabaseOpen() {
            let query = "SELECT count() as count FROM jokes WHERE \(ColumnName.JokesTable.isUsed)=0"

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

    func isAllJokeUsedWith(type: String) -> Bool {
        var count = 0
        if isDatabaseOpen() {
            let query = "SELECT count() as count FROM jokes WHERE \(ColumnName.JokesTable.type)=\"\(type)\""
                                                            + " AND \(ColumnName.JokesTable.isUsed)=0"

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

    func setJokeUsedAndDeliveredWith(jokeId: Int, deliveryTime: Int) {
        if isDatabaseOpen() {
            let query = "UPDATE jokes SET \(ColumnName.JokesTable.isUsed)=1," +
                                        " \(ColumnName.JokesTable.deliveryTime)=\(deliveryTime)"
                                        + " WHERE \(ColumnName.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }
    }

    func restoreUsedJokesAsNew() {
        if isDatabaseOpen() {
            let query = "UPDATE jokes SET \(ColumnName.JokesTable.isUsed)=0"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }
    }

    func removeDeliveredJokeWith(jokeId: Int) {
        if isDatabaseOpen() {
            let query = "UPDATE jokes SET \(ColumnName.JokesTable.deliveryTime)=null"
                                    + " WHERE \(ColumnName.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }
    }

}
