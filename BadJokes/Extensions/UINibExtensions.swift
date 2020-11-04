//
//  UINibExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 07. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension UINib {
    static let warningTableHeaderView = loadView(named: "WarningTableHeaderView")

    static func loadView(named name: String, bundle: Bundle? = nil) -> UIView {
        guard let view = UINib(nibName: name, bundle: bundle)
            .instantiate(withOwner: nil)
            .first as? UIView else {
                fatalError("Couldn't load nib with name: \(name)!")
        }

        return view
    }
}
