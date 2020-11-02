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

    private let noNotificationScheduledView = UINib.loadView(named: .noNotificationScheduledView)
    private let waitingForFirstNotificationView = UINib.loadView(named: .waitingForFirstNotificationView)

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        setObserverForUIApplicationDidBecomeActive()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateEmptyViewFrames()
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
        dataSource = JokeDataSource(jokes: DBService.shared.deliveredJokes(), didBecomeEmpty: didBecomeEmpty())
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
        [
            StoreReviewTrigger(
                name: UserDefaults.Key.StoreReviewTrigger.newUser,
                rules: [.launchCount(3), .storedJokeCount(10)]
            ),
            StoreReviewTrigger(
                name: UserDefaults.Key.StoreReviewTrigger.oldUser,
                rules: [.storedJokeCount(50)]
            )
        ].forEach {
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }

    private func didBecomeEmpty() -> DidBecomeEmpty {
        return {
            self.presentEmptyView()
        }
    }

    private func presentEmptyView() {
        removeEmptyViews()
        tableView.separatorStyle = dataSource.jokes.isEmpty ? .none : .singleLine

        guard dataSource.jokes.isEmpty else { return }

        DBService.shared.isSchedulesListEmpty()
            ? displayViewInFrontOfTableView(frontview: noNotificationScheduledView)
            : displayViewInFrontOfTableView(frontview: waitingForFirstNotificationView)
    }

    private func displayViewInFrontOfTableView(frontview view: UIView) {
        tableView.addSubview(view)
        tableView.bringSubviewToFront(view)
    }

    private func removeEmptyViews() {
        noNotificationScheduledView.removeFromSuperview()
        waitingForFirstNotificationView.removeFromSuperview()
    }

    private func updateEmptyViewFrames() {
        noNotificationScheduledView.frame = UIScreen.main.bounds
        waitingForFirstNotificationView.frame = UIScreen.main.bounds
    }
}

// MARK: - Navigation
extension JokeTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let rawIdentifier = segue.identifier,
              let segueIdentifier = SegueIdentifier(rawValue: rawIdentifier)
        else { return }

        switch segueIdentifier {
        case .showSettingsSegue:
            guard let navigationController = segue.destination as? UINavigationController,
                  let destVC = navigationController.viewControllers.first as? SettingsViewController
            else { return }
            destVC.delegate = self
        case .showJokeSegue:
            guard let destVC = segue.destination as? JokeReaderViewController,
                  let sender = sender as? UITableViewCell,
                  let selectedIndex = tableView.indexPath(for: sender),
                  let jokeCell = tableView.cellForRow(at: selectedIndex) as? JokeTableViewCell,
                  let jokeText = jokeCell.jokeLabel.text
            else { return }
            destVC.jokeText = jokeText
            tableView.removeRowSelections()
        default:
            debugPrint("Unexpected segue identifier was given in: \(#file), line: \(#line)")
        }
    }
}

// MARK: SettingsViewControllerDelegate
extension JokeTableViewController: SettingsViewControllerDelegate {
    func startJokeGeneratingProcess() {
        jokeNotificationService.setNewRepeatingNotifications()
        presentEmptyView()
    }
}
