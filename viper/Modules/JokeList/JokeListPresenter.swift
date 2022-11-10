//
//  JokePresenter.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation

protocol JokeListPublicInterface: AnyObject {
    func putJoke(_ joke: Joke, at index: Int)
}

class JokeListPresenter: ViperPresenter {    
    required init() {
        self.publicInterface = self
    }
    
    weak var viewInput: JokeListViewInput!
    weak var interactorInput: JokeListInteractorInput!
    weak var publicInterface: JokeListPublicInterface!
    weak var moduleDelegate: JokeListModuleDelegate?
}

extension JokeListPresenter: JokeListViewUIOutput {
    func tableView(didTap joke: Joke, at indexPath: IndexPath) {
        moduleDelegate?.jokeList(didTap: joke, at: indexPath)
    }
    
    func viewOnceLoaded() {
        interactorInput.getJokes()
    }
}

extension JokeListPresenter: JokeListInteractorOutput {
    func interactor(didGet jokes: Jokes) {
        viewInput.displayJokes(jokes)
    }
    
    func interactor(didGetError error: Error) {
        viewInput.showError()
    }
    
    func interactorStartLoading() {
        viewInput.startLoading()
    }
    
    func interactorStopLoading() {
        viewInput.stopLoading()
    }
}

extension JokeListPresenter: JokeListPublicInterface {
    func putJoke(_ joke: Joke, at index: Int) {
        viewInput.putJoke(joke, index: index)
    }
}
