//
//  PreferencesSellViewControllerSpy.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 04/11/22.
//

import Foundation
@testable import Mart

class PreferencesSellViewControllerSpy: PreferencesSellViewControllerDelegate {
    var renderButtonsCalled = false
    
    func renderButtons(categories: [Mart.CategoryResponse]?) {
        renderButtonsCalled = true
    }
}
