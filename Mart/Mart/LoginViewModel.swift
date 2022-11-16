//
//  LoginViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 07/11/22.
//

import UIKit

protocol LoginViewModelProtocol {
    
}

class LoginViewModel: LoginViewModelProtocol {
    
    let coordinator: LoginCoordinatorProtocol
    
    init(coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
