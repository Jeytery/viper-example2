//
//  JokeListView.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation
import UIKit
import SnapKit

protocol JokeListViewUIOutput: AnyObject {
    func viewOnceLoaded()
    func tableView(didTap joke: Joke, at indexPath: IndexPath)
}

protocol JokeListViewInput: AnyObject {
    func displayJokes(_ jokes: Jokes)
    func putJoke(_ joke: Joke, index: Int)
    
    func startLoading()
    func stopLoading()
    func showError()
}

protocol JokeListModuleDelegate: AnyObject {
    func jokeList(didTap joke: Joke, at indexPath: IndexPath)
}

class JokeListView: UIViewController, ViperView {
    weak var uiEventOutput: JokeListViewUIOutput?

    required init() {
        super.init(nibName: nil, bundle: nil)
        addTableView()
        setupSpinner()
        title = "Jokes app"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isAppeared { return }
        isAppeared = true
        uiEventOutput?.viewOnceLoaded()
    }

    // state data
    private var isAppeared = false
    private var jokes = Jokes()
    
    // ui
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let spinner = UIActivityIndicatorView()
}

private extension JokeListView {
    func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupSpinner() {
        view.addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        spinner.hidesWhenStopped = true
    }
}

extension JokeListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return jokes.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath)
        cell.textLabel?.text = jokes[indexPath.row].name
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        uiEventOutput?.tableView(
            didTap: jokes[indexPath.row],
            at: indexPath)
    }
}

extension JokeListView: JokeListViewInput {
    func putJoke(_ joke: Joke, index: Int) {
        jokes.remove(at: index)
        jokes.insert(joke, at: index)
        tableView.reloadData()
    }
    
    func showError() {}
    
    func displayJokes(_ jokes: Jokes) {
        self.jokes = jokes
        tableView.reloadData()
    }
    
    func startLoading() {
        spinner.startAnimating()
    }
    
    func stopLoading() {
        spinner.stopAnimating()
    }
}

