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

struct Time {
    static let random = "Véletlen időpontban"
    static let morning = "Délelőtt"
    static let afternoon = "Délután"
    static let evening = "Este"
    static let atGivenTime = "Pontos időpontban"

    struct Hour {
        static let morningStart = "09:00"
        static let afternoonStart = "12:00"
        static let eveningStart = "18:00"
        static let nightStart = "21:00"
    }

    struct Detail {
        static let random = "09:00 - 21:00 között"
        static let morning = "09:00 - 12:00 között"
        static let afternoon = "12:00 - 18:00 között"
        static let evening = "18:00 - 21:00 között"
        static let atGivenTime = ""
    }
}

class TimeViewController: UITableViewController {

    @IBOutlet weak var timePicker: UIDatePicker!

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Set the row index of the last selected option
        if let index = tableContent.index(of: lastSelectedOption) {
            selectedIndexPath.row = index
        }

        // Set timePicker's value to the last selected value
        timePicker.date = lastSelectedTime

        // Hide time picker if not the last choice is selected
        if selectedIndexPath != givenTimeIndexPath {
            timePicker.isHidden = true
        }

        tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .checkmark
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //When navigating to the previous VC with "back" nav bar button

        if selectedIndexPath == givenTimeIndexPath {
            // Time picker is active
            let timeComponents = timePicker.calendar.dateComponents([.hour, .minute], from: timePicker.date)
            if let hourComponent = timeComponents.hour, let minuteComponent = timeComponents.minute {
                if minuteComponent == 0 {
                    //TODO: Rewrite with proper dateformatter
                    delegate?.saveTimeWithSelected(cellText: tableContent[selectedIndexPath.row], hours: String(hourComponent), minutes: "00")
                } else {
                    delegate?.saveTimeWithSelected(cellText: tableContent[selectedIndexPath.row], hours: String(hourComponent), minutes: String(minuteComponent))
                }
            }
        } else {
            delegate?.saveTimeWithSelected(cellText: tableContent[selectedIndexPath.row])
        }
    }

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
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "prototypeCell")
        cell.textLabel?.text = tableContent[indexPath.row]
        cell.detailTextLabel?.text = tableDetailContent[indexPath.row]

        return cell
    }

}
