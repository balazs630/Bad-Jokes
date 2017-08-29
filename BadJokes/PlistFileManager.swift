//
//  PlistFileManager.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 26..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

class PlistFileManager {

    let fileManager = FileManager.default

    func getRandomJokeWith(type: String) -> String {
        // TODO: Beállított feltételeknek megfelelően visszaad egy viccet

        var randomJoke = String()

        if let fileUrl = Bundle.main.url(forResource: "jokes", withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                if let jokes = result?["jokes"] as? [NSDictionary] {
                    if let joke = jokes[0]["joke"] {
                        randomJoke = joke as! String
                    }
                }
            }
        }

        return randomJoke
    }

    func isAllJokeUsed() -> Bool {
        // TODO: Annak a megállapítása hogy az összes viccet kiküldük-e már egyszer
        return false
    }

    func isAllJokeUsedWith(type: String) -> Bool {
        // TODO: Annak a megállapítása hogy az adott vicc típusból az összes viccet kiküldük-e már egyszer
        return false
    }

    func isJokeUsedWith(id: Int) -> Bool {
        // TODO: Annak a megállapítása hogy az adott id-val rendelkező viccet kiküldtük-e már egyszer
        return false
    }

    func setjokeUsedWith(id: Int) {
        // TODO: Az adott vicc isUsed attribútumának true-ra állítása
    }

    func restoreUsedJokesAsNew() {
        // TODO: Az összes vicc isUsed attribútumának false-ra állítása
    }

    func getStoredJokes() -> NSMutableDictionary {
        // TODO: A korábban kiküldött és elmentett vicceket adja vissza
        return NSMutableDictionary()
    }

    func removeStoredJokeWith(id: Int) {
        // TODO: Ha a tárolt viccek táblázatból törlünk egy sort akkor az adott vicc isStored=false átállítása
    }

}

enum PlistManagerError: Error {
    case fileDoesNotExist
    case fileUnavailable
    case keyValuePairAlreadyExists
    case keyValuePairDoesNotExist
}
