//
//  EditProfileCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

protocol EditProfileCoordinatorProtocol: AnyObject {
    func start(delegate: EditProfileViewControllerDelegate)
    func dismiss()
}

final class EditProfileCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension EditProfileCoordinator: EditProfileCoordinatorProtocol {
    
    func start(delegate: EditProfileViewControllerDelegate) {
        let viewModel = EditProfileViewModel(coordinator: self)
        let controller = EditProfileViewController(viewModel: viewModel)
        controller.delegate = delegate
        navigationController.pushViewController(controller, animated: true)
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
