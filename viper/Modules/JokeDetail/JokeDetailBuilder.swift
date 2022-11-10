//
//  JokeDetailBuilder.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation

class JokeDetailModule: ViperBuilder<
    JokeDetailView,
    JokeDetailPresenter,
    JokeDetailInteractor,
    Joke
> {
    override class func interceptBuild(
        view: JokeDetailView,
        presenter: JokeDetailPresenter,
        interactor: JokeDetailInteractor,
        inputData: Joke?
    ) {
        guard let joke = inputData else { return }
        presenter.setJoke(joke)
    }
}
