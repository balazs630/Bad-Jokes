//
//  UserDefaultsKeys.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {

    static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"

    struct Sw {
        static let globalOff = "swGlobalOff"
        static let notificationSound = "swNotificationSound"
    }

    struct Lbl {
        static let periodicity = "lblPeriodicity"
        static let recurrence = "lblRecurrence"
        static let time = "lblTime"
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

    static var sldDictionaty: [String : String] {
        return [
            "sldAnimal": "animal",
            "sldRough": "rough",
            "sldIT": "IT",
            "sldAnti": "anti",
            "sldTiring": "tiring",
            "sldJean": "jean",
            "sldMoriczka": "moriczka",
            "sldCop": "cop",
            "sldBlonde": "blonde"
        ]
    }
}
