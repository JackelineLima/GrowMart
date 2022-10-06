//
//  UIButtonPreferencesTests.swift
//  MartTests
//
//  Created by Jackeline Pires De Lima on 05/10/22.
//

import XCTest
import SnapshotTesting
@testable import Mart

final class UIButtonPreferencesTests: XCTestCase {
    
    let componentSize = CGSize(width: 414, height: 100)

    func testeButtonWithImageLeft() throws {
    
        let component = UIButtonPreferences(.left,
                                            nameLabel: "Roupas",
                                            imageName: "clothes")
        assertSnapshot(matching: component,
                       as: .image(size: componentSize))
    }
    
    func testeButtonWithImageRight() throws {
        let component = UIButtonPreferences(.right,
                                            nameLabel: "Roupas",
                                            imageName: "clothes")
        assertSnapshot(matching: component,
                       as: .image(size: componentSize))
    }

}
