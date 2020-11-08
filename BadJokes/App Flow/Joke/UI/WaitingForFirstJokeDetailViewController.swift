//
//  WaitingForFirstJokeDetailViewController.swift
//  BadJokes
//
//  Created by Balázs Horváth on 2020. 11. 06..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

class WaitingForFirstJokeDetailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var notificationReminderContainerView: UIView!
    @IBOutlet private weak var notificationReminderLabel: UILabel!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationReminder()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupNotificationReminder()
    }

    // MARK: - Setup appearance
    private func setupNotificationReminder() {
        notificationReminderContainerView.layer.cornerRadius = 20
        notificationReminderLabel.attributedText = {
            var boldFont: UIFont!
            if #available(iOS 11.0, *) {
                boldFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: .boldSystemFont(ofSize: 17))
            } else {
                boldFont = .boldSystemFont(ofSize: 17)
            }
            let tipTextAttributes = [NSAttributedString.Key.font: boldFont!]
            let boldTipText = NSMutableAttributedString(
                string: "Tipp: ",
                attributes: tipTextAttributes
            )

            let descriptionTextAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
            let descriptionText = NSAttributedString(
                string: "Hagyd bekapcsolva az értesítéseket, hogy a viccek célba érjenek!",
                attributes: descriptionTextAttributes
            )
            boldTipText.append(descriptionText)

            return boldTipText
        }()
    }

    // MARK: Actions
    @IBAction func closeButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
}
