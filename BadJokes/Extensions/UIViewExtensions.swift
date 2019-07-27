//
//  UIViewExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 07. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView {
        guard let nib = UINib(nibName: name, bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first as? UIView else {
                fatalError("Couldn't load nib with name: \(name)!")
        }

        return nib
    }
}
