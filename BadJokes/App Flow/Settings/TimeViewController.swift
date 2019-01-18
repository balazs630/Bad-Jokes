//
//  TimeViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

protocol TimeViewControllerDelegate: class {
    func saveTimeWithSelected(cellText: String)
    func saveTimeWithSelected(cellText: String, hours: String, minutes: String)
}

class TimeViewController: UITableViewController {
    // MARK: Properties
    private let tableContent = [
        Time.random,
        Time.morning,
        Time.afternoon,
        Time.evening,
        Time.atGivenTime
    ]

    private let tableDetailContent = [
        Time.Detail.random,
        Time.Detail.morning,
        Time.Detail.afternoon,
        Time.Detail.evening,
        Time.Detail.atGivenTime
    ]

    private var selectedIndexPath = IndexPath(row: 0, section: 0)
    private let givenTimeIndexPath = IndexPath(item: 4, section: 0)

    weak var delegate: TimeViewControllerDelegate?
    var lastSelectedOption = ""
    var lastSelectedTime = Date()

    // MARK: - Outlets
    @IBOutlet weak var timePicker: UIDatePicker!

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
extension TimeViewController {
    private func restoreTableViewSelection() {
        if let index = tableContent.index(of: lastSelectedOption) {
            selectedIndexPath.row = index
        }

        timePicker.date = lastSelectedTime
        if selectedIndexPath != givenTimeIndexPath {
            timePicker.isHidden = true
        }

        tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .none)
        tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .checkmark
    }

    private func saveTableViewSelection() {
        if selectedIndexPath == givenTimeIndexPath {
            let timeComponents = timePicker.calendar.dateComponents([.hour, .minute], from: timePicker.date)
            if let hourComponent = timeComponents.hour, let minuteComponent = timeComponents.minute {
                delegate?.saveTimeWithSelected(cellText: tableContent[selectedIndexPath.row],
                                               hours: String(format: "%02d", hourComponent),
                                               minutes: String(format: "%02d", minuteComponent)
                )
            }
        } else {
            delegate?.saveTimeWithSelected(cellText: tableContent[selectedIndexPath.row])
        }
    }
}

// MARK: - TableViewDelegate
extension TimeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }

        selectedIndexPath = indexPath

        if givenTimeIndexPath == indexPath {
            timePicker.isHidden = false
        }
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }

        if givenTimeIndexPath == indexPath {
            timePicker.isHidden = true
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContent.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "prototypeCell")
        cell.textLabel?.text = tableContent[indexPath.row]
        cell.detailTextLabel?.text = tableDetailContent[indexPath.row]

        return cell
    }
}
