//
//  HomeCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/08/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeCoordinatorProtocol: AnyObject {
    func start()
}

final class HomeCoordinator {
    
    private let navigationController: UINavigationController
    private let categoryIndex: Int
    
    init(navigationController: UINavigationController,_ categoryIndex: Int) {
        self.navigationController = navigationController
        self.categoryIndex = categoryIndex
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self, categoryIndex)
        let controller = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([controller], animated: true)
    }
}
