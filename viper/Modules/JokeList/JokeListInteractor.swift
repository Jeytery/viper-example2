//
//  JokeInteractor.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation

protocol JokeListInteractorInput: AnyObject {
    func getJokes()
}

protocol JokeListInteractorOutput: AnyObject {
    func interactor(didGet jokes: Jokes)
    func interactor(didGetError error: Error)
    
    func interactorStartLoading()
    func interactorStopLoading()
}

class JokeListInteractor: ViperInteractor {
    weak var eventOutput: JokeListInteractorOutput!
    
    // public set with fabrica
    var apiTarget: APITarget!
    
    required init() {}
}

extension JokeListInteractor: JokeListInteractorInput {
    func getJokes() {
        eventOutput.interactorStartLoading()
        apiTarget.getJokes {
            result in
            switch result {
            case .success(let jokes):
                // some buisness logic with jokes
                // caching, filtering etc...
                self.eventOutput.interactor(didGet: jokes)
                break
            case .failure(let error):
                self.eventOutput.interactor(didGetError: error)
                break
            }
            self.eventOutput.interactorStopLoading()
        }
    }
}
