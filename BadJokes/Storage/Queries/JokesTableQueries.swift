//
//  JokesTableQueries - DBService Extension
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import FMDB

// MARK: SELECT queries
extension DBService {
    func deliveredJokes() -> [Joke] {
        var resultSet: [Joke] = []

        let query = """
            SELECT *
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.deliveryTime) IS NOT NULL
            ORDER BY \(Table.Jokes.deliveryTime) DESC
        """

        databaseQueue.inTransaction { database, _ in
            if let results = database.executeQuery(query, withArgumentsIn: []) {
                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: Table.Jokes.jokeId)),
                                    isUsed: Int(results.int(forColumn: Table.Jokes.isUsed)),
                                    deliveryTime: Int(results.int(forColumn: Table.Jokes.deliveryTime)),
                                    type: results.string(forColumn: Table.Jokes.type)!,
                                    jokeText: results.string(forColumn: Table.Jokes.jokeText)!)

                    resultSet.append(joke)
                }
            }
        }

        return resultSet
    }

    func randomJoke(for type: String) -> Joke? {
        var randomJoke: Joke?

        let query = """
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

        databaseQueue.inTransaction { database, _ in
            if let results = database.executeQuery(query, withArgumentsIn: []) {
                while results.next() {
                    randomJoke = Joke(jokeId: Int(results.int(forColumn: Table.Jokes.jokeId)),
                                      isUsed: Int(results.int(forColumn: Table.Jokes.isUsed)),
                                      deliveryTime: Int(results.int(forColumn: Table.Jokes.deliveryTime)),
                                      type: results.string(forColumn: Table.Jokes.type)!,
                                      jokeText: results.string(forColumn: Table.Jokes.jokeText)!)
                }
            }
        }

        return randomJoke
    }

    func unusedJokesCount() -> Int {
        var count = 0

        let query = """
            SELECT count() as count
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.isUsed) = 0
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

    func storedJokesCount() -> Int {
        var count = 0

        let query = """
            SELECT count() as count
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.deliveryTime) IS NOT NULL
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

    func hasUsedJoke() -> Bool {
        var count = 0

        let query = """
            SELECT count() as count
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.isUsed) = 1
        """

        databaseQueue.inTransaction { database, _ in
            if let results = database.executeQuery(query, withArgumentsIn: []) {
                while results.next() {
                    count = Int(results.int(forColumn: "count"))
                }
            }
        }

        return count != 0
    }

    func hasUnusedJoke() -> Bool {
        var count = 0

        let query = """
            SELECT count() as count
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.isUsed) = 0
        """

        databaseQueue.inTransaction { database, _ in
            if let results = database.executeQuery(query, withArgumentsIn: []) {
                while results.next() {
                    count = Int(results.int(forColumn: "count"))
                }
            }
        }

        return count != 0
    }

    func isAllJokeUsedWith(type: String) -> Bool {
        var count = 0

        let query = """
            SELECT count() as count
            FROM \(Table.jokes)
            WHERE \(Table.Jokes.type) = \"\(type)\"
                AND \(Table.Jokes.isUsed) = 0
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
}

// MARK: Update queries
extension DBService {
    func setJokeUsedAndDeliveredWith(jokeId: Int, deliveryTime: Int) {
        let query = """
            UPDATE \(Table.jokes)
            SET \(Table.Jokes.isUsed) = 1, \(Table.Jokes.deliveryTime) = \(deliveryTime)
            WHERE \(Table.Jokes.jokeId) = \(jokeId)
        """

        databaseQueue.inTransaction { database, _ in
            database.executeUpdate(query, withArgumentsIn: [])
        }
    }

    func removeDeliveredJokeWith(jokeId: Int) {
        let query = """
            UPDATE \(Table.jokes)
            SET \(Table.Jokes.deliveryTime) = null
            WHERE \(Table.Jokes.jokeId) = \(jokeId)
        """

        databaseQueue.inTransaction { database, _ in
            database.executeUpdate(query, withArgumentsIn: [])
        }
    }
}
