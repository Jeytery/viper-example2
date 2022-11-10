//
//  AppDelegate.swift
//  viper
//
//  Created by Jeytery on 08.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let mainCoordinator = MainCoordinator()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator.navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
