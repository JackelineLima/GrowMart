//
//  LoginViewSpy.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 04/11/22.
//

@testable import Mart

class LoginViewSpy: LoginViewDelegate {
    var continueButtonFacebookCalled = false
    var continueButtonGoogleCalled = false
    
    func continueButtonFacebook() {
        continueButtonFacebookCalled = true
    }
    
    func continueButtonGoogle() {
        continueButtonGoogleCalled = true
    }
}
