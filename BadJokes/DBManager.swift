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

    // Field names in Joke table
    struct Jokes {
        static let id = "id"
        static let isUsed = "isUsed"
        static let isStored = "isStored"
        static let type = "type"
        static let jokeText = "jokeText"
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

    func getAllJokes() -> [Joke]! {
        var resultsArray = [Joke]()

        if openDatabase() {
            let query = "SELECT * FROM jokes ORDER BY \(Field.Jokes.id) ASC"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(id: Int(results.int(forColumn: Field.Jokes.id)),
                                    isUsed: Int(results.int(forColumn: Field.Jokes.isUsed)),
                                    isStored: Int(results.int(forColumn: Field.Jokes.isStored)),
                                    type: results.string(forColumn: Field.Jokes.type),
                                    jokeText: results.string(forColumn: Field.Jokes.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        return resultsArray
    }

    func getStoredJokes() -> [Joke]! {
        var resultsArray = [Joke]()

        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.Jokes.isStored)=1"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(id: Int(results.int(forColumn: Field.Jokes.id)),
                                     isUsed: Int(results.int(forColumn: Field.Jokes.isUsed)),
                                     isStored: Int(results.int(forColumn: Field.Jokes.isStored)),
                                     type: results.string(forColumn: Field.Jokes.type),
                                     jokeText: results.string(forColumn: Field.Jokes.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        return resultsArray
    }

    func getRandomJokeWith(type: String) -> Joke! {
        var resultsArray = [Joke]()

        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.Jokes.type)=\"\(type)\" AND \(Field.Jokes.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(id: Int(results.int(forColumn: Field.Jokes.id)),
                                    isUsed: Int(results.int(forColumn: Field.Jokes.isUsed)),
                                    isStored: Int(results.int(forColumn: Field.Jokes.isStored)),
                                    type: results.string(forColumn: Field.Jokes.type),
                                    jokeText: results.string(forColumn: Field.Jokes.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        guard let randomIndex = resultsArray.randomIndex() else {
            return nil
        }
        setJokeUsedAndStoredWith(id: resultsArray[randomIndex].id)
        print("resultArray count: \(resultsArray.count), randomindex: \(randomIndex)")

        return resultsArray[randomIndex]
    }

    func isAllJokeUsed() -> Bool {
        var resultsArray = [Joke]()

        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.Jokes.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(id: Int(results.int(forColumn: Field.Jokes.id)),
                                    isUsed: Int(results.int(forColumn: Field.Jokes.isUsed)),
                                    isStored: Int(results.int(forColumn: Field.Jokes.isStored)),
                                    type: results.string(forColumn: Field.Jokes.type),
                                    jokeText: results.string(forColumn: Field.Jokes.jokeText))
                    resultsArray.append(joke)
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        if resultsArray.count == 0 {
            return true
        } else {
            return false
        }
    }

    func isAllJokeUsedWith(type: String) -> Bool {
        var resultsArray = [Joke]()

        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.Jokes.type)=\"\(type)\" AND \(Field.Jokes.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(id: Int(results.int(forColumn: Field.Jokes.id)),
                                    isUsed: Int(results.int(forColumn: Field.Jokes.isUsed)),
                                    isStored: Int(results.int(forColumn: Field.Jokes.isStored)),
                                    type: results.string(forColumn: Field.Jokes.type),
                                    jokeText: results.string(forColumn: Field.Jokes.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        if resultsArray.count == 0 {
            return true
        } else {
            return false
        }
    }

    func isJokeUsedWith(id: Int) -> Bool {
        var resultsArray = [Joke]()

        if openDatabase() {
            let query = "SELECT * FROM jokes WHERE \(Field.Jokes.id)=\(id) AND \(Field.Jokes.isUsed)=0"

            do {
                let results = try database.executeQuery(query, values: nil)

                while results.next() {
                    let joke = Joke(id: Int(results.int(forColumn: Field.Jokes.id)),
                                    isUsed: Int(results.int(forColumn: Field.Jokes.isUsed)),
                                    isStored: Int(results.int(forColumn: Field.Jokes.isStored)),
                                    type: results.string(forColumn: Field.Jokes.type),
                                    jokeText: results.string(forColumn: Field.Jokes.jokeText))

                    resultsArray.append(joke)
                }
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }

        if resultsArray.count == 0 {
            return true
        } else {
            return false
        }
    }

    func setJokeUsedWith(id: Int) {
        if openDatabase() {
            let query = "UPDATE jokes SET \(Field.Jokes.isUsed)=1 WHERE \(Field.Jokes.id)=\(id)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func setJokeStoredWith(id: Int) {
        if openDatabase() {
            let query = "UPDATE jokes SET \(Field.Jokes.isStored)=1 WHERE \(Field.Jokes.id)=\(id)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func setJokeUsedAndStoredWith(id: Int) {
        if openDatabase() {
            let query = "UPDATE jokes SET \(Field.Jokes.isUsed)=1, \(Field.Jokes.isStored)=1 WHERE \(Field.Jokes.id)=\(id)"

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
            let query = "UPDATE jokes SET \(Field.Jokes.isUsed)=0"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

    func removeStoredJokeWith(id: Int) {
        if openDatabase() {
            let query = "UPDATE jokes SET \(Field.Jokes.isStored)=0 WHERE \(Field.Jokes.id)=\(id)"

            do {
                try database.executeUpdate(query, values: nil)
            } catch {
                print(error.localizedDescription)
            }

            database.close()
        }
    }

}
