//
//  PreferencesCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import UIKit
protocol PreferencesCoordinatorProtocol: AnyObject {
    func start()
}
class PreferencesCoordinator: PreferencesCoordinatorProtocol {
    private var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let controller = PreferencesViewController()
        navigationController.pushViewController(controller, animated: true)
    }
}
