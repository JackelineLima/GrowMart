//
//  EditProfileViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 19/09/22.
//

import Foundation

protocol EditProfileViewModelProtocol {
    func dismiss()
}

class EditProfileViewModel: EditProfileViewModelProtocol {
    
    let coordinator: EditProfileCoordinatorProtocol
    
    init(coordinator: EditProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        coordinator.dismiss()
    }
}
