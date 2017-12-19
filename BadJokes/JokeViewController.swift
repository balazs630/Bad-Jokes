//
//  JokeViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 12. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet weak var txtJoke: UITextView!
    var jokeText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtJoke.text = jokeText
    }
    
}
