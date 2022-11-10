//
//  JokeDetailInteractor.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation

protocol JokeDetailInteractorOutput: AnyObject {}
protocol JokeDetailInteractorInput: AnyObject {}

class JokeDetailInteractor: ViperInteractor {
    weak var eventOutput: InteractorOutput!
    typealias InteractorOutput = JokeDetailInteractorOutput
    required init() {}
}
