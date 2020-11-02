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
    public var jokes: [Joke]
    private let didBecomeEmpty: DidBecomeEmpty

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

        cell.jokeText = jokes[indexPath.row].jokeText

        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        DBService.shared.removeDeliveredJokeWith(jokeId: jokes[indexPath.row].jokeId)
        jokes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)

        if jokes.isEmpty {
            didBecomeEmpty()
        }
    }
}
