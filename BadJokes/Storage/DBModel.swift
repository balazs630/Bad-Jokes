//
//  Tables+Fields.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 06. 25..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

struct Table {
    // Table names
    static let jokes = "jokes"
    static let schedules = "schedules"
}

extension Table {
    // Fields in tables
    struct Jokes {
        static let jokeId = "jokeId"
        static let isUsed = "isUsed"
        static let deliveryTime = "deliveryTime"
        static let type = "type"
        static let jokeText = "jokeText"
    }

    struct Schedules {
        static let jokeId = "jokeId"
        static let time = "time"
    }
}
