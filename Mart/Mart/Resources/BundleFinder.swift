//
//  Bundle+Mart.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/09/22.
//

import Foundation

private class BundleFinder {}

extension Foundation.Bundle {
    static var module: Bundle = {
        return Bundle(for: BundleFinder.self)
    }()
}

@objc
public class MartResources: NSObject {
   @objc public class var bundle: Bundle {
         return .module
   }
}
