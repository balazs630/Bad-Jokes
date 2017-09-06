//
//  JokesViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokesViewController: UIViewController, SettingsViewControllerDelegate {

    let jokeNotificationHelper = JokeNotificationHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Finish this func to work properly

    }

    func settingsDidClose() {
        jokeNotificationHelper.applyCurrentNotificationSettings()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettingsSegue" {
            let destVC = segue.destination as! SettingsViewController
            destVC.delegate = self
        }
    }

}
