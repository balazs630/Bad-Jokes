//
//  PeriodicityViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

protocol PeriodicityViewControllerDelegate: class {
    func savePeriodicityWith(selectedCellText: String)
}

class PeriodicityViewController: UITableViewController {
    // MARK: Properties
    private let tableContent = [
        Periodicity.daily,
        Periodicity.weekly,
        Periodicity.monthly
    ]

    var lastSelectedOption = ""
    var selectedIndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: PeriodicityViewControllerDelegate?

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
extension PeriodicityViewController {
    private func restoreTableViewSelection() {
        if let index = tableContent.index(of: lastSelectedOption) {
            selectedIndexPath.row = index
        }

        tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .none)
        tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .checkmark
    }

    private func saveTableViewSelection() {
        delegate?.savePeriodicityWith(selectedCellText: tableContent[selectedIndexPath.row])
    }
}

// MARK: - TableViewDelegate
extension PeriodicityViewController {
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
        cell.textLabel?.text = tableContent[indexPath.row]

        return cell
    }
}
