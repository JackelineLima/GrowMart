//
//  LoginViewTests.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 06/10/22.
//

import XCTest
import SnapshotTesting
@testable import Mart

final class LoginViewTests: XCTestCase {
    
    let componentSize = CGSize(width: 414, height: 307)
    let component = LoginView()
    let sut = LoginViewSpy()
    
    func testRenderView() {
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testeDidTapButtonFacebookShouldDelegate() throws {
        XCTAssertFalse(sut.continueButtonFacebookCalled)
        
        component.delegate = sut
        let loginViewMirror = Mirror(reflecting: component)
        let button = try XCTUnwrap(loginViewMirror.firstLazyChild(of: UIButton.self, in: "facebookButton"))
        button.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(sut.continueButtonFacebookCalled)
    }
    
    func testeDidTapButtonGoogleShouldDelegate() throws {
        XCTAssertFalse(sut.continueButtonGoogleCalled)
        
        component.delegate = sut
        let loginViewMirror = Mirror(reflecting: component)
        let button = try XCTUnwrap(loginViewMirror.firstLazyChild(of: UIButton.self, in: "googleButton"))
        button.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(sut.continueButtonGoogleCalled)
    }

}

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
