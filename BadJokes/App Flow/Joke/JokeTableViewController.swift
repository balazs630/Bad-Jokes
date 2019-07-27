//
//  JokeTableViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokeTableViewController: UIViewController {
    // MARK: Properties
    private var dataSource: JokeDataSource!
    private let jokeNotificationService = JokeNotificationService()
    private let refreshControl = UIRefreshControl()

    private let noNotificationScheduledView = UIView.loadFromNib(named: UIView.noNotificationScheduledView)
    private let waitingForFirstNotificationView = UIView.loadFromNib(named: UIView.waitingForFirstNotificationView)

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Initializers
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeNotificationService.delegate = self

        configureRefreshControl()
        setObserverForUIApplicationDidBecomeActive()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
}

// MARK: - Utility
extension JokeTableViewController {
    @objc private func applicationDidBecomeActive() {
        StoreReviewService.runCount += 1
        refreshData()
        refreshNotificationSchedules()
        requestStoreReview()
    }

    @objc private func refreshData() {
        jokeNotificationService.moveDeliveredJokesToJokeCollection()
        fetchDeliveredJokes()
        tableView.reloadData()
        refreshControl.endRefreshing()
        presentEmptyView()
    }

    private func fetchDeliveredJokes() {
        dataSource = JokeDataSource(jokes: DBService.shared.getDeliveredJokes(), didBecomeEmpty: didBecomeEmpty())
        tableView.dataSource = dataSource
    }

    private func refreshNotificationSchedules() {
        let pendingSchedulesCount = DBService.shared.schedulesCount()
        let hasUsedJoke = DBService.shared.hasUsedJoke()

        if pendingSchedulesCount <= Constant.generateNewJokesThreshold && hasUsedJoke {
            jokeNotificationService.setNewRepeatingNotifications()
        }
    }

    private func requestStoreReview() {
        let triggers = [
            StoreReviewTrigger(name: UserDefaults.Key.StoreReviewTrigger.newUser,
                               rules: [.launchCount(3), .storedJokeCount(10)]),
            StoreReviewTrigger(name: UserDefaults.Key.StoreReviewTrigger.oldUser,
                               rules: [.storedJokeCount(50)])
        ]

        triggers.forEach {
            StoreReviewService.requestTimedReview(for: $0)
        }
    }
}

// MARK: - Screen configurationss
private extension JokeTableViewController {
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = .white
        refreshControl.backgroundColor = Theme.Color.lightBlue

        tableView.refreshControl = refreshControl
    }

    private func setObserverForUIApplicationDidBecomeActive() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }

    private func didBecomeEmpty() -> DidBecomeEmpty {
        return {
            self.presentEmptyView()
        }
    }

    private func presentEmptyView() {
        if dataSource.jokes.isEmpty {
            if DBService.shared.isSchedulesListEmpty() {
                displayViewInFrontOfTableView(frontview: noNotificationScheduledView)
            } else {
                displayViewInFrontOfTableView(frontview: waitingForFirstNotificationView)
                waitingForFirstNotificationView.center.y = self.tableView.frame.height / 2
            }
        } else {
            tableView.separatorStyle = .singleLine
            noNotificationScheduledView.removeFromSuperview()
            waitingForFirstNotificationView.removeFromSuperview()
        }
    }

    private func displayViewInFrontOfTableView(frontview view: UIView) {
        view.frame = self.view.bounds
        tableView.addSubview(view)
        tableView.bringSubviewToFront(view)
    }
}

// MARK: - Navigation
extension JokeTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }

        switch segueIdentifier {
        case SegueIdentifier.showSettings:
            guard let destVC = segue.destination as? SettingsViewController else { return }
            destVC.delegate = self
        case SegueIdentifier.showJoke:
            guard let destVC = segue.destination as? JokeReaderViewController,
                let sender = sender as? UITableViewCell,
                let selectedIndex = tableView.indexPath(for: sender),
                let jokeCell = tableView.cellForRow(at: selectedIndex) as? JokeTableViewCell else { return }
            destVC.jokeText = jokeCell.jokeLabel.text!
        default:
            debugPrint("Unexpected segue identifier was given in: \(#file), line: \(#line)")
        }
    }
}

// MARK: JokeNotificationServiceDelegate
extension JokeTableViewController: JokeNotificationServiceDelegate {
    func notificationDidFire() {
        refreshData()
    }
}

// MARK: SettingsViewControllerDelegate
extension JokeTableViewController: SettingsViewControllerDelegate {
    func startJokeGeneratingProcess() {
        jokeNotificationService.setNewRepeatingNotifications()
    }
}
