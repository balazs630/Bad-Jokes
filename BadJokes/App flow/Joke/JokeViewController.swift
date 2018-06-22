//
//  JokeViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 12. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {

    // MARK: Properties
    var jokeText = ""

    // MARK: Outlets
    @IBOutlet weak var lblJoke: CopyableLabel!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblJoke.text = jokeText
    }

}
