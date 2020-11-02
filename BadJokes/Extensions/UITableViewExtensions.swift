//
//  UITableViewExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2019. 10. 06..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

extension UITableView {
    func removeRowSelections() {
        indexPathsForSelectedRows?.forEach {
            deselectRow(at: $0, animated: true)
        }
    }
}
