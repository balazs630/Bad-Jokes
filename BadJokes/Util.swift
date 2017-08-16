//
//  Util.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 17..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

class Util {
    
    class func printAllUserDefaulsKeysAndValues() {
        // For debug purpose
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        print("=========================================================")
    }

}
