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

    @IBOutlet weak var lbl1x: UILabel!
    @IBOutlet weak var lbl2x: UILabel!
    @IBOutlet weak var lbl3x: UILabel!
    @IBOutlet weak var lbl5x: UILabel!
    @IBOutlet weak var lbl10x: UILabel!
    @IBOutlet weak var lbl20x: UILabel!

    var lastSelectedIndexPath = IndexPath()
    weak var delegate: RecurrenceViewControllerDelegate?

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
                delegate?.saveRecurrenceWith(selectedCellText: lbl1x.text!)
            case 1:
                delegate?.saveRecurrenceWith(selectedCellText: lbl2x.text!)
            case 2:
                delegate?.saveRecurrenceWith(selectedCellText: lbl3x.text!)
            case 3:
                delegate?.saveRecurrenceWith(selectedCellText: lbl5x.text!)
            case 4:
                delegate?.saveRecurrenceWith(selectedCellText: lbl10x.text!)
            case 5:
                delegate?.saveRecurrenceWith(selectedCellText: lbl20x.text!)
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
