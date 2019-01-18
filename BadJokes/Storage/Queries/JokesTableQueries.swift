//
//  JokesTableQueries - DBService Extension
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import FMDB

extension DBService {
    // MARK: Run SQLite queries
    func getDeliveredJokes() -> [Joke] {
        var resultSet: [Joke] = []

        if isDatabaseOpen() {
            let query =
            """
            SELECT *
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.deliveryTime) IS NOT NULL
            ORDER BY \(Table.Jokes.deliveryTime) DESC
            """

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: Table.Jokes.jokeId)),
                                    isUsed: Int(results.int(forColumn: Table.Jokes.isUsed)),
                                    deliveryTime: Int(results.int(forColumn: Table.Jokes.deliveryTime)),
                                    type: results.string(forColumn: Table.Jokes.type),
                                    jokeText: results.string(forColumn: Table.Jokes.jokeText))

                    resultSet.append(joke)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }

        return resultSet
    }

    func getRandomJoke(for type: String) -> Joke? {
        var randomJoke: Joke?

        if isDatabaseOpen() {
            let query =
            """
            SELECT *
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.type) LIKE \"\(type)\"
                AND \(Table.Jokes.isUsed) = 0
                AND NOT EXISTS (SELECT *
                                FROM \(Table.schedules)
                                WHERE \(Table.schedules).\(Table.Schedules.jokeId)
                                        = \(Table.jokes).\(Table.Jokes.jokeId))
            ORDER BY RANDOM()
            LIMIT 1
            """

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    randomJoke = Joke(jokeId: Int(results.int(forColumn: Table.Jokes.jokeId)),
                                      isUsed: Int(results.int(forColumn: Table.Jokes.isUsed)),
                                      deliveryTime: Int(results.int(forColumn: Table.Jokes.deliveryTime)),
                                      type: results.string(forColumn: Table.Jokes.type),
                                      jokeText: results.string(forColumn: Table.Jokes.jokeText))
                }
            } catch {
                debugPrint(error.localizedDescription)
            }

            database.close()
        }

        return randomJoke
    }

    func unusedJokesCount() -> Int {
        var count = 0
        if isDatabaseOpen() {
            let query =
            """
            SELECT count() as count
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.isUsed) = 0
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

        return count
    }

    func storedJokesCount() -> Int {
        var count = 0
        if isDatabaseOpen() {
            let query =
            """
            SELECT count() as count
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.deliveryTime) IS NOT NULL
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

        return count
    }

    func hasUsedJoke() -> Bool {
        var count = 0
        if isDatabaseOpen() {
            let query =
            """
            SELECT count() as count
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.isUsed) = 1
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

        return count != 0
    }

    func isAllJokeUsedWith(type: String) -> Bool {
        var count = 0
        if isDatabaseOpen() {
            let query =
            """
            SELECT count() as count
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.type) = \"\(type)\"
                AND \(Table.Jokes.isUsed) = 0
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

    func setJokeUsedAndDeliveredWith(jokeId: Int, deliveryTime: Int) {
        if isDatabaseOpen() {
            let query =
            """
            UPDATE \(Table.jokes)
            SET \(Table.Jokes.isUsed) = 1, \(Table.Jokes.deliveryTime) = \(deliveryTime)
            WHERE \(Table.Jokes.jokeId) = \(jokeId)
            """

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
            let query =
            """
            UPDATE \(Table.jokes)
            SET \(Table.Jokes.deliveryTime) = null
            WHERE \(Table.Jokes.jokeId) = \(jokeId)
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
