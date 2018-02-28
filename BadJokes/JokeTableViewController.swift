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
        configureTableView()
        jokeNotificationHelper.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        refreshTableContent()
    }

    func notificationDidFire() {
        refreshTableContent()
    }

    @objc func refreshTableContent() {
        jokeNotificationHelper.checkForDeliveredJokes()

        self.dataSource = JokesDataSource(jokes: dbManager.getStoredJokes())
        tableView.dataSource = dataSource
        tableView.reloadData()
        refreshControl.endRefreshing()

        if tableView.visibleCells.isEmpty {
            // Display a message instead of an empty table
            let emptyStateLabel = UILabel()
            emptyStateLabel.text = "Nem találhatóak korábbi viccek!"
            emptyStateLabel.textAlignment = .center

            tableView.separatorStyle = .none
            tableView.backgroundView = emptyStateLabel
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
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

extension JokeTableViewController {
    private func configureTableView() {
        tableView.estimatedRowHeight = 113
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
        tableView.reloadData()

        refreshControl.addTarget(self, action: #selector(refreshTableContent), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
    }
}
