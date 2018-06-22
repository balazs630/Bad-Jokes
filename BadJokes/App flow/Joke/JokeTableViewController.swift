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
    var dataSource: JokesDataSource!
    let jokeNotificationHelper = JokeNotificationHelper()
    let refreshControl = UIRefreshControl()

    var noNotificationScheduledView: UIView {
        return UIView.makeNoNotificationScheduledView()
    }

    var waitingForFirstNotificationView: UIView {
        return UIView.makeWaitingForFirstNotificationView()
    }

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIApplicationDidBecomeActive,
                                                  object: nil)
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setJokeNotificationHelperDelegate()
        setObserverForUIApplicationDidBecomeActive()
    }

    override func viewWillAppear(_ animated: Bool) {
        initTableContent()
    }

    // MARK: - Setup
    @objc private func initTableContent() {
        jokeNotificationHelper.moveDeliveredJokesToJokeCollection()
        pullDataIntoDataSource()
        tableView.reloadData()
        refreshControl.endRefreshing()
        presentEmptyView()
    }

    private func pullDataIntoDataSource() {
        dataSource = JokesDataSource(jokes: DBManager.shared.getDeliveredJokes(), didBecomeEmpty: didBecomeEmpty())
        tableView.dataSource = dataSource
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case SegueIdentifier.showSettings:
                guard let destVC = segue.destination as? SettingsViewController else { return }
                destVC.delegate = self

            case SegueIdentifier.showJoke:
                guard let destVC = segue.destination as? JokeViewController else { return }
                guard let sender = sender as? UITableViewCell else { return }
                guard let selectedIndex = tableView.indexPath(for: sender) else { return }

                guard let jokeCell = tableView.cellForRow(at: selectedIndex) as? JokeCell else { return }
                destVC.jokeText = jokeCell.jokeLabel.text!

            default:
                debugPrint("Unexpected segue identifier was given in: \(#file), line: \(#line)")
            }
        }
    }
}

// MARK: - Screen configuration
private extension JokeTableViewController {
    private func configureTableView() {
        tableView.estimatedRowHeight = 113
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
        tableView.reloadData()

        refreshControl.addTarget(self, action: #selector(initTableContent), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func setObserverForUIApplicationDidBecomeActive() {
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

    private func presentEmptyView() {
        if dataSource.jokes.isEmpty {
            // Display a message instead of an empty table
            if DBManager.shared.isSchedulesListEmpty() {
                displayViewInFrontOfTableView(frontview: noNotificationScheduledView)
            } else {
                displayViewInFrontOfTableView(frontview: waitingForFirstNotificationView)
            }
        } else {
            noNotificationScheduledView.removeFromSuperview()
            waitingForFirstNotificationView.removeFromSuperview()
        }
    }

    private func displayViewInFrontOfTableView(frontview view: UIView) {
        tableView.addSubview(view)
        tableView.bringSubview(toFront: view)
    }
}

// MARK: JokeNotificationHelperDelegate
extension JokeTableViewController: JokeNotificationHelperDelegate {
    private func setJokeNotificationHelperDelegate() {
        jokeNotificationHelper.delegate = self
    }

    func notificationDidFire() {
        initTableContent()
    }
}

// MARK: SettingsViewControllerDelegate
extension JokeTableViewController: SettingsViewControllerDelegate {
    func startJokeGeneratingProcess() {
        jokeNotificationHelper.setNewRepeatingNotifications()
    }
}
