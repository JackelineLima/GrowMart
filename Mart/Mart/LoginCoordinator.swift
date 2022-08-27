//
//  LoginCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func start()
    func navigateToPreferences()
}
class LoginCoordinator: LoginCoordinatorProtocol {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = LoginViewController(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func navigateToPreferences() {
        let controller = PreferencesSellViewController()
        navigationController.setViewControllers([controller], animated: true)
    }
}
