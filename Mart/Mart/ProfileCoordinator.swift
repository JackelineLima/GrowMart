//
//  ProfileCoordinator.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func start()
    func navigateToEditPerfil(delegate: EditProfileViewControllerDelegate)
}

final class ProfileCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    
    func start() {
        let viewModel = ProfileViewModel(coordinator: self)
        let controller = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func navigateToEditPerfil(delegate: EditProfileViewControllerDelegate) {
        let coordinator = EditProfileCoordinator(navigationController: navigationController)
        coordinator.start(delegate: delegate)
    }
}
