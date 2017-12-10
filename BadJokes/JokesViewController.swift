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
    
    var dataSource: JokesDataSource
    let dbManager = DBManager()
    let jokeNotificationHelper = JokeNotificationHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 113
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshTableContent),
                                               name: NotificationIdentifier.notificationWillFire,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refreshTableContent()
    }
    
    @objc func refreshTableContent() {
        self.dataSource = JokesDataSource(jokes: dbManager.getStoredJokes())
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func settingsDidClose() {
        jokeNotificationHelper.applyCurrentNotificationSettings()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showSettings {
            let destVC = segue.destination as! SettingsViewController
            destVC.delegate = self
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        let jokes = dbManager.getStoredJokes()
        
        self.dataSource = JokesDataSource(jokes: jokes)
        super.init(coder: aDecoder)
    }
}

