//
//  AppCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 01/10/22.
//


import Foundation
import UIKit

class ApplicationCoordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController = {
         let navigationController = UINavigationController()
         return navigationController
     }()
    private var coordinator: LoginCoordinatorProtocol?
    
    init(window: UIWindow) {
        self.window = window
        let coordinator = LoginCoordinator(navigationController: rootViewController)
        coordinator.start()
        window.makeKeyAndVisible()
        self.coordinator = coordinator
    }
    
    func start() {
        window.rootViewController = rootViewController
        startMigrationLaunchScreen()
        window.makeKeyAndVisible()
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    private func startMigrationLaunchScreen() {
//        let controller = MigrationLaunchScreenFactory.make(navigationController: rootViewController, userCpf: userCpf)
//        rootViewController.pushViewController(controller, animated: false)
    }
}
