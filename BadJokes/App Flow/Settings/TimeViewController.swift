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
    let tableContent = [Time.random,
                        Time.morning,
                        Time.afternoon,
                        Time.evening,
                        Time.atGivenTime]

    let tableDetailContent = [Time.Detail.random,
                              Time.Detail.morning,
                              Time.Detail.afternoon,
                              Time.Detail.evening,
                              Time.Detail.atGivenTime]

    var lastSelectedOption = String()
    var lastSelectedTime = Date()
    var selectedIndexPath = IndexPath(row: 0, section: 0)
    let givenTimeIndexPath = IndexPath(item: 4, section: 0)
    weak var delegate: TimeViewControllerDelegate?

    // MARK: - Outlets
    @IBOutlet weak var timePicker: UIDatePicker!

    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Set the row index of the last selected option
        if let index = tableContent.index(of: lastSelectedOption) {
            selectedIndexPath.row = index
        }

        timePicker.date = lastSelectedTime

        // Hide time picker if not the last choice is selected
        if selectedIndexPath != givenTimeIndexPath {
            timePicker.isHidden = true
        }

        tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
        tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .checkmark
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if selectedIndexPath == givenTimeIndexPath {
            // Time picker is active
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
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "prototypeCell")
        cell.textLabel?.text = tableContent[indexPath.row]
        cell.detailTextLabel?.text = tableDetailContent[indexPath.row]

        return cell
    }
}
