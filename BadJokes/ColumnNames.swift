//
//  ColumnNames.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 02. 28..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

struct ColumnName {
    struct JokesTable {
        static let jokeId = "jokeId"
        static let isUsed = "isUsed"
        static let isStored = "isStored"
        static let type = "type"
        static let jokeText = "jokeText"
    }

    struct SchedulesTable {
        static let jokeId = "jokeId"
        static let time = "time"
    }
}
