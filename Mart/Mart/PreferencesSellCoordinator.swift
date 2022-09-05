//
//  PreferencesCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import UIKit
protocol PreferencesSellCoordinatorProtocol: AnyObject {
    func start()
}
class PreferencesSellCoordinator: PreferencesSellCoordinatorProtocol {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = PreferencesSellViewController(coordinator: self)
//        navigationController.pushViewController(controller, animated: true)
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func navigateToHome() {
        let coodinator = HomeCoordinator(navigationController: navigationController)
        coodinator.start()
    }
}
