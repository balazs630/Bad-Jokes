//
//  StoreReviewTrigger.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2019. 01. 13..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import Foundation

class StoreReviewTrigger {
    var name: String
    var rules: [StoreReviewRule]

    init(name: String, rules: [StoreReviewRule]) {
        self.name = name
        self.rules = rules
    }

    var isActive: Bool {
        return UserDefaults.standard.value(forKey: name) as? Bool ?? false
    }

    var areRulesFulfilled: Bool {
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
