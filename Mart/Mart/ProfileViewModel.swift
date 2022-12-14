//
//  ProfileViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import Foundation

protocol ProfileViewModelProtocol {
    func navigateToEditPerfil(delegate: EditProfileViewControllerDelegate)
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    let coordinator: ProfileCoordinatorProtocol
    
    init(coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func navigateToEditPerfil(delegate: EditProfileViewControllerDelegate) {
        coordinator.navigateToEditPerfil(delegate: delegate)
    }
}
