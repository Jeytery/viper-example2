//
//  JokeDetailPresenter.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation

protocol JokeDetailPublicInterface: AnyObject {
    func setJoke(_ joke: Joke)
}

protocol JokeDetailModuleOutput: AnyObject {
    func jokeDetailDidFinish(with joke: Joke)
}

class JokeDetailPresenter: ViperPresenter {
    required init() {
        self.publicInterface = self
    }
    
    weak var viewInput: JokeDetailViewInput!
    weak var interactorInput: JokeDetailInteractorInput!
    weak var publicInterface: JokeDetailPublicInterface!
    weak var moduleDelegate: JokeDetailModuleOutput?
    
    var joke = Joke(name: "", body: "")
}

extension JokeDetailPresenter: JokeDetailPublicInterface {
    func setJoke(_ joke: Joke) {
        viewInput.setJoke(joke)
        self.joke = joke
    }
}

extension JokeDetailPresenter: JokeDetailViewUIEventOutput {
    func didTapOkButton(with: String) {
        let newJoke = Joke(name: with, body: self.joke.body)
        moduleDelegate?.jokeDetailDidFinish(with: newJoke)
    }
}

