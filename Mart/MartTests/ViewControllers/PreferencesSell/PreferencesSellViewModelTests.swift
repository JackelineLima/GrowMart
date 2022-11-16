//
//  PreferencesSellViewModelTests.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 04/11/22.
//

import XCTest
@testable import Mart

final class PreferencesSellViewModelTests: XCTestCase {
    
    private var sut: PreferencesViewModel!
    private var viewSpy: PreferencesSellViewControllerSpy!
    private var coordinatorSpy: PreferencesSellCoodinatorSpy!

    override func setUpWithError() throws {
        coordinatorSpy = PreferencesSellCoodinatorSpy()
        sut = PreferencesViewModel(coordinator: coordinatorSpy)
    }

    override func tearDownWithError() throws {
        sut = nil
        viewSpy = nil
        coordinatorSpy = nil
        
    }

    func testNavigateToHomeCalled() throws {

        sut.navigateToHome(index: 2)
        
        XCTAssertTrue(coordinatorSpy.navigateToHomeCalled)
    }
}
