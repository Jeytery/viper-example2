//
//  MainCoordinator.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinatorable {
    typealias ReturnEvent = EmptyFinishOuput
    
    var onEventOutput: EventOutput?
    var navigationController: UINavigationController = .init()
    
    init() {
        navigationController.setViewControllers([jokeList.view], animated: false)
        jokeList.delegate = self
    }

    private var jokeIndexPath: IndexPath!
    
    private var jokeList = JokeListModule.build(
        with: .init(apiTarget: API.current)
    )
    
    private var jokeDetail: ViperModule<
        JokeDetailView,
        JokeDetailPresenter,
        JokeDetailInteractor
    >!
}

extension MainCoordinator: JokeListModuleDelegate {
    func jokeList(didTap joke: Joke, at indexPath: IndexPath) {
        self.jokeDetail = JokeDetailModule.build(with: joke)
        self.jokeIndexPath = indexPath
        navigationController.present(jokeDetail.view, animated: true)
        jokeDetail.delegate = self
    }
}

extension MainCoordinator: JokeDetailModuleOutput {
    func jokeDetailDidFinish(with newJoke: Joke) {
        jokeDetail.dismissViewController()
        jokeList.publicInterface.putJoke(newJoke, at: jokeIndexPath.row)
    }
}
