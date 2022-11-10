//
//  JokeListBuilder.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation

struct JokeListInputData {
    let apiTarget: APITarget
}

class JokeListModule: ViperBuilder<
    JokeListView,
    JokeListPresenter,
    JokeListInteractor,
    JokeListInputData
> {
    override class func interactorFactory(_ inputData: JokeListInputData?) -> JokeListInteractor {
        guard let inputData = inputData else {
            return JokeListInteractor()
        }
        let interctor = JokeListInteractor()
        interctor.apiTarget = inputData.apiTarget
        return interctor
    }
}
