//
//  TimeRangeViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

protocol TimeRangeViewControllerDelegate: class {
    func saveTimeRange(with selectedOption: TimeRange)
    func saveTimeRange(with selectedOption: TimeRange, hours: String, minutes: String)
}

class TimeRangeViewController: UITableViewController {
    // MARK: Properties
    private let tableContent: [TimeRange] = [
        .random,
        .morning,
        .afternoon,
        .evening,
        .atGivenTime
    ]

    private var selectedIndexPath = IndexPath(row: 0, section: 0)
    private let givenTimeIndexPath = IndexPath(item: 4, section: 0)

    weak var delegate: TimeRangeViewControllerDelegate?
    var lastSelectedOption: TimeRange!
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
extension TimeRangeViewController {
    private func restoreTableViewSelection() {
        if let index = tableContent.firstIndex(of: lastSelectedOption) {
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
                delegate?.saveTimeRange(with: tableContent[selectedIndexPath.row],
                                        hours: String(format: "%02d", hourComponent),
                                        minutes: String(format: "%02d", minuteComponent)
                )
            }
        } else {
            delegate?.saveTimeRange(with: tableContent[selectedIndexPath.row])
        }
    }
}

// MARK: - TableViewDelegate
extension TimeRangeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        selectedIndexPath = indexPath

        if givenTimeIndexPath == indexPath {
            timePicker.isHidden = false
        }
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none

        if givenTimeIndexPath == indexPath {
            timePicker.isHidden = true
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContent.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "prototypeCell")
        cell.textLabel?.text = tableContent[indexPath.row].rawValue
        cell.detailTextLabel?.text = tableContent[indexPath.row].textualRepresentation()

        return cell
    }
}
