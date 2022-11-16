//
//  PreferencesSellViewController.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 04/11/22.
//

import XCTest
@testable import Mart

final class PreferencesSellViewControllerTests: XCTestCase {

    private var sut: PreferencesViewController!
    private var viewModelSpy: PreferencesSellViewModelSpy!

    override func setUpWithError() throws {
        viewModelSpy = PreferencesSellViewModelSpy()
        sut = PreferencesViewController(viewModel: viewModelSpy)
    }

    override func tearDownWithError() throws {
        viewModelSpy = nil
        sut = nil
    }

    func testCallServiceCalled() throws {
        sut.loadView()
        sut.viewDidLoad()
        
        XCTAssertTrue(viewModelSpy.callServiceCalled)
    }
    
    func testNavigateToPreferences() throws {
        sut.loadView()
        sut.viewDidLoad()
        sut.buttonAction(preferences: .others)
        
        XCTAssertTrue(viewModelSpy.navigateToHomeCalled)
    }
    
    func testDelegateCalled() throws {
        sut.loadView()
        sut.viewDidLoad()
        
        XCTAssertTrue(viewModelSpy.delegateCalled)
    }
}
