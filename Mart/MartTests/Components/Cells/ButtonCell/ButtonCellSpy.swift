//
//  File.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 05/10/22.
//

@testable import Mart

class ButtonCellSpy: ButtonCellDelegate {
    
    var didTapButtonCalled = false
    
    func didTapButton() {
        didTapButtonCalled = true
    }
    
    func resetFlags() {
        didTapButtonCalled = false
    }
}
