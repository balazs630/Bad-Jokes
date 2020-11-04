//
//  NoJokeScheduledViewController.swift
//  BadJokes
//
//  Created by Balázs Horváth on 2020. 11. 03..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

class NoJokeScheduledViewController: UIViewController {
    private lazy var arrowImageView = UIImageView()
    private lazy var descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupArrowImageView()
        setupDescriptionLabel()
    }

    private func setupArrowImageView() {
        arrowImageView.image = UIImage(named: "arrow-dashed-long")
        arrowImageView.contentMode = .scaleAspectFit

        view.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            arrowImageView.topAnchor.constraint(equalTo: view.topAnchor),
            arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor, multiplier: 0.5)
        ])
    }

    private func setupDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .preferredFont(forTextStyle: .title1)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.text = "Te milyen vicceket\nszeretsz? 😁"

        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: arrowImageView.bottomAnchor, constant: 20)
        ])
    }
}
