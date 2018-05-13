//
//  JokesDataSource.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 09. 22..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

typealias DidBecomeEmpty = () -> Void

class JokesDataSource: NSObject {
    var jokes: [Joke]
    let didBecomeEmpty: DidBecomeEmpty

    init(jokes: [Joke], didBecomeEmpty: @escaping DidBecomeEmpty) {
        self.jokes = jokes
        self.didBecomeEmpty = didBecomeEmpty
    }
}

extension JokesDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: JokeCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? JokeCell else {
            fatalError("JokeCell cannot be found")
        }
        let joke = jokes[indexPath.row]
        cell.jokeText = joke.jokeText.formatLineBreaks()
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            DBManager.shared.removeDeliveredJokeWith(jokeId: jokes[indexPath.row].jokeId)
            jokes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

            if jokes.isEmpty {
                didBecomeEmpty()
            }
        }
    }
}
