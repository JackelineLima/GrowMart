//
//  AddProductCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 04/10/22.
//

import UIKit

protocol AddProductCoordinatorProtocol: AnyObject {
    func start()
}

final class AddProductCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AddProductCoordinator: AddProductCoordinatorProtocol {
    
    func start() {
        let viewModel = AddProductViewModel(coordinator: self)
        let controller = AddProductViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}
