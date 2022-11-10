//
//  Coordinator.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation
import UIKit

struct CoordinatorComponents {
    private let navigationController = UINavigationController()
}

protocol Coordinatorable: EventOutputable {
    var navigationController: UINavigationController { get }
}

enum DateFinishOuput<T> {
    case finished(T)
}

enum EmptyFinishOuput {
    case finished
}
