//
//  UserDefaultsExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 05. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

extension UserDefaults {
    func printAllUserDefaulsKeysAndValues() {
        // For debug purpose
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            debugPrint("\(key) = \(value) \n")
        }
        debugPrint("=========================================================")
    }
}
