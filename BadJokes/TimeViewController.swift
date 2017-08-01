//
//  TimeViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

protocol TimeViewControllerDelegate: class {
    func saveTimeWith(selectedCellText: String)
}

class TimeViewController: UITableViewController {

    @IBOutlet weak var lblRandomTime: UILabel!
    @IBOutlet weak var lblMorning: UILabel!
    @IBOutlet weak var lblAfternoon: UILabel!
    @IBOutlet weak var lblAtGivenTime: UILabel!

    @IBOutlet weak var timePicker: UIDatePicker!

    var lastSelectedIndexPath = IndexPath()
    let randomTimeIndexPath = IndexPath(item: 3, section: 0)
    weak var delegate: TimeViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if lastSelectedIndexPath != randomTimeIndexPath {
            timePicker.isHidden = true
        }

        tableView.selectRow(at: lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        tableView.cellForRow(at: lastSelectedIndexPath)?.accessoryType = .checkmark
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //When navigating to the previous VC with "back" nav bar button
        if (self.isMovingFromParentViewController) {

            switch lastSelectedIndexPath.row {
            case 0:
                delegate?.saveTimeWith(selectedCellText: lblRandomTime.text!)
            case 1:
                delegate?.saveTimeWith(selectedCellText: lblMorning.text!)
            case 2:
                delegate?.saveTimeWith(selectedCellText: lblAfternoon.text!)
            case 3:
                let timeComponents = timePicker.calendar.dateComponents([.hour, .minute], from: timePicker.date)
                if let hourComponent = timeComponents.hour, let minuteComponent = timeComponents.minute {
                    delegate?.saveTimeWith(selectedCellText: "Pontosan \(hourComponent):\(minuteComponent)-kor")
                }
            default:
                print("Unexpected row number was given in: \(#file), line: \(#line)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }

        lastSelectedIndexPath = indexPath

        if randomTimeIndexPath == indexPath {
            timePicker.isHidden = false
        }

    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }

        if randomTimeIndexPath == indexPath {
            timePicker.isHidden = true
        }

    }

}
