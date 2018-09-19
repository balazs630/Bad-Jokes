//
//  JokeDataSource.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 09. 22..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

typealias DidBecomeEmpty = () -> Void

class JokeDataSource: NSObject {

    // MARK: Properties
    var jokes: [Joke]
    let didBecomeEmpty: DidBecomeEmpty

    // MARK: Initializers
    init(jokes: [Joke], didBecomeEmpty: @escaping DidBecomeEmpty) {
        self.jokes = jokes
        self.didBecomeEmpty = didBecomeEmpty
    }
}

// MARK: - TableViewDataSource
extension JokeDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: JokeTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? JokeTableViewCell else {
            fatalError("JokeTableViewCell cannot be found")
        }
        let joke = jokes[indexPath.row]
        cell.jokeText = joke.jokeText.formatLineBreaks()
        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            DBService.shared.removeDeliveredJokeWith(jokeId: jokes[indexPath.row].jokeId)
            jokes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

            if jokes.isEmpty {
                didBecomeEmpty()
            }
        }
    }
}
