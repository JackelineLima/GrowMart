//
//  PreferencesCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 23/08/22.
//

import UIKit
protocol PreferencesCoordinatorProtocol: AnyObject {
    func start()
    func navigateToHome(index category: Int)
}
class PreferencesCoordinator: PreferencesCoordinatorProtocol {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = PreferencesViewModel(coordinator: self)
        let controller = PreferencesViewController(viewModel: viewModel)
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func navigateToHome(index category: Int) {
        let coodinator = HomeCoordinator(navigationController: navigationController, category)
        let coodinatorTab = TabBarCoodinator(navigationController: navigationController, category)
        coodinatorTab.start()
//        coodinator.start()
    }
}
