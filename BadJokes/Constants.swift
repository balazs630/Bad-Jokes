//
//  Constants.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 12. 10..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

struct Theme {
    struct Color {
        static let lightBlue = UIColor.color(red: 46, green: 122, blue: 246)
    }
}

enum Periodicity: String {
    case daily = "Napi"
    case weekly = "Heti"
    case monthly = "Havi"
}

enum Recurrence: String {
    case once = "1x"
    case twice = "2x"
    case threeTimes = "3x"
    case fiveTimes = "5x"
    case tenTimes = "10x"
}

enum TimeRange: String {
    case random = "Véletlen időpontban"
    case morning = "Délelőtt"
    case afternoon = "Délután"
    case evening = "Este"
    case atGivenTime = "Pontos időpontban"

    var intervallum: ClosedRange<Int> {
        switch self {
        case .random:
            return 9...20
        case .morning:
            return 9...11
        case .afternoon:
            return 12...17
        case .evening:
            return 18...20
        case .atGivenTime:
            fatalError("Given time doesn't have an intervallum")
        }
    }

    func textualRepresentation() -> String {
        switch self {
        case .random, .morning, .afternoon, .evening:
            return "\(intervallum.lowerBound):00 - \(intervallum.upperBound + 1):00 között"
        case .atGivenTime:
            return ""
        }
    }
}

struct SegueIdentifier {
    static let showSettings = "showSettingsSegue"
    static let periodicityDetail = "periodicityDetailSegue"
    static let recurrenceDetail = "recurrenceDetailSegue"
    static let timeDetail = "timeDetailSegue"
    static let showJoke = "showJokeSegue"
}

enum NibName: String {
    case noNotificationScheduledView = "NoNotificationScheduledView"
    case waitingForFirstNotificationView = "WaitingForFirstNotificationView"
    case warningTableHeaderView = "WarningTableHeaderView"
}

// swiftlint:disable type_name
extension UserDefaults {
    struct Key {
        static let isAppAlreadyLaunchedOnce = "isAppAlreadyLaunchedOnce"
        static let appVersion = "appVersion"
        static let numberOfAppRuns = "numberOfAppRuns"

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
            static let geek = "sldGeek"
            static let anti = "sldAnti"
            static let tiring = "sldTiring"
            static let jean = "sldJean"
            static let moricka = "sldMoricka"
            static let cop = "sldCop"
            static let blonde = "sldBlonde"
        }

        struct StoreReviewTrigger {
            static let copyJoke = "copyJokeTextTrigger"
            static let newUser = "newUserTrigger"
            static let oldUser = "oldUserTrigger"
        }
    }
}
// swiftlint:enable type_name

struct Constant {
    static let shortVersionString = "CFBundleShortVersionString"
    static let generateNewJokesThreshold = 32

    static let databaseFileName = "jokesDB"
    static let databaseFileExtension = "db"

    static var sliders: [Int: String] {
        return [
            1: UserDefaults.Key.Sld.animal,
            2: UserDefaults.Key.Sld.rough,
            3: UserDefaults.Key.Sld.geek,
            4: UserDefaults.Key.Sld.anti,
            5: UserDefaults.Key.Sld.tiring,
            6: UserDefaults.Key.Sld.jean,
            7: UserDefaults.Key.Sld.moricka,
            8: UserDefaults.Key.Sld.cop,
            9: UserDefaults.Key.Sld.blonde
        ]
    }

    static var jokeTypes: [String: String] {
        return [
            UserDefaults.Key.Sld.animal: "animal",
            UserDefaults.Key.Sld.rough: "rough",
            UserDefaults.Key.Sld.geek: "geek",
            UserDefaults.Key.Sld.anti: "anti",
            UserDefaults.Key.Sld.tiring: "tiring",
            UserDefaults.Key.Sld.jean: "jean",
            UserDefaults.Key.Sld.moricka: "moricka",
            UserDefaults.Key.Sld.cop: "cop",
            UserDefaults.Key.Sld.blonde: "blonde"
        ]
    }
}
