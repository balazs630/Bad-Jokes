//
//  JokesViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokesViewController: UIViewController, SettingsViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource: JokesDataSource
    let dbManager = DBManager()
    let jokeNotificationHelper = JokeNotificationHelper()
    
    required init?(coder aDecoder: NSCoder) {
        let jokes = dbManager.getStoredJokes()
        
        self.dataSource = JokesDataSource(jokes: jokes!)
        super.init(coder: aDecoder)
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

// MARK: UIViewController
extension JokesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 113
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}
