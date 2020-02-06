//
//  UIApplicationExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2019. 07. 28..
//  Copyright © 2019. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIApplication {
    static func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else {
            debugPrint("Cannot open 'UIApplication.openSettingsURLString'")
            return
        }

        UIApplication.shared.open(url)
    }

    // swiftlint:disable line_length
    class func topMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = base as? UINavigationController {
            return topMostViewController(base: navigationController.visibleViewController)

        } else if let tabBarController = base as? UITabBarController, let selected = tabBarController.selectedViewController {
            return topMostViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }

        return base
    }
}
