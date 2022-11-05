//
//  PreferencesSellCoodinatorSpy.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 04/11/22.
//

import Foundation
@testable import Mart

class PreferencesSellCoodinatorSpy: PreferencesSellCoordinatorProtocol {
    var startCalled = false
    var navigateToHomeCalled = false
    func start() {
        startCalled = true
    }
    
    func navigateToHome(index category: Int) {
        navigateToHomeCalled = true
    }
}
