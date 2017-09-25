//
//  JokesDataSource.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 09. 22..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokesDataSource: NSObject {
    let jokes: [Joke]
    
    init(jokes: [Joke]) {
        self.jokes = jokes
    }
}

extension JokesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JokeCell.self)) as! JokeCell
        let joke = jokes[indexPath.row]
        cell.jokeText = joke.jokeText
        return cell
    }
}
