//
//  StringExtensions.swift
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

    func cutLastCharacter() -> Int {
        // Cut down the last letter, e.x. 10x -> 10 and returns as an Int
        let splitIndex = index(before: endIndex)
        guard let number = Int(self.prefix(upTo: splitIndex)) else {
            return 1
        }

        return number
    }

    func isGreater(than otherVersion: String) -> Bool {
        let result = self.compare(otherVersion, options: .numeric)
        return result == .orderedDescending
    }
}
