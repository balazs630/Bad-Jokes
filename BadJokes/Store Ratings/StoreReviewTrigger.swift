//
//  StoreReviewTrigger.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2019. 01. 13..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Foundation

class StoreReviewTrigger {
    // MARK: Properties
    private var name: String
    private var rules: [StoreReviewRule]

    public var isActive: Bool {
        return UserDefaults.standard.value(forKey: name) as? Bool ?? false
    }

    // MARK: Initializers
    init(name: String, rules: [StoreReviewRule]) {
        self.name = name
        self.rules = rules
    }

    // MARK: Utility methods
    func areRulesFulfilled() -> Bool {
        for rule in rules {
            switch rule {
            case let .storedJokeCount(threshold):
                if DBService.shared.storedJokesCount() < threshold {
                    return false
                }
            case let .launchCount(threshold):
                if StoreReviewService.runCount < threshold {
                    return false
                }
            }
        }

        return true
    }

    func invalidate() {
        UserDefaults.standard.set(false, forKey: name)
    }
}
