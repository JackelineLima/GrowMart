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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    
    func start() {
        let controller = HomeViewController(coordinator: self)
        navigationController.setViewControllers([controller], animated: true)
    }
}
