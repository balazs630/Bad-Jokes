//
//  Extensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

extension String {
    func formatLineBreaks() -> String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }
}

extension UserDefaults {
    func printAllUserDefaulsKeysAndValues() {
        // For debug purpose
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        print("=========================================================")
    }
}

extension Array {
    func randomIndex() -> Int? {
        if self.isEmpty {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return index
    }

    func randomItem() -> Element? {
        if self.isEmpty {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension TimeInterval {
    func randomSec() -> UInt32 {
        let index = UInt32(arc4random_uniform(UInt32(self)))
        return index
    }

    func isInPast() -> Bool {
        let date = Date(timeIntervalSince1970: self)
        return date.timeIntervalSinceNow.sign == .minus ? true : false
    }
}

extension Date {
    func convertToUnixTimeStamp() -> Int {
        return Int(self.timeIntervalSince1970)
    }
}
