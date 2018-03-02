//
//  JokeTableViewController.swift
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
        initTableContent()
    }

    func notificationDidFire() {
        initTableContent()
    }

    @objc func initTableContent() {
        jokeNotificationHelper.checkForDeliveredJokes()
        pullDataIntoDataSource()
        reloadData()
        checkForEmptyTable()
    }

    func pullDataIntoDataSource() {
        dataSource = JokesDataSource(jokes: dbManager.getStoredJokes())
        tableView.dataSource = dataSource
    }

    func reloadData() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func checkForEmptyTable() {
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

    func settingsDidClose(isSettingsChanged: Bool) {
        if isSettingsChanged {
            jokeNotificationHelper.applyNewNotificationSettings()
        }
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

        refreshControl.addTarget(self, action: #selector(initTableContent), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
    }
}
