//
//  CopyableLabel.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 06. 22..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

class CopyableLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    func sharedInit() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.showMenu)))
    }

    @objc func showMenu(sender: AnyObject?) {
        self.becomeFirstResponder()

        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy)
    }

    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = self.text
        UIMenuController.shared.setMenuVisible(false, animated: true)
        requestStoreReview()
    }

    private func requestStoreReview() {
        let trigger = StoreReviewTrigger(name: UserDefaults.Key.StoreReviewTrigger.copyJoke, rules: [])
        StoreReviewService.requestTimedReview(for: trigger)
    }
}
