//
//  Date&Time.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 03. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

extension Date {
    class TimePart {
        var hour: Int
        var minute: Int

        init(hour: Int = 0, minute: Int = 0) {
            self.hour = hour
            self.minute = minute
        }
    }
}
