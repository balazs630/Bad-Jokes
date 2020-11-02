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
        replacingOccurrences(of: "\\n", with: "\n")
    }

    func digits() -> Int? {
        Int(components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }

    func isGreater(than otherVersion: String) -> Bool {
        let result = compare(otherVersion, options: .numeric)
        return result == .orderedDescending
    }
}
