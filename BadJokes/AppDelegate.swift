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

        if defaults.object(forKey: UserDefaults.Keys.isAppAlreadyLaunchedOnce) == nil {
            // First launch
            let firstTimeLaunchDefaults: [String : Any] = [
                UserDefaults.Keys.isAppAlreadyLaunchedOnce: true,

                UserDefaults.Keys.Sw.globalOff: false,
                UserDefaults.Keys.Sw.notificationSound: true,

                UserDefaults.Keys.Lbl.periodicity: "Napi",
                UserDefaults.Keys.Lbl.recurrence: "1x",
                UserDefaults.Keys.Lbl.time: "Véletlen időpontban",

                UserDefaults.Keys.Pck.timeHours: "12",
                UserDefaults.Keys.Pck.timeMinutes: "00",

                UserDefaults.Keys.Sld.animal: 10,
                UserDefaults.Keys.Sld.rough: 0,
                UserDefaults.Keys.Sld.IT: 2,
                UserDefaults.Keys.Sld.anti: 6,
                UserDefaults.Keys.Sld.tiring: 10,
                UserDefaults.Keys.Sld.jean: 2,
                UserDefaults.Keys.Sld.moriczka: 6,
                UserDefaults.Keys.Sld.cop: 4,
                UserDefaults.Keys.Sld.blonde: 2
            ]

            for item in firstTimeLaunchDefaults {
                defaults.set(item.value, forKey: item.key)
            }

            defaults.synchronize()
        }

        return true
    }

}
