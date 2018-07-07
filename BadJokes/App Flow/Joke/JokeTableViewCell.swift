//
//  JokeTableViewCell.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 09. 22..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    @IBOutlet weak var jokeLabel: UILabel!

    var jokeText: String? {
        didSet {
            jokeLabel.text = jokeText
        }
    }
}
