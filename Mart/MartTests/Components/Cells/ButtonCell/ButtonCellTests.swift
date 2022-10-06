//
//  ButtonCellTests.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 05/10/22.
//

import XCTest
import SnapshotTesting
@testable import Mart

class ButtonCellTests: XCTestCase {
    
    private let componentSize = CGSize(width: 414, height: 85)
    private lazy var buttonCellSpy = ButtonCellSpy()
    let component = ButtonCell()
    
    override func setUp() {
//        SnapshotTesting.isRecording = true
        buttonCellSpy.resetFlags()
    }
    
    func testButtonCodeNil() {
        let component = ButtonCell(coder: .init())
        XCTAssertNil(component)
    }
    
    func testRenderDefaultStyle() {
        
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testRenderBlackTitle() {
        component.setTitle("salvar dados", color: .black)
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testTapButtonShouldCallDelegate() throws {
        XCTAssertFalse(buttonCellSpy.didTapButtonCalled)

        component.delegate = buttonCellSpy

        let buttonCellMirrored = Mirror(reflecting: component)
        let button = try XCTUnwrap(buttonCellMirrored.firstChild(of: UIButton.self))
        button.sendActions(for: .touchUpInside)

        XCTAssertTrue(buttonCellSpy.didTapButtonCalled)
    }
}
