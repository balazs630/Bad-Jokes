//
//  Constants.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 12. 10..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit
import Foundation

struct SegueIdentifier {
    static let showSettings = "showSettingsSegue"
    static let periodicityDetail = "periodicityDetailSegue"
    static let recurrenceDetail = "recurrenceDetailSegue"
    static let timeDetail = "timeDetailSegue"
    static let showJoke = "showJokeSegue"
}

struct NotificationIdentifier {
    static let JokesTableDidBecomeEmpty = NSNotification.Name("jokesTableDidBecomeEmpty")
}

extension UIView {
    static let noNotificationScheduledView = "NoNotificationScheduledView"
    static let waitingForFirstNotificationView = "WaitingForFirstNotificationView"
}

extension UserDefaults {
    struct Key {
        static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"

        struct Sw {
            static let globalOff = "swGlobalOff"
        }

        struct Lbl {
            static let periodicity = "lblPeriodicity"
            static let time = "lblTime"
            static let recurrence = "lblRecurrence"
        }

        struct Pck {
            static let timeHours = "pckTimeHours"
            static let timeMinutes = "pckTimeMinutes"
        }

        struct Sld {
            static let animal = "sldAnimal"
            static let rough = "sldRough"
            static let IT = "sldIT"
            static let anti = "sldAnti"
            static let tiring = "sldTiring"
            static let jean = "sldJean"
            static let moriczka = "sldMoriczka"
            static let cop = "sldCop"
            static let blonde = "sldBlonde"
        }
    }

    static var sldDictionaty: [String: String] {
        return [
            UserDefaults.Key.Sld.animal: "animal",
            UserDefaults.Key.Sld.rough: "rough",
            UserDefaults.Key.Sld.IT: "IT",
            UserDefaults.Key.Sld.anti: "anti",
            UserDefaults.Key.Sld.tiring: "tiring",
            UserDefaults.Key.Sld.jean: "jean",
            UserDefaults.Key.Sld.moriczka: "moriczka",
            UserDefaults.Key.Sld.cop: "cop",
            UserDefaults.Key.Sld.blonde: "blonde"
        ]
    }
}
