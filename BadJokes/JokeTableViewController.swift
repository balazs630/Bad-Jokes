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

    var dataSource: JokesDataSource!
    let dbManager = DBManager()
    let jokeNotificationHelper = JokeNotificationHelper()
    let refreshControl = UIRefreshControl()
    let noNotificationScheduledView = Bundle.main.loadNibNamed(UIView.noNotificationScheduledView, owner: nil, options: nil)!.first as! UIView
    let waitingForFirstNotificationView = Bundle.main.loadNibNamed(UIView.waitingForFirstNotificationView, owner: nil, options: nil)?.first as! UIView

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        jokeNotificationHelper.delegate = self
        addNotificationObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        initTableContent()
    }

    func notificationDidFire() {
        initTableContent()
    }

    @objc func initTableContent() {
        jokeNotificationHelper.checkForDeliveredJokes()
        pullDataIntoDataSource()
        tableView.reloadData()
        refreshControl.endRefreshing()
        presentEmptyView()
    }

    func pullDataIntoDataSource() {
        dataSource = JokesDataSource(jokes: dbManager.getStoredJokes(), didBecomeEmpty: didBecomeEmpty())
        tableView.dataSource = dataSource
    }

    func presentEmptyView() {
        if dataSource.jokes.isEmpty {
            // Display a message instead of an empty table
            if dbManager.isSchedulesListEmpty() {
                displayViewInFrontOfTableView(frontview: noNotificationScheduledView)
            } else {
                displayViewInFrontOfTableView(frontview: waitingForFirstNotificationView)
            }
        } else {
            noNotificationScheduledView.removeFromSuperview()
            waitingForFirstNotificationView.removeFromSuperview()
        }
    }

    func displayViewInFrontOfTableView(frontview view: UIView) {
        tableView.addSubview(view)
        tableView.bringSubview(toFront: view)
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
        super.init(coder: aDecoder)
    }

    deinit {
        // Remove the observer when this view controller is dismissed/deallocated
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIApplicationDidBecomeActive,
                                                  object: nil)
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

    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(initTableContent),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
    }

    private func didBecomeEmpty() -> DidBecomeEmpty {
        return {
            self.presentEmptyView()
        }
    }
}
