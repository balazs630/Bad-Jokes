//
//  RecurrenceViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

protocol RecurrenceViewControllerDelegate: class {
    func saveRecurrenceWith(selectedCellText: String)
}

class RecurrenceViewController: UITableViewController {

    let tableContent = ["1x", "2x", "3x", "5x", "10x", "20x"]

    var lastSelectedOption = String()
    var selectedIndexPath = IndexPath(row: 0, section: 0)

    weak var delegate: RecurrenceViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Set the row index of the last selected option
        if let index = tableContent.index(of: lastSelectedOption) {
            selectedIndexPath.row = index
        }

        tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .checkmark
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //When navigating to the previous VC with "back" nav bar button
        delegate?.saveRecurrenceWith(selectedCellText: tableContent[selectedIndexPath.row])
    }

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
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "prototypeCell")
        cell.textLabel?.text = tableContent[indexPath.row]

        return cell
    }

}
