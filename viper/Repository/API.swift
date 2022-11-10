//
//  API.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation

typealias ResultCompletion<ReturType, ErrorType: Error> = (Result<ReturType, ErrorType>) -> Void

protocol APITarget {
    func getJokes(completion: @escaping ResultCompletion<Jokes, Error>)
}

class MockAPI: APITarget {
    func getJokes(completion: @escaping ResultCompletion<Jokes, Error>) {
        let jokes: Jokes = [
            .init(name: "joke1", body: "body1"),
            .init(name: "Base programming joke", body: "Hello from world!"),
            .init(name: "Language joke", body: "C-- is better than C++"),
            .init(name: "joke2", body: "C-- is the best programming language"),
            .init(name: "joke3", body: "jokebody"),
            .init(name: "someJoke", body: "1"),
            .init(name: "joke4", body: "jbody"),
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(jokes))
        }
    }
}

class API {
    static let current: APITarget = MockAPI()
}
