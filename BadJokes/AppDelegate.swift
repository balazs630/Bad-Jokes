//
//  AppDelegate.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let defaults = UserDefaults.standard

        if defaults.object(forKey: UserDefaultsKeys.isAppAlreadyLaunchedOnce) == nil {
            // First launch
            let firstTimeLaunchDefaults: [String : Any] = [
                UserDefaultsKeys.isAppAlreadyLaunchedOnce: true,

                UserDefaultsKeys.Sw.globalOff: false,
                UserDefaultsKeys.Sw.notificationSound: true,

                UserDefaultsKeys.Lbl.periodicity: "Napi",
                UserDefaultsKeys.Lbl.recurrence: "1x",
                UserDefaultsKeys.Lbl.time: "Véletlen időpontban",

                UserDefaultsKeys.Pck.timeHours: "12",
                UserDefaultsKeys.Pck.timeMinutes: "00",

                UserDefaultsKeys.Sld.animal: 10,
                UserDefaultsKeys.Sld.rough: 0,
                UserDefaultsKeys.Sld.IT: 2,
                UserDefaultsKeys.Sld.anti: 6,
                UserDefaultsKeys.Sld.tiring: 10,
                UserDefaultsKeys.Sld.jean: 2,
                UserDefaultsKeys.Sld.moriczka: 6,
                UserDefaultsKeys.Sld.cop: 4,
                UserDefaultsKeys.Sld.blonde: 2
            ]

            for item in firstTimeLaunchDefaults {
                defaults.set(item.value, forKey: item.key)
            }

            defaults.synchronize()
        }

        return true
    }

}
