//
//  UIColorExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 07. 02..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIColor {
    static func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
