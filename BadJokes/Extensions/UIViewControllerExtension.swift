//
//  UIViewControllerExtension.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2019. 10. 27..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIViewController {
    func performSegue(withIdentifier identifier: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
}
