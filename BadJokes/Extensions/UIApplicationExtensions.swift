//
//  UIApplicationExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2019. 07. 28..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIApplication {
    public static func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else {
            debugPrint("Cannot open 'UIApplication.openSettingsURLString'")
            return
        }

        UIApplication.shared.open(url)
    }
}
