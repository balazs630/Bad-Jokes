//
//  DBManager.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation
import FMDB

struct Field {

    // Field names in Jokes table
    struct JokesTable {
        static let jokeId = "jokeId"
        static let isUsed = "isUsed"
        static let isStored = "isStored"
        static let type = "type"
        static let jokeText = "jokeText"
    }

    // Field names in Schedules table
    struct SchedulesTable {
        static let jokeId = "jokeId"
        static let time = "time"
    }
}

class DBManager: NSObject {

    static let shared: DBManager = DBManager()

    let dbFileName = "jokesDB"
    let dbExtension = "db"

    var documentsDBPath: String!
    var resourcesDBPath: String!

    var database: FMDatabase!

    override init() {
        super.init()

        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        documentsDBPath = documentsDirectory.appending("/\(dbFileName).\(dbExtension)")
        resourcesDBPath = Bundle.main.path(forResource: dbFileName, ofType: dbExtension)
    }

    func openDatabase() -> Bool {
        if database == nil {
            if !FileManager.default.fileExists(atPath: documentsDBPath) {
                // First launch... Copy the db to make a writable database in the app’s Documents directory
                copyDatabase(from: resourcesDBPath, to: documentsDBPath)
            }
            database = FMDatabase(path: documentsDBPath)
        }

        // Open connection
        if database != nil {
            if database.open() {
                return true
            }
        }

        return false
    }

    private func copyDatabase(from source: String, to destination: String) {
        if !FileManager.default.fileExists(atPath: destination) {
            do {
                try FileManager.default.copyItem(atPath: source, toPath: destination)
            } catch {
                print(error)
            }
        } else {
            print("Database file already exist at: \(destination)")
        }
    }

    func getAllJokes() -> [Joke] {
        var resultsArray = [Joke]()

        if openDatabase() {
            let query = "SELECT * FROM jokes ORDER BY \(Field.JokesTable.jokeId) ASC"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: Field.JokesTable.jokeId)),
                                    isUsed: Int(results.int(forColumn: Field.JokesTable.isUsed)),
                                    isStored: Int(results.int(forColumn: Field.JokesTable.isStored)),
                                    type: results.string(forColumn: Field.JokesTable.type),
                                    jokeText: results.string(forColumn: Field.JokesTable.jokeText))

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

        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.JokesTable.isStored)=1"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: Field.JokesTable.jokeId)),
                                     isUsed: Int(results.int(forColumn: Field.JokesTable.isUsed)),
                                     isStored: Int(results.int(forColumn: Field.JokesTable.isStored)),
                                     type: results.string(forColumn: Field.JokesTable.type),
                                     jokeText: results.string(forColumn: Field.JokesTable.jokeText))

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

        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.JokesTable.type)=\"\(type)\" AND \(Field.JokesTable.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(jokeId: Int(results.int(forColumn: Field.JokesTable.jokeId)),
                                    isUsed: Int(results.int(forColumn: Field.JokesTable.isUsed)),
                                    isStored: Int(results.int(forColumn: Field.JokesTable.isStored)),
                                    type: results.string(forColumn: Field.JokesTable.type),
                                    jokeText: results.string(forColumn: Field.JokesTable.jokeText))

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
        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.JokesTable.isUsed)=0"

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
        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.JokesTable.type)=\"\(type)\" AND \(Field.JokesTable.isUsed)=0"

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
        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.JokesTable.jokeId)=\(jokeId) AND \(Field.JokesTable.isUsed)=0"

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
        if openDatabase() {
            let query = "UPDATE jokes SET \(Field.JokesTable.isUsed)=1 WHERE \(Field.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func setJokeStoredWith(jokeId: Int) {
        if openDatabase() {
            let query = "UPDATE jokes SET \(Field.JokesTable.isStored)=1 WHERE \(Field.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func setJokeUsedAndStoredWith(jokeId: Int) {
        if openDatabase() {
            let query = "UPDATE jokes SET \(Field.JokesTable.isUsed)=1, \(Field.JokesTable.isStored)=1 WHERE \(Field.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func restoreUsedJokesAsNew() {
        if openDatabase() {
            let query = "UPDATE jokes SET \(Field.JokesTable.isUsed)=0"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func removeStoredJokeWith(jokeId: Int) {
        if openDatabase() {
            let query = "UPDATE jokes SET \(Field.JokesTable.isStored)=0 WHERE \(Field.JokesTable.jokeId)=\(jokeId)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

}
