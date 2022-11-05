//
//  PreferencesSellViewModelSpy.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 04/11/22.
//

import Foundation
@testable import Mart

class PreferencesSellViewModelSpy: PreferencesSellViewModelProtocol {
    var callServiceCalled = false
    var navigateToHomeCalled = false
    var delegateCalled = false
    
    func callService() {
        callServiceCalled = true
    }
    
    func navigateToHome(index category: Int) {
        navigateToHomeCalled = true
    }
    
    func delegate(_ delegate: Mart.PreferencesSellViewControllerDelegate) {
        delegateCalled = true
    }
}
