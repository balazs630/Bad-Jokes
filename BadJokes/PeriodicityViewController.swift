//
//  PeriodicityViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class PeriodicityViewController: UITableViewController {

    var lastSelectedIndexPath = IndexPath(item: 0, section: 0)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.selectRow(at: lastSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        tableView.cellForRow(at: lastSelectedIndexPath)?.accessoryType = .checkmark
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
