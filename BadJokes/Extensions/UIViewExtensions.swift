//
//  UIViewExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 05. 17..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIView {
    // swiftlint:disable force_cast

    static func makeNoNotificationScheduledView() -> UIView {
        return Bundle.main.loadNibNamed(UIView.noNotificationScheduledView,
                                        owner: nil,
                                        options: nil)?.first as! UIView
    }

    static func makeWaitingForFirstNotificationView() -> UIView {
        return Bundle.main.loadNibNamed(UIView.waitingForFirstNotificationView,
                                               owner: nil,
                                               options: nil)?.first as! UIView
    }

}
