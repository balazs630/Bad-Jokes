//
//  UIViewExtensions.swift
//  BadJokes
//
//  Created by Balázs Horváth on 2020. 11. 06..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIView {
    func addOverlayingSubView(view customView: UIView) {
        guard !customView.isDescendant(of: self) else { return }

        customView.frame = bounds
        addSubview(customView)
        bringSubviewToFront(customView)
    }
}
