//
//  JokesTableQueries - DBManager Extension
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation
import FMDB

extension DBManager {

    func getAllJokes() -> [Joke] {
        var resultsArray = [Joke]()

        if isDatabaseOpen() {
            let query = "SELECT * FROM jokes ORDER BY \(ColumnName.JokesTable.jokeId) ASC"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: ColumnName.JokesTable.jokeId)),
                                    isUsed: Int(results.int(forColumn: ColumnName.JokesTable.isUsed)),
                                    isStored: Int(results.int(forColumn: ColumnName.JokesTable.isStored)),
                                    type: results.string(forColumn: ColumnName.JokesTable.type),
                                    jokeText: results.string(forColumn: ColumnName.JokesTable.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        return resultsArray
    }

    func getStoredJokes() -> [Joke] {
        var resultsArray = [Joke]()

        if isDatabaseOpen() {
            let query = "SELECT * FROM jokes WHERE \(ColumnName.JokesTable.isStored)=1"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: ColumnName.JokesTable.jokeId)),
                                    isUsed: Int(results.int(forColumn: ColumnName.JokesTable.isUsed)),
                                    isStored: Int(results.int(forColumn: ColumnName.JokesTable.isStored)),
                                    type: results.string(forColumn: ColumnName.JokesTable.type),
                                    jokeText: results.string(forColumn: ColumnName.JokesTable.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        return resultsArray
    }

    func getRandomJokeWith(type: String) -> Joke {
        var resultsArray = [Joke]()

        if isDatabaseOpen() {
            let query = "SELECT * FROM jokes WHERE \(ColumnName.JokesTable.type)=\"\(type)\" AND \(ColumnName.JokesTable.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: ColumnName.JokesTable.jokeId)),
                                    isUsed: Int(results.int(forColumn: ColumnName.JokesTable.isUsed)),
                                    isStored: Int(results.int(forColumn: ColumnName.JokesTable.isStored)),
                                    type: results.string(forColumn: ColumnName.JokesTable.type),
                                    jokeText: results.string(forColumn: ColumnName.JokesTable.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                print(error.localizedDescription)
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
            let query = "SELECT * FROM jokes WHERE \(ColumnName.JokesTable.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    count += 1
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        if count == 0 {
            return true
        } else {
            return false
        }
    }

    func isAllJokeUsedWith(type: String) -> Bool {
        var count = 0
        if isDatabaseOpen() {
            let query = "SELECT * FROM jokes WHERE \(ColumnName.JokesTable.type)=\"\(type)\" AND \(ColumnName.JokesTable.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    count += 1
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        if count == 0 {
            return true
        } else {
            return false
        }
    }

    func isJokeUsedWith(jokeId: Int) -> Bool {
        var count = 0
        if isDatabaseOpen() {
            let query = "SELECT * FROM jokes WHERE \(ColumnName.JokesTable.jokeId)=\(jokeId) AND \(ColumnName.JokesTable.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    count += 1
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        if count == 0 {
            return true
        } else {
            return false
        }
    }

    func setJokeUsedWith(jokeId: Int) {
        if isDatabaseOpen() {
            let query = "UPDATE jokes SET \(ColumnName.JokesTable.isUsed)=1 WHERE \(ColumnName.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func setJokeStoredWith(jokeId: Int) {
        if isDatabaseOpen() {
            let query = "UPDATE jokes SET \(ColumnName.JokesTable.isStored)=1 WHERE \(ColumnName.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func setJokeUsedAndStoredWith(jokeId: Int) {
        if isDatabaseOpen() {
            let query = "UPDATE jokes SET \(ColumnName.JokesTable.isUsed)=1, \(ColumnName.JokesTable.isStored)=1 WHERE \(ColumnName.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
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
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func removeStoredJokeWith(jokeId: Int) {
        if isDatabaseOpen() {
            let query = "UPDATE jokes SET \(ColumnName.JokesTable.isStored)=0 WHERE \(ColumnName.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

}
