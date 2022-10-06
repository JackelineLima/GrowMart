//
//  Tests.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 05/10/22.
//

import XCTest
import SnapshotTesting
@testable import Mart

class SegmentedBarTests: XCTestCase {
    
    private let componentSize = CGSize(width: 414, height: 45)
    private let sut = SegmentedBarSpy()
    
    override func setUp() {
//        SnapshotTesting.isRecording = true
    }
    
    func testButtonCodeNil() {
        let component = SegmentedBar(coder: .init())
        XCTAssertNil(component)
    }
    
    func testRenderSegmentedWithTwoElements() {
        let component = SegmentedBar(collections: ["roupas", "acessórios"], index: 0)
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testRenderSegmentedWithThreeElements() {
        let component = SegmentedBar(collections: ["roupas", "acessórios", "outros"], index: 0)
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testRenderSegmentedWithFourElements() {
        let component = SegmentedBar(collections: ["primeiro", "segundo", "terceiro", "quarto"], index: 0)
        assertSnapshot(matching: component, as: .image(size: componentSize))
        
        XCTAssertFalse(sut.didTapSegmented)

        component.delegate = sut
        component.sendActions(for: .valueChanged)

        XCTAssertTrue(sut.didTapSegmented)
    }

}

class SegmentedBarSpy: SegmentedBarDelegate {
    var didTapSegmented = false
    
    func didTapSegmented(index: Int) {
        didTapSegmented = true
    }
}
