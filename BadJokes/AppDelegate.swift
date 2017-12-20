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

        if defaults.object(forKey: UserDefaults.Key.isAppAlreadyLaunchedOnce) == nil {
            // First launch
            let firstTimeLaunchDefaults: [String : Any] = [
                UserDefaults.Key.isAppAlreadyLaunchedOnce: true,

                UserDefaults.Key.Sw.globalOff: false,
                UserDefaults.Key.Sw.notificationSound: true,

                UserDefaults.Key.Lbl.periodicity: "Napi",
                UserDefaults.Key.Lbl.time: "Véletlen időpontban",

                UserDefaults.Key.Pck.timeHours: "12",
                UserDefaults.Key.Pck.timeMinutes: "00",

                UserDefaults.Key.Sld.animal: 10,
                UserDefaults.Key.Sld.rough: 0,
                UserDefaults.Key.Sld.IT: 2,
                UserDefaults.Key.Sld.anti: 6,
                UserDefaults.Key.Sld.tiring: 10,
                UserDefaults.Key.Sld.jean: 2,
                UserDefaults.Key.Sld.moriczka: 6,
                UserDefaults.Key.Sld.cop: 4,
                UserDefaults.Key.Sld.blonde: 2
            ]

            for item in firstTimeLaunchDefaults {
                defaults.set(item.value, forKey: item.key)
            }

            defaults.synchronize()
        }

        return true
    }

}
