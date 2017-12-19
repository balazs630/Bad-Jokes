//
//  JokesViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokeTableViewController: UIViewController, SettingsViewControllerDelegate, JokeNotificationHelperDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: JokesDataSource
    let dbManager = DBManager()
    let jokeNotificationHelper = JokeNotificationHelper()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 113
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        refreshControl.addTarget(self, action: #selector(refreshTableContent), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
        
        jokeNotificationHelper.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refreshTableContent()
    }
    
    func notificationDidFire(with jokeID: Int) {
        dbManager.setJokeUsedAndStoredWith(id: jokeID)
        refreshTableContent()
    }

    @objc func refreshTableContent() {
        self.dataSource = JokesDataSource(jokes: dbManager.getStoredJokes())
        tableView.dataSource = dataSource
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func settingsDidClose() {
        jokeNotificationHelper.applyCurrentNotificationSettings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier {
            
            switch segueIdentifier {
            case SegueIdentifier.showSettings:
                let destVC = segue.destination as! SettingsViewController
                destVC.delegate = self
            case SegueIdentifier.showJoke:
                let destVC = segue.destination as! JokeViewController
                guard let sender = sender as? UITableViewCell else {
                    return
                }
                
                guard let selectedIndex = tableView.indexPath(for: sender) else {
                    return
                }
                
                guard let jokeCell = tableView.cellForRow(at: selectedIndex) as? JokeCell else {
                    return
                }
                
                destVC.jokeText = jokeCell.jokeLabel.text!
            default:
                print("Unexpected segue identifier was given in: \(#file), line: \(#line)")
            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        let jokes = dbManager.getStoredJokes()
        
        self.dataSource = JokesDataSource(jokes: jokes)
        super.init(coder: aDecoder)
    }
}

