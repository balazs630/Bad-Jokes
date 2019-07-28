//
//  StoreReviewService.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2019. 01. 10..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import StoreKit

class StoreReviewService {
    // MARK: Properties
    static var runCount: Int {
        get {
            return UserDefaults.standard.value(forKey: UserDefaults.Key.numberOfAppRuns) as? Int ?? 0
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.Key.numberOfAppRuns)
            UserDefaults.standard.synchronize()
        }

    }

    // MARK: Request App Store review
    static func requestImmadiateReview() {
        SKStoreReviewController.requestReview()
    }

    static func requestTimedReview(for trigger: StoreReviewTrigger) {
        if trigger.isActive && trigger.areRulesFulfilled() {
            SKStoreReviewController.requestReview()
            trigger.invalidate()
        }
    }
}
