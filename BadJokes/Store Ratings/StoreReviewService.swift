//
//  StoreReviewService.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2019. 01. 10..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import StoreKit

// MARK: Request App Store review
class StoreReviewService {
    class func requestImmadiateReview() {
        SKStoreReviewController.requestReview()
    }

    class func requestTimedReview(for trigger: StoreReviewTrigger) {
        if trigger.isActive && trigger.areRulesFulfilled {
            SKStoreReviewController.requestReview()
            trigger.invalidate()
        }
    }
}

// MARK: Utility
extension StoreReviewService {
    static var runCount: Int {
        return UserDefaults.standard.value(forKey: UserDefaults.Key.numberOfAppRuns) as? Int ?? 0
    }

    static var lastAppInstallDate: Date? {
        guard let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return nil
        }

        do {
            return try FileManager.default.attributesOfItem(atPath: documentsUrl.path)[.creationDate] as? Date
        } catch {
            return nil
        }
    }

    class func incrementAppRuns() {
        UserDefaults.standard.set(runCount + 1, forKey: UserDefaults.Key.numberOfAppRuns)
        UserDefaults.standard.synchronize()
    }
}
