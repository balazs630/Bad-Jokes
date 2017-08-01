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

    @IBOutlet weak var lblDaily: UILabel!
    @IBOutlet weak var lblWeekly: UILabel!
    @IBOutlet weak var lblMonthly: UILabel!

    var lastSelectedIndexPath = IndexPath()
    weak var delegate: PeriodicityViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.selectRow(at: lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        tableView.cellForRow(at: lastSelectedIndexPath)?.accessoryType = .checkmark
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //When navigating to the previous VC with "back" nav bar button
        if (self.isMovingFromParentViewController) {

            switch lastSelectedIndexPath.row {
            case 0:
                delegate?.savePeriodicityWith(selectedCellText: lblDaily.text!)
            case 1:
                delegate?.savePeriodicityWith(selectedCellText: lblWeekly.text!)
            case 2:
                delegate?.savePeriodicityWith(selectedCellText: lblMonthly.text!)
            default:
                print("Unexpected row number was given in: \(#file), line: \(#line)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            lastSelectedIndexPath = indexPath
        }
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

}
