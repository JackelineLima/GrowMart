//
//  PreferencesCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import UIKit
protocol PreferencesSellCoordinatorProtocol: AnyObject {
    func start()
    func navigateToHome(index category: Int)
}
class PreferencesSellCoordinator: PreferencesSellCoordinatorProtocol {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = PreferencesSellViewModel(coordinator: self)
        let controller = PreferencesSellViewController(viewModel: viewModel)
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func navigateToHome(index category: Int) {
        let coodinator = HomeCoordinator(navigationController: navigationController, category)
        coodinator.start()
    }
}
