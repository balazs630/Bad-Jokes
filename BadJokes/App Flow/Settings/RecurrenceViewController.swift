//
//  RecurrenceViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

protocol RecurrenceViewControllerDelegate: class {
    func saveRecurrence(with selectedOption: Recurrence)
}

class RecurrenceViewController: UITableViewController {
    // MARK: Properties
    private let tableContent: [Recurrence] = [
        .once,
        .twice,
        .threeTimes,
        .fiveTimes,
        .tenTimes
    ]

    weak var delegate: RecurrenceViewControllerDelegate?
    var lastSelectedOption: Recurrence!
    var selectedIndexPath = IndexPath(row: 0, section: 0)

    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restoreTableViewSelection()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveTableViewSelection()
    }
}

// MARK: Setup view
extension RecurrenceViewController {
    private func restoreTableViewSelection() {
        if let index = tableContent.index(of: lastSelectedOption) {
            selectedIndexPath.row = index
        }

        tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .none)
        tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .checkmark
    }

    private func saveTableViewSelection() {
        delegate?.saveRecurrence(with: tableContent[selectedIndexPath.row])
    }
}

// MARK: - TableViewDelegate
extension RecurrenceViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            selectedIndexPath = indexPath
        }
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContent.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "prototypeCell")
        cell.textLabel?.text = tableContent[indexPath.row].rawValue

        return cell
    }
}
