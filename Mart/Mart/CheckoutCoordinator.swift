//
//  CheckoutCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 03/09/22.
//

import UIKit

protocol CheckoutCoordinatorProtocol: AnyObject {
    func start()
}

class CheckoutCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CheckoutCoordinator: CheckoutCoordinatorProtocol {
    
    func start() {
        let viewModel = CheckoutViewModel(coordinator: self)
        let controller = CheckoutViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}
