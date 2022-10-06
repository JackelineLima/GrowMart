//
//  LoginViewController.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 05/10/22.
//

import XCTest
import SnapshotTesting
@testable import Mart

final class LoginViewControllerTests: XCTestCase {
    
    let coodinator = LoginCoordinatorMock()

    func testExample() throws {
        let component = LoginViewController(coordinator: coodinator)
        assertSnapshot(matching: component, as: .image(on: .iPhoneX))
    }
}
