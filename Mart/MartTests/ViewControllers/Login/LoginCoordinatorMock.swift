//
//  LoginCoordinatorMock.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 05/10/22.
//

@testable import Mart

class LoginCoordinatorMock: LoginCoordinatorProtocol {
    var called = false
    
    func start() {
        called = true
    }
    
    func navigateToPreferences() {
        called = true
    }
}
