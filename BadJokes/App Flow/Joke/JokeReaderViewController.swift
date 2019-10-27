//
//  JokeReaderViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 12. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokeReaderViewController: UIViewController {
    // MARK: Properties
    var jokeText = ""

    // MARK: Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblJoke: CopyableLabel!
    @IBOutlet weak var lblEmoji: UILabel!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: Actions
    @IBAction func viewDidDrag(_ sender: UIPanGestureRecognizer) {
        popModalScreen()
    }

    // MARK: - Screen configuration
    private func configureView() {
        containerView.layer.backgroundColor = Theme.Color.lightBlue.cgColor
        containerView.layer.cornerRadius = 8.0

        lblJoke.text = jokeText
        lblJoke.textColor = .white

        lblEmoji.text = ["😃", "😝", "🤣", "😆", "😄", "😅", "😄", "😁"].randomElement()
    }

    // MARK: - Navigation
    private func popModalScreen() {
        dismiss(animated: true)
        performSegue(withIdentifier: .dismissJokeSegue, sender: self)
    }
}
