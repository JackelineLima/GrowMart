//
//  EditProfileCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

protocol EditProfileCoordinatorProtocol: AnyObject {
    func start()
}

final class EditProfileCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension EditProfileCoordinator: EditProfileCoordinatorProtocol {
    
    func start() {
        let viewModel = EditProfileViewModel(coordinator: self)
        let controller = EditProfileViewController(viewModel: viewModel)
        navigationController.present(controller, animated: true)
    }
}
