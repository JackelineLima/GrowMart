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
        let controller = PreferencesSellViewController()
        navigationController.pushViewController(controller, animated: true)
    }
}
