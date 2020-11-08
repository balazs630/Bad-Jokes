//
//  WaitingForFirstJokeViewController.swift
//  BadJokes
//
//  Created by Balázs Horváth on 2020. 11. 03..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

class WaitingForFirstJokeViewController: UIViewController {
    // MARK: Properties
    private lazy var descriptionLabel = UILabel()
    private lazy var questionButton = UIButton()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDescriptionLabel()
        setupQuestionButton()
    }

    // MARK: - Setup appearance
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

    private func setupQuestionButton() {
        let buttonImage = UIImage(named: "question-mark")
        questionButton.setImage(buttonImage, for: .normal)
        questionButton.contentMode = .scaleAspectFit

        view.addSubview(questionButton)
        questionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionButton.widthAnchor.constraint(equalToConstant: 50),
            questionButton.heightAnchor.constraint(equalToConstant: 50),
            questionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30)
        ])

        questionButton.addTarget(self, action: #selector(questionButtonTap), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func questionButtonTap() {
        let detailScreen = UIStoryboard.jokes.instantiateViewController(WaitingForFirstJokeDetailViewController.self)
        present(detailScreen, animated: true)
    }
}
