//
//  Extensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

public extension String {
    func cutLastCharacter() -> Int {
        // Cut down the last letter, e.x. 10x -> 10
        guard let number = Int(self.substring(to: self.index(before: self.endIndex))) else {
            return Int()
        }
        return number
    }
}

public extension UserDefaults {
    func printAllUserDefaulsKeysAndValues() {
        // For debug purpose
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        print("=========================================================")
    }
}
