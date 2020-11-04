//
//  WaitingForFirstJokeViewController.swift
//  BadJokes
//
//  Created by Balázs Horváth on 2020. 11. 03..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

class WaitingForFirstJokeViewController: UIViewController {
    private lazy var descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDescriptionLabel()
    }

    private func setupDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .preferredFont(forTextStyle: .title1)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.text = "Hamarosan\nkacagni fogsz... 😃"

        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
